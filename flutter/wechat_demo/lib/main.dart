import 'package:flutter/material.dart';
import 'package:wechat_demo/root_page.dart';


/*
APP的icon、启动图配置

1、iOS，需要在 `项目目录/ios` 项目中配置
  * 修改App名称： info.plist --> Bundle Display Name
  * 配置图片和启动图：Assets.xcassets --> AppIcon、LaunchImage

2、Android
  * 修改App名称目录：`项目目录/android/app/src/main/AndroidManifest.xml`
  * 修改App名称：AndroidManifest.xml --> application.android:label="xx"。

  * 配置图片路径：`项目目录/android/app/src/main/res` 注意：⚠️️Android icon命名不能驼峰，只能小写+下划线
  * 配置图片名称：application.android:icon="@mipmap/图片名"

  * 启动图
  * icon可以放在 `项目目录/android/app/src/main/res/mipmap-hdpi` 中
  * 配置启动图加载路径：`项目目录/android/app/src/main/res/drawable/launch_background.xml`
  * --> android:src"@mipmap/launch_image"  ⚠️Android配置启动图时，不需要填写图片的格式，错误写法 launch_image.jgp
*/

/*
图片资源文件配置：
  * 直接放到根目录下：`项目目录/images`
  * pubspec.yaml --> assets:  注意⚠️：打开注释后，确保 assets 与上面的属性对齐，不要有多余的空格

  示例如下：
    assets:
      - 文件名/图片名.格式
*/


/*
页面高度在顶部开始计算（忽略刘海）
方案：使用 MediaQuery.removePadding 包裹视图，然后设置 removeTop: true，则页面高度在顶部开始计算。反之，在刘海下开始计算。

MediaQuery.removePadding(
  removeTop: true,
)

注：详细用法可以参考 `mine_page.dart` 页面
*/


/*
decoration  装饰器属性使用，它可以添加圆角、阴影等。

# 给当前Widget添加装饰属性
Container(
    width: 60,
    height: 60,
    decoration: BoxDecoration(
       color: Colors.blue,
       borderRadius: BorderRadius.circular(30),
    ),
),

# 给 Image 添加装饰属性
如果要给 Image 添加装饰器属性，需要 BoxDecoration 的 image 属性
Container(
    width: 50,
    height: 50,
    decoration: BoxDecoration(
       borderRadius: BorderRadius.circular(30),
       image: DecorationImage(image: AssetImage('images/wc_avatar.png')),
    ),
),
*/

/*
计算屏幕的尺寸：MediaQuery.of(context).size
* */


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '微信',
      theme: ThemeData(
        highlightColor: Color.fromARGB(1, 0, 0, 0), // 高亮颜色，设置为透明色，否则长按 BottomNavigationBarItem 会变色
        splashColor: Color.fromARGB(1, 0, 0, 0),    // BottomNavigationBarItem 点击水波纹效果的颜色，设置为透明色，就可以去掉了
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: RootPage(),
    );
  }
}

