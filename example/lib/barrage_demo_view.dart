import 'dart:math';

import 'package:barrage/barrage_data_controller.dart';
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
  BarrageDataController _barrageControlLer = BarrageDataController();


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
            _barrageControlLer,
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
                  _barrageControlLer..channel = int.parse(txt);
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
              _barrageControlLer.addBarrage(BarrageItemModel(
                barrageText: BarrageText(content: " ${_controller.text}")
                  ..text(" 尾部 ", txtColor: "#EE6AA7")
                  ..image(
                      "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1584860287319&di=cc6522313d8ac296de7dcbcaa6a36366&imgtype=0&src=http%3A%2F%2Fpic22.nipic.com%2F20120727%2F4819347_114740814000_2.jpg",
                      30.0,
                      15.0),
                textColor: Colors.lightGreenAccent,
                backgroundColor: Colors.black12,
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
