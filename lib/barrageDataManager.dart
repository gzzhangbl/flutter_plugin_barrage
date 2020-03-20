import 'package:barrage/barrageItemModel.dart';
import 'package:flutter/material.dart';

class BarrageDataManager {
  static BarrageDataManager _singleton;

  factory BarrageDataManager() {
    return _singleton;
  }

  static BarrageDataManager get instance => _getInstance();

  static BarrageDataManager _getInstance() {
    if (_singleton == null) {
      _singleton = new BarrageDataManager._internal();
    }
    return _singleton;
  }

  int maxLine = 5;
  int barrageCount = 3;
  double defaultSpeed = 200;
  int horizontalItemSpace = 20;
  double screenWidth;
  List<BarrageItemModel> origData = List<BarrageItemModel>();
  List<List<BarrageItemModel>> barrageList = List<List<BarrageItemModel>>();

  BarrageDataManager._internal() {
    List.generate(maxLine, (index) {
      barrageList.add(List<BarrageItemModel>());
    });
  }

  changeMaxLine(int maxLine) {
    if (maxLine == this.maxLine || maxLine < 0) {
      return;
    }
    if (this.maxLine < maxLine) {
      List.generate(maxLine - this.maxLine, (index) {
        barrageList.add(List<BarrageItemModel>());
      });
    }
    this.maxLine = maxLine;
  }

  addItemToList(BarrageItemModel barrage) {
    var tempList = List<List<BarrageItemModel>>();
    bool isAdded = false;
    for (List<BarrageItemModel> listItem in barrageList.getRange(0, maxLine)) {
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
      if (lastItem.toLeft <=
          lastItem.widthSize - lastItem.itemWidth - horizontalItemSpace) {
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
      barrage.startAnim((item) {
        barrageList[item.line].remove(item);
      });
    return isAdded;
  }
}
