import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_transition_animation/flutter_easy_message.dart';

///
/// Created by fgyong on 2020/9/11.
///
class EasySizeAnimaiton extends EasyAnimaiton {
  @override
  Widget animationWidget(
      Animation<double> animation, BuildContext context, Widget child,
      {EasyAnimationDirection style, bool show}) {
    Alignment alignment = Alignment.center;

    /// 根据枚举类型来指定不同的锚点进行动画
    switch (style) {
      case EasyAnimationDirection.ttb:
        if (show == false) {
          alignment = Alignment.bottomCenter;
        } else {
          alignment = Alignment.topCenter;
        }
        break;

      case EasyAnimationDirection.btt:
        alignment =
            show == false ? Alignment.topCenter : Alignment.bottomCenter;
        break;

      case EasyAnimationDirection.ltr:
        alignment =
            show == false ? Alignment.centerRight : Alignment.centerLeft;
        break;

      case EasyAnimationDirection.rtl:
        alignment = show == true ? Alignment.centerRight : Alignment.centerLeft;
        break;

      case EasyAnimationDirection.thv:
      case EasyAnimationDirection.tvc:
        alignment = Alignment.center;
        break;
    }
    return Transform(
      transform: m4(animation.value, style),
      child: child,
      alignment: alignment,
    );
    // return ;
  }

  Matrix4 m4(double value, EasyAnimationDirection style) {
    var m = Matrix4.identity();

    switch (style) {
      case EasyAnimationDirection.ttb:
      case EasyAnimationDirection.btt:
      case EasyAnimationDirection.thv:
        return m
          ..scale(
            1.0,
            value,
          );
      case EasyAnimationDirection.rtl:
      case EasyAnimationDirection.ltr:
      case EasyAnimationDirection.tvc:
        return m..scale(value, 1.0);
    }
    return m;
  }
}
