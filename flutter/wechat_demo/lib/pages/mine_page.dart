import 'package:flutter/material.dart';
import 'package:wechat_demo/pages/discover/discover_cell.dart';

class MinePage extends StatefulWidget {
  const MinePage({Key? key}) : super(key: key);

  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
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
                    Container(
                      color: Colors.white,
                      height: 200,
                    ),
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
                    DiscoverCell(
                      title: '相册',
                      imageName: 'images/wc_photos.png',
                    ),
                    DiscoverCell(
                      title: '卡包',
                      imageName: 'images/wc_cards.png',
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
