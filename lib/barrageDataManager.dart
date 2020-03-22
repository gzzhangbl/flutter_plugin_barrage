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

  int _channel;
  int _speed;
  int horizontalItemSpace = 20;
  int verItemSpace = 8;
  double _width;
  List<BarrageItemModel> origData = List<BarrageItemModel>();
  List<List<BarrageItemModel>> barrageList = List<List<BarrageItemModel>>();

  BarrageDataManager._internal();

  set channel(int channel) {
    if (this._channel == null) {
      List.generate(channel, (index) {
        barrageList.add(List<BarrageItemModel>());
      });
    } else {
      if (channel == this._channel || channel < 0) {
        return;
      }
      if (this._channel < channel) {
        List.generate(channel - this._channel, (index) {
          barrageList.add(List<BarrageItemModel>());
        });
      }
    }
    this._channel = channel;
  }

  set speed(int speed) => this._speed = speed;

  set width(double width) => this._width = width;

  addBarrage(BarrageItemModel barrage) {
    var tempList = List<List<BarrageItemModel>>();
    bool isAdded = false;
    for (List<BarrageItemModel> listItem in barrageList.getRange(0, _channel)) {
      if (listItem.isEmpty) {
        barrage
          ..toLeft = _width
          ..line = barrageList.indexOf(listItem);
        listItem.add(barrage);
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
          _width - lastItem.itemWidth - horizontalItemSpace) {
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
      }, _speed);
    return isAdded;
  }
}
