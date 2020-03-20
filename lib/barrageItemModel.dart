import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

typedef OnPressed = void Function(BarrageItemModel itemModel);
typedef OnDismissed = void Function(BarrageItemModel itemModel);

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
  String avatar;
  OnPressed onPressed;

  BarrageItemModel(
      {this.itemContent,
      @required this.widthSize,
      this.fontSize = 16,
      this.textColor = Colors.black,
      this.backgroundColor,
      this.itemStartMilliSecond,
      this.speed = 80,
      this.toLeft,
      this.avatar = "",
      this.onPressed}) {
    this.avatar = this.avatar ?? "";
    final textStyle = TextStyle(
        fontSize: fontSize, color: Colors.black, fontWeight: FontWeight.w500);
    final textPainter = TextPainter(
        textDirection: TextDirection.ltr,
        text: TextSpan(
          text: itemContent,
          style: textStyle,
        ));
    textPainter.layout();
    this.itemWidth = textPainter.width +
        textPainter.height * (avatar.isEmpty ? 1 : (3 / 2)) +
        2 * vercPadding +
        ((avatar.isEmpty) ? 0 : 5);
    this.itemHeight = textPainter.height + 2 * vercPadding;
    this.textPainter = textPainter;
    this.toLeft = this.widthSize;
  }

  startAnim(OnDismissed callback) {
    barrageAnimController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: (toLeft + itemWidth) * 1000 ~/ speed));
    barrageAnim = Tween<double>(begin: toLeft, end: -itemWidth)
        .animate(barrageAnimController..forward())
          ..addListener(() {
            this.toLeft = barrageAnim.value;
            if (barrageAnim.isCompleted) {
              callback(this);
              barrageAnimController.dispose();
            }
          });
  }

  pause() {
    if (barrageAnimController != null && barrageAnimController.isAnimating) {
      barrageAnimController.stop(canceled: false);
    }
  }

  restart() {
    if (barrageAnimController != null&&!barrageAnimController.isAnimating) {
      barrageAnimController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return null;
  }
}
