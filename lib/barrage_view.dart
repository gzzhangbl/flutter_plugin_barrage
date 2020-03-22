import 'dart:async';

import 'package:barrage/barrage_data_controller.dart';
import 'package:barrage/barrage_item_model.dart';
import 'package:flutter/material.dart';

class BarrageMainView extends StatefulWidget {
  final OnPressed onItemPressed;
  final Key key;
  final double width;
  final double height;
  final int channel;
  final int speed;
  final Widget videoView;
  final BarrageDataController _controller;

  BarrageMainView(this.width, this.height, this.videoView, this._controller,
      {this.key, this.channel = 5, this.speed = 120, this.onItemPressed})
      : super(key: key) {
    this._controller
      ..width = this.width
      ..channel = this.channel
      ..speed = this.speed;
  }

  @override
  State<StatefulWidget> createState() {
    return BarrageMainViewState();
  }
}

class BarrageMainViewState extends State<BarrageMainView> {
  bool isRending = true;

  // final _barrageDataManager = BarrageDataManager.instance;

  @override
  Widget build(BuildContext context) {
    var widgets = <Widget>[];
    if (widget.videoView != null) {
      widgets.add(widget.videoView);
    }
    var barrageList = widget._controller.barrageList;
    final barrageView = widget;
    barrageList.forEach((itemList) {
      itemList.forEach((item) {
        if (item.toLeft < barrageView.width) {
          var widget = Positioned(
            top: item.line * (item.itemHeight + 8),
            left: item.toLeft,
            child: GestureDetector(
              child: BarrageItemView(item),
              onTap: () {
                if (barrageView.onItemPressed != null) {
                  barrageView.onItemPressed(item);
                }
              },
              onTapDown: (details) {
                item.pause();
              },
              onTapUp: (details) {
                item.restart();
              },
            ),
          );
          widgets.add(widget);
        }
      });
    });
    return Container(
        width: widget.width,
        height: widget.height,
        child: Stack(
          children: widgets,
          overflow: Overflow.clip,
        ));
  }

  startRending() async {
    await Future.delayed(const Duration(milliseconds: 50));
    Timer.periodic(const Duration(microseconds: 16), (timer) {
      if (!isRending) {
        timer.cancel();
      }
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    isRending = true;
    startRending();
  }

  @override
  void dispose() {
    super.dispose();
    isRending = false;
  }
}

class BarrageItemView extends StatelessWidget {
  final BarrageItemModel data;

  BarrageItemView(this.data);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    var widgets = <Widget>[];
    if (data.backgroundColor != null &&
        data.backgroundColor != Colors.transparent) {
      widgets.add(ClipRRect(
        borderRadius: BorderRadius.circular(data.itemHeight / 2),
        child: Container(
          width: data.itemWidth,
          height: data.itemHeight,
          color: data.backgroundColor,
        ),
      ));
    }
    widgets.add(RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: TextStyle(fontSize: data.fontSize, color: data.textColor),
        children: data.textSpanList,
      ),
      maxLines: 1,
    ));
    return Stack(children: widgets);
  }
}
