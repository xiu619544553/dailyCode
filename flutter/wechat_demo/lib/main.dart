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
  * --> android:src"@mipmap/launch_image.jpeg"
*/

/*
图片资源文件配置：
  * 直接放到根目录下：`项目目录/images`
  * pubspec.yaml --> assets:  注意⚠️：打开注释后，确保 assets 与上面的属性对齐，不要有多余的空格

  示例如下：
    assets:
      - 文件名/图片名.格式
*/


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

