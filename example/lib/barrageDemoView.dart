import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:barrage/barrageView.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:barrage/barrageDataManager.dart';
import 'package:barrage/barrageItemModel.dart';

class DemoView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DemoViewState();
  }
}

class DemoViewState extends State {
  TextEditingController _controller = TextEditingController();

  var bgColor = [Colors.yellow, Colors.red, Colors.black26];
  var textColor = [Colors.grey, Colors.green, Colors.black, Colors.blue];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double width = MediaQuery.of(context).size.width;
    BarrageDataManager barrageProvider = BarrageDataManager.instance;
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            child: BarrageMainView(),
            height: width / 2,
            width: width,
          ),
          TextField(
            controller: _controller,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              hintStyle: TextStyle(color: Colors.grey),
              hintText: "输入弹幕",
            ),
          ),
          RaisedButton(
            child: Text("发送"),
            onPressed: () {
              if (_controller.text.isEmpty) return;
              print(_controller.text);
              barrageProvider.addItemToList(BarrageItemModel(
                  itemContent: _controller.text,
                  textColor: textColor[Random().nextInt(20) % 4],
                  widthSize: width,
                  backgroundColor: bgColor[Random().nextInt(20) % 3],
                  toLeft: width,
                  avatar: "http://pic2.zhimg"
                      ".com/50/v2-fb824dbb6578831f7b5d92accdae753a_hd"
                      ".jpg",
                  onPressed: (item) {
                    print("press=====${item.itemContent}");
                  }));
              _controller.text = "";
            },
          )
        ],
      ),
    );
  }
}
