import 'package:barrage/barrageItemModel.dart';
import 'package:flutter/material.dart';

class BarrageProvider with ChangeNotifier {
  int maxLine = 5;
  int barrageCount = 3;
  double defaultSpeed = 100;
  int horizontalItemSpace = 20;
  double screenWidth;
  List<BarrageItemModel> origData = List<BarrageItemModel>();
  List<List<BarrageItemModel>> barrageList = List<List<BarrageItemModel>>();

  BarrageProvider({this.screenWidth = 360}) {
    List.generate(maxLine, (index) {
      barrageList.add(List<BarrageItemModel>());
    });
  }


  changeMaxLine(int maxLine){
    if(maxLine==this.maxLine||maxLine<0){
      return;
    }
    if(this.maxLine<maxLine){
      List.generate(maxLine-this.maxLine, (index) {
        barrageList.add(List<BarrageItemModel>());
      });
    }
    this.maxLine=maxLine;
  }

  addItemToList(BarrageItemModel barrage) {
    var tempList = List<List<BarrageItemModel>>();
    bool isAdded = false;
    for (List<BarrageItemModel> listItem in barrageList.getRange(0,maxLine)) {
      if (listItem.length == 0) {
        listItem.add(barrage);
        barrage.line = barrageList.indexOf(listItem);
        isAdded = true;
        break;
      } else {
        tempList.add(listItem);
      }
    }
    if (!isAdded && tempList.isNotEmpty) {
      tempList.sort((a, b) => a.last.toLeft.compareTo(b.last.toLeft));
      var lastItem = tempList.first.last;
      print("${lastItem.toLeft}/${tempList.last.last.toLeft}");
      if (lastItem.toLeft <=
          barrage.widthSize - barrage.itemWidth - horizontalItemSpace) {
        tempList.first.add(barrage);
      } else {
        tempList.first.add(barrage
          ..toLeft =
              lastItem.toLeft + lastItem.itemWidth + horizontalItemSpace);
      }
      barrage.line = barrageList.indexOf(tempList.first);
      isAdded = true;
    }
    if (isAdded)
      barrage.startAnim((item,isFinish) {
        if(isFinish) {
          barrageList[item.line].remove(item);
        }
        notifyListeners();
      });
    return isAdded;
  }
}
