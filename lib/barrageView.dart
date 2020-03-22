import 'dart:async';

import 'package:barrage/barrageDataManager.dart';
import 'package:barrage/barrageItemModel.dart';
import 'package:flutter/material.dart';

class BarrageMainView extends StatefulWidget {
  final OnPressed onItemPressed;
  final Key key;
  final double width;
  final double height;
  final int channel;
  final int speed;
  final Widget videoView;

  BarrageMainView(this.width, this.height, this.videoView,
      {this.key, this.channel = 5, this.speed = 120, this.onItemPressed})
      : super(key: key) {
    BarrageDataManager.instance
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
  final _barrageDataManager = BarrageDataManager.instance;

  @override
  Widget build(BuildContext context) {
    var widgets = <Widget>[];
    if (widget.videoView != null) {
      widgets.add(widget.videoView);
    }
    var barrageList = _barrageDataManager.barrageList;
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

  test(double width) {
    List.generate(100, (index) {
      _barrageDataManager.addBarrage(new BarrageItemModel(
          avatar: "http://pic2.zhimg"
              ".com/50/v2-fb824dbb6578831f7b5d92accdae753a_hd.jpg",
          backgroundColor: Colors.green));
    });
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
