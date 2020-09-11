import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_transition_animation/animation/animation.dart';

///
/// Created by fgyong on 2020/9/10.
///

class EasyFadeAnimaiton extends EasyAnimaiton {
  @override
  Widget animationWidget(
      Animation<double> animation, BuildContext context, Widget child,
      {EasyAnimationDirection style, bool show}) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }
}

/// 改变大小时候动画方向
enum EasyAnimationDirection {
  /// <- 右到左
  rtl,

  /// -> 左到右
  ltr,

  ///  ↓ 从底部到顶部
  ttb,

  /// ↑ 从底部到顶部
  btt,

  /// 数值合成一条线
  tvc,

  /// 水平合成一条线
  thv,
}
