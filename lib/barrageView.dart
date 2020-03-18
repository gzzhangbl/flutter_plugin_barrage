import 'package:barrage/barrageItemModel.dart';
import 'package:barrage/brageProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BarrageMainView extends StatelessWidget {
  const BarrageMainView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BarrageProvider barrageProvider = Provider.of<BarrageProvider>(context);
    double width = MediaQuery.of(context).size.width;
    var widgets = List<Widget>();
    var barrageList = barrageProvider.barrageList;
    barrageList.forEach((itemList) {
      itemList.forEach((item) {
        if (item.toLeft < width) {
          var widget = Positioned(
            top: item.line * (item.itemHeight + 8),
            left: item.toLeft,
            child: GestureDetector(
              child: BarrageItemView(item),
              onTap: () {
                print(("tap"));
                barrageProvider..changeMaxLine(1);
              },
              onPanDown: (e) => print("按下的位置${e.globalPosition}"),
            ),
          );
          widgets.add(widget);
        }
      });
    });
    return Stack(children: widgets);
  }
}

class BarrageItemView extends StatelessWidget {
  final BarrageItemModel data;

  BarrageItemView(this.data);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Stack(
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(data.itemHeight / 2),
          child: Container(
            width: data.itemWidth,
            height: data.itemHeight,
            color: data.backgroundColor,
          ),
        ),
        CircleAvatar(
          backgroundImage: NetworkImage(data.avator ?? ""),
          radius: (data.avator.isEmpty) ? 0 : data.itemHeight / 2,
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(
              data.avator.isEmpty ? data.itemHeight / 2 : data.itemHeight + 5,
              data.vercPadding.toDouble(),
              data.itemHeight / 2,
              data.vercPadding.toDouble()),
          child: Text(
            data.itemContent,
            style: TextStyle(fontSize: data.fontSize, color: data.textColor),
            maxLines: 1,
          ),
        )
      ],
    );
  }
}

//class BarrageViewPainter extends CustomPainter {
//  final int time;
//  final BarrageItemModel data;
//
//  BarrageViewPainter({this.time, this.data});
//
//  @override
//  void paint(Canvas canvas, Size size) {
//    final Paint paint = Paint()..style = PaintingStyle.fill;
//    paint.color = data.backgroundColor ?? Colors.transparent;
//    var bgHeight = data.textPainter.height + 2 * data.vercPadding;
//    Rect rt = Rect.fromLTWH(0, 0, data.itemWidth, bgHeight);
//    RRect rect = RRect.fromRectAndRadius(rt, Radius.circular(bgHeight / 2));
//    canvas.drawRRect(rect, paint);
//    Offset textOffset = Offset(bgHeight / 2, data.vercPadding.toDouble());
//    data.textPainter.paint(canvas, textOffset);
//  }
//
//  @override
//  bool shouldRepaint(BarrageViewPainter oldPainter) {
//    return true;
//  }
//}
