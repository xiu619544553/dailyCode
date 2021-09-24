import 'package:flutter/material.dart';

/// 主题色
final Color WeChatThemeColor = Color.fromRGBO(220, 220, 220, 1);

/// 屏幕宽、高
double ScreenWidth(BuildContext context) => MediaQuery.of(context).size.width;
double ScreenHeight(BuildContext context) => MediaQuery.of(context).size.height;

/// 通讯录页面常量
final double FriendCellLineHeight = 0.5;
final double FriendAvatarHeight = 34;
final double FriendAvatarMargin = 10;
final double FriendIndexBarHeight = 30;
final double FriendNoHeaderCellHeight = FriendCellLineHeight + FriendAvatarHeight + FriendAvatarMargin * 2;
final double FriendHeaderCellHeight = FriendNoHeaderCellHeight + FriendIndexBarHeight;