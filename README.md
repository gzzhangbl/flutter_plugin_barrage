
### 描述
>一款fluter 版本的弹幕组件，目前支持文字大小，颜色，背景，头像，富文本，点击事件，弹道数目变更，弹幕速度，后续会继续完善相关功能

![弹幕](https://github.com/gzzhangbl/flutter_plugin_barrage/blob/master/demo_barrage.jpg "弹幕")

### 弹幕组件 BarageMainView
  
参数 | 类型 |  描述  
-|-|-
width | double | 宽度 |
height | double | 高度 |
_controller | BarrageDataController | 弹幕操作的控制器 |
widget | Widget | 底部widget 如：视频组件 |
channel | int | 弹道数 默认为5|
speed | int |速度，每秒钟的距离|
onItemPressed | OnPressed | 弹幕点击事件|

### 弹幕实体类
参数 | 类型 |  描述  
-|-|-
barrageText | BarrageText | 弹幕富文本内容描述 |
backgroundColor | Color | 弹幕背景颜色，默认为透明 |
_controller | BarrageDataController | 弹幕操作的控制器 |
avatar | 头像 | 头像链接 url |

### 使用 
#### 1，创建 BarageMainView 传入相关参数 width height _controller 为必填
#### 2 发送弹幕 
>调用 控制器 BarrageDataController的 addBarrage(BarrageItemModel)方法 
```dart
 _barrageControlLer.addBarrage(BarrageItemModel(
                barrageText: BarrageText(content: " ${_controller.text}")
                  ..text(" 尾部 ", txtColor: "#EE6AA7")
                  ..image(
                      "图片链接",
                      30.0,
                      15.0),
                textColor: Colors.lightGreenAccent,
                backgroundColor: Colors.black12,
                avatar: "头像链接",
              ));
```
其中：BarrageText为富文本描述 text(text,color)添加文字,image(url,width,height)添加图片，需要设置宽高
#### 3，改变速度 
>调用 BarrageDataController speed（int）方法改变
#### 4，改变弹道数，
>调用 BarrageDataController channel（int）方法改变
  

