import 'package:flutter/material.dart';
import 'package:wechat_demo/pages/discover/discover_cell.dart';

class MinePage extends StatefulWidget {
  const MinePage({Key? key}) : super(key: key);

  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {

  Widget headerWidget() {
    return Container(
      color: Colors.white,
      height: 200,
      child: Container( // Container1
        color: Colors.yellow,
        /// Container1 与其父视图的间距
        margin: EdgeInsets.only(top: 100, bottom: 20),
        /// Container1 子视图距离其的边距。当然了，也可以直接在 Container2 中设置 margin。
        padding: EdgeInsets.all(10),
        child: Container( // Container2
          // color: Colors.blue,
          margin: EdgeInsets.only(left: 10),
          /// 通过控制内部padding，让 Row中的头像变小
          padding: EdgeInsets.all(5),
          child: Row( // 分为左右两块
            children: [
              // 头像部分
              Container(
                width: 50,
                height: 50,
                // decoration 装饰器属性，添加圆角、阴影等
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  // fit是填充属性，如果图片未能充满视图，可以使用 fit 属性
                  image: DecorationImage(image: AssetImage('images/wc_avatar.png'), fit: BoxFit.cover),
                ),
              ),

              // 右侧部分
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, // 设置主轴保证昵称和微信号上下紧贴父视图
                  crossAxisAlignment: CrossAxisAlignment.start,      // 设置交叉轴。保证昵称、微信号左侧对齐
                  children: [
                    // 昵称
                    Container(
                      color: Colors.red,
                      child: Text('前车之鉴', style: TextStyle(fontSize: 20)),
                      margin: EdgeInsets.only(left: 10),
                    ),
                    // 微信号
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      width: MediaQuery.of(context).size.width - 100, // 必须指定宽度，否则无法撑满
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('微信号：88888888', style: TextStyle(color: Colors.black, backgroundColor: Colors.orange)),
                          Image(image: AssetImage('images/wc_right.png'), width: 15),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('我'),
      // ),
      body: Stack(
        children: [
          /// 列表
          Container(
            color: Color.fromRGBO(220, 220, 220, 1),

            /// 去掉刘海
            /// 使用 MediaQuery.removePadding 包裹视图，然后设置 removeTop: true，则页面高度在顶部开始计算。反之，在刘海下开始计算。
            child: MediaQuery.removePadding(
                removeTop: true,
                context: context,
                child: ListView(
                  children: [
                    /// 头部
                    headerWidget(),
                    /// 灰色间隔
                    SizedBox(height: 10),
                    DiscoverCell(
                      title: '支付',
                      imageName: 'images/wc_pay.png',
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    DiscoverCell(
                      title: '收藏',
                      imageName: 'images/wc_collection.png',
                    ),
                    Row( // 分割线
                      children: [
                        Container(
                          width: 40,
                          height: 0.5,
                          color: Colors.white,
                        ),
                        Container(
                          height: 0.5,
                        ),
                      ],
                    ),
                    DiscoverCell(
                      title: '相册',
                      imageName: 'images/wc_photos.png',
                    ),
                    Row( // 分割线
                      children: [
                        Container(
                          width: 40,
                          height: 0.5,
                          color: Colors.white,
                        ),
                        Container(
                          height: 0.5,
                        ),
                      ],
                    ),
                    DiscoverCell(
                      title: '卡包',
                      imageName: 'images/wc_cards.png',
                    ),
                    Row( // 分割线
                      children: [
                        Container(
                          width: 40,
                          height: 0.5,
                          color: Colors.white,
                        ),
                        Container(
                          height: 0.5,
                        ),
                      ],
                    ),
                    DiscoverCell(
                      title: '表情',
                      imageName: 'images/wc_expression.png',
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    DiscoverCell(
                      title: '设置',
                      imageName: 'images/wc_settings.png',
                    ),
                  ],
                )),
          ),

          /// 相机
          Container(
            height: 25,
            margin: EdgeInsets.only(right: 15, top: 44),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Image(image: AssetImage('images/wc_camera.png')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
