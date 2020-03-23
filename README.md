# 弹幕

## 描述
>一款fluter 版本的弹幕组件，支持文字大小，颜色，背景，头像，富文本，点击事件，弹道数目变更，弹幕速度

![弹幕](https://github.com/gzzhangbl/flutter_plugin_barrage/blob/master/demo_barrage.jpg "弹幕")

## 弹幕组件 BarageMainView
  
参数 | 类型 |  描述  
-|-|-
width | double | 宽度 |
height | double | 高度 |
_controller | BarrageDataController | 弹幕操作的控制器 |
widget | Widget | 底部widget 如：视频组件 |
channel | int | 弹道数 默认为5|
speed | int |速度，每秒钟的距离|
onItemPressed | OnPressed | 弹幕点击事件|

## 弹幕实体类
参数 | 类型 |  描述  
-|-|-
barrageText | BarrageText | 弹幕富文本内容描述 |
backgroundColor | Color | 弹幕背景颜色，默认为透明 |
_controller | BarrageDataController | 弹幕操作的控制器 |
avatar | 头像 | 头像链接 url |

## 使用 
#### 1，创建 BarageMainView 传入相关参数 width height _controller 为必填
#### 2 发送弹幕 _controller.addBarrage(BarrageItemModel)方法 
```
 _barrageControlLer.addBarrage(BarrageItemModel(
                barrageText: BarrageText(content: " ${_controller.text}")
                  ..text(" 尾部 ", txtColor: "#EE6AA7")
                  ..image(
                      "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1584860287319&di=cc6522313d8ac296de7dcbcaa6a36366&imgtype=0&src=http%3A%2F%2Fpic22.nipic.com%2F20120727%2F4819347_114740814000_2.jpg",
                      30.0,
                      15.0),
                textColor: Colors.lightGreenAccent,
                backgroundColor: Colors.black12,
                avatar: "http://pic2.zhimg"
                    ".com/50/v2-fb824dbb6578831f7b5d92accdae753a_hd"
                    ".jpg",
              ));
```
BarrageText为富文本描述 text(text,color)添加文字,image(url,width,height),添加图片
#### 3，改变速度 通过BarrageDataController speed方法改变
#### 4，改变弹道数，BarrageDataController channel方法改变
  

