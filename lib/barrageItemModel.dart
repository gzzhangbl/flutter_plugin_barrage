import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class BarrageItemModel extends State<StatefulWidget>
    with TickerProviderStateMixin {
  String itemContent;
  int itemStartMilliSecond;
  double speed; //每秒像素点
  double toLeft;
  double itemWidth;
  double widthSize;
  int vercPadding = 3;
  Color backgroundColor = Colors.transparent;
  Animation<double> barrageAnim;
  AnimationController barrageAnimController;
  double fontSize;
  Color textColor;
  double itemHeight;
  TextPainter textPainter;
  int line;
  String avator;

  BarrageItemModel(
      {this.itemContent,
      this.widthSize,
      this.fontSize = 16,
      this.textColor = Colors.black,
      this.backgroundColor,
      this.itemStartMilliSecond,
      this.speed = 80,
      this.toLeft,
      this.avator=""}) {
    this.avator=this.avator??"";
    final textStyle = TextStyle(
        fontSize: fontSize, color: Colors.black, fontWeight: FontWeight.w500);
    final textPainter = TextPainter(
        textDirection: TextDirection.ltr,
        text: TextSpan(
          text: itemContent,
          style: textStyle,
        ));
    textPainter.layout();
    this.itemWidth =
        textPainter.width + textPainter.height *(avator.isEmpty?1:(3 / 2)
        ) + 2 *
            vercPadding + ((avator.isEmpty)?0:5);
    this.itemHeight = textPainter.height + 2 * vercPadding;
    this.textPainter = textPainter;
  }

  startAnim(Function callback) {
//    barrageAnimController = new AnimationController(
//        duration:  Duration(milliseconds: (toLeft + itemWidth) * 1000 ~/
//            speed), vsync: this);
//    barrageAnim = RelativeRectTween(
//        begin: RelativeRect.fromLTRB(toLeft, 200.0, 200.0, 200.0),
//        end: RelativeRect.fromLTRB(-itemWidth, 20.0, 20.0, 20.0))
//        .animate(barrageAnimController..forward());
    barrageAnimController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: (toLeft + itemWidth) * 1000 ~/ speed));
    barrageAnim = Tween<double>(begin: toLeft, end: -itemWidth)
        .animate(barrageAnimController..forward())
          ..addListener(() {
            this.toLeft = barrageAnim.value;
            callback(this, barrageAnim.isCompleted);
          });
  }

  @override
  Widget build(BuildContext context) {
    return null;
  }
}
