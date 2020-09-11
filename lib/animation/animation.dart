import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_transition_animation/animation/fade.dart';

///
/// Created by fgyong on 2020/9/10.
///

/// 转场动画 展示和 消失动画
abstract class EasyAnimaiton {
  const EasyAnimaiton();
  Widget animationWidget(
      Animation<double> animation, BuildContext context, Widget child,
      {EasyAnimationDirection style, bool show});
}

abstract class EasyDirectionAnimation extends EasyAnimaiton {}
