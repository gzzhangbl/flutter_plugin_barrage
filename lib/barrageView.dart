import 'dart:async';

import 'package:barrage/barrageItemModel.dart';
import 'package:barrage/brageDataManager.dart';
import 'package:flutter/material.dart';

class BarrageMainView extends StatefulWidget {
  final OnPressed onItemPressed;
  final Key key1;

  BarrageMainView({this.key1, this.onItemPressed}) : super(key: key1);

  @override
  State<StatefulWidget> createState() {
    return BarrageMainViewState();
  }
}

class BarrageMainViewState extends State<BarrageMainView> {

  bool isRending = true;
  BarrageDataManager barrageDataManager = BarrageDataManager.instance;

  BarrageMainViewState();

  @override
  Widget build(BuildContext context) {
    var widgets = <Widget>[];
    var barrageList = barrageDataManager.barrageList;
    barrageList.forEach((itemList) {
      itemList.forEach((item) {
        if (item.toLeft < item.widthSize) {
          var widget = Positioned(
            top: item.line * (item.itemHeight + 8),
            left: item.toLeft,
            child: GestureDetector(
              child: BarrageItemView(item),
              onTap: () {

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
    return Stack(children: widgets);
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
      barrageDataManager.addItemToList(new BarrageItemModel(
          itemContent: "tesEemoooooo",
          widthSize: width,
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
    double textPadding = data.itemHeight / 2;
    if (data.avatar != null && data.avatar.isNotEmpty) {
      widgets.add(CircleAvatar(
        backgroundImage: NetworkImage(data.avatar),
        radius: data.itemHeight / 2,
      ));
      textPadding = data.itemHeight + 5;
    }
    widgets.add(Padding(
      padding: EdgeInsets.fromLTRB(textPadding, data.vercPadding.toDouble(),
          data.itemHeight / 2, data.vercPadding.toDouble()),
      child: Text(
        data.itemContent,
        style: TextStyle(fontSize: data.fontSize, color: data.textColor),
        maxLines: 1,
      ),
    ));
    return Stack(children: widgets);
  }
}
