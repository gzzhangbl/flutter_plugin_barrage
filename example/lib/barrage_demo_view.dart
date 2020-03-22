import 'dart:math';

import 'package:barrage/barrage_data_manager.dart';
import 'package:barrage/barrage_item_model.dart';
import 'package:barrage/barrage_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
    return Container(
      child: Column(
        children: <Widget>[
          BarrageMainView(
            width,
            width / 2,
            Container(
              color: Colors.greenAccent,
            ),
            onItemPressed: (item) {
              print("onPreassed===${item.barrageText.content}");
              showDialog(
                context: context,
                barrierDismissible: true,
                // user must tap button!
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('弹幕'),
                    content: Text(item.barrageText.content),
                    actions: <Widget>[
                      FlatButton(
                        child: Text('确定'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
          Container(
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintStyle: TextStyle(color: Colors.grey),
                  hintText: "弹道数",
                ),
                onChanged: (txt) {
                  print(">>>>chanel==t$txt");
                  BarrageDataManager.instance
                    ..channel = int.parse(txt);
                },
              ),
              width: 100),
          Container(
              child: TextField(
                controller: _controller,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintStyle: TextStyle(color: Colors.grey),
                  hintText: "输入弹幕",
                ),
              ),
              width: 200),
          RaisedButton(
            child: Text("发送一条弹幕"),
            onPressed: () {
              if (_controller.text.isEmpty) return;
              BarrageDataManager.instance.addBarrage(BarrageItemModel(
                barrageText: BarrageText(content: " ${_controller.text}")
                  ..text(" 尾部 ", txtColor: "#EE6AA7")
                  ..image(
                      "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1584860287319&di=cc6522313d8ac296de7dcbcaa6a36366&imgtype=0&src=http%3A%2F%2Fpic22.nipic.com%2F20120727%2F4819347_114740814000_2.jpg",
                      30.0,
                      15.0),
                textColor: textColor[Random().nextInt(20) % 4],
                backgroundColor: bgColor[Random().nextInt(20) % 3],
                toLeft: width,
                avatar: "http://pic2.zhimg"
                    ".com/50/v2-fb824dbb6578831f7b5d92accdae753a_hd"
                    ".jpg",
              ));
              _controller.text = "";
            },
          )
        ],
      ),
    );
  }
}
