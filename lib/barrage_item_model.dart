import 'dart:convert' as convert;
import 'dart:math';

import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

typedef OnPressed = void Function(BarrageItemModel itemModel);
typedef OnDismissed = void Function(BarrageItemModel itemModel);

class BarrageItemModel extends State<StatefulWidget>
    with TickerProviderStateMixin {
  BarrageText barrageText;
  List<InlineSpan> textSpanList;
  int itemStartMilliSecond;
  double toLeft;
  double itemWidth = 0;
  int verticalPadding = 3;
  Color backgroundColor = Colors.transparent;
  Animation<double> _barrageAnim;
  AnimationController _barrageAnimController;
  double fontSize;
  Color textColor;
  double itemHeight = 0;
  int line;
  String avatar;

  BarrageItemModel({
    this.fontSize = 16,
    this.barrageText,
    this.textColor = Colors.black,
    this.backgroundColor,
    this.itemStartMilliSecond,
    this.toLeft,
    this.avatar,
  }) {
    _initData();
  }

  _initData() {
    if (this.textSpanList == null) {
      textSpanList = <InlineSpan>[];
    }
    var textList = barrageText.content.split(BarrageText.SPACE);
    textList.forEach((textItem) {
      Map<String, dynamic> map = convert.jsonDecode(textItem);
      if (map.containsKey("text")) {
        final textStyle = TextStyle(
          fontSize: fontSize,
          color: map["textColor"]!=null?BarrageText.hexToColor(map["textColor"]):textColor,
          fontWeight: FontWeight.w500,
        );
        var textSpan = TextSpan(
          style: textStyle,
          text: map["text"],
        );
        final textPainter =
            TextPainter(textDirection: TextDirection.ltr, text: textSpan);
        textPainter.layout();

        this.itemWidth += textPainter.width;
        this.itemHeight =
            max(textPainter.height + 2 * verticalPadding, this.itemHeight);
        textSpanList.add(WidgetSpan(
            child: Padding(
          padding: EdgeInsets.only(
              top: verticalPadding.toDouble(),
              bottom: verticalPadding.toDouble()),
          child: Text(
            map["text"],
            style: textStyle,
          ),
        )));
      } else if (map.containsKey("image")) {
        var width = map["width"];
        var height = map["height"];
        this.itemWidth += width;
        this.itemHeight = max(height, this.itemHeight);
        textSpanList.add(WidgetSpan(
          child: Padding(
              padding: EdgeInsets.fromLTRB(
                  0, (itemHeight - height) / 2, 0, (itemHeight - height) / 2),
              child: SizedBox(
                  width: width,
                  height: height,
                  child: Image.network(map["image"]))),
        ));
      }
    });

    textSpanList.forEach((span) {});

    if (this.avatar != null && this.avatar.isNotEmpty) {
      textSpanList.insert(
          0,
          WidgetSpan(
              child: CircleAvatar(
            backgroundImage: NetworkImage(this.avatar),
            radius: itemHeight / 2,
          )));
      this.itemWidth += 1.5 * this.itemHeight;
    } else {
      this.itemWidth += itemHeight;
    }
  }

  startAnim(OnDismissed callback, int speed) {
    if (_barrageAnimController == null) {
      _barrageAnimController = AnimationController(
          vsync: this,
          duration:
              Duration(milliseconds: (toLeft + itemWidth) * 1000 ~/ speed));
    }
    _barrageAnim = Tween<double>(begin: toLeft, end: -itemWidth)
        .animate(_barrageAnimController..forward())
          ..addListener(() {
            this.toLeft = _barrageAnim.value;
            if (_barrageAnim.isCompleted) {
              callback(this);
              _barrageAnimController.dispose();
            }
          });
  }

  pause() {
    if (_barrageAnimController != null && _barrageAnimController.isAnimating) {
      _barrageAnimController.stop(canceled: false);
    }
  }

  restart() {
    if (_barrageAnimController != null && !_barrageAnimController.isAnimating) {
      _barrageAnimController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return null;
  }
}

class BarrageText {
  String content = "";
  static const SPACE = "#%@";

  BarrageText({String content, String textColor = "#000000"}) {
    if (content != null && content.isNotEmpty) {
      text(content, txtColor: textColor);
    }
  }

  image(String img, double width, double height) {
    var map = Map<String, dynamic>();
    map['image'] = img;
    map['width'] = width;
    map['height'] = height;
    content += ((content.isNotEmpty ? SPACE : "") + convert.jsonEncode(map));
  }

  text(String txt, {String txtColor}) {
    var map = Map<String, dynamic>();
    map['text'] = txt;
    map['textColor'] = txtColor;
    content += ((content.isNotEmpty ? SPACE : "") + convert.jsonEncode(map));
  }

  static Color hexToColor(String s) {
    if (s == null ||
        s.length != 7 ||
        int.tryParse(s.substring(1, 7), radix: 16) == null) {
      s = '#999999';
    }
    return new Color(int.parse(s.substring(1, 7), radix: 16) + 0xFF000000);
  }
}
