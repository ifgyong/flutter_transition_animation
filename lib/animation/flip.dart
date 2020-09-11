import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../flutter_easy_message.dart';
import 'animation.dart';
import 'fade.dart';

///
/// Created by fgyong on 2020/9/10.
///

class EasyFlipAnimaiton extends EasyDirectionAnimation {
  @override
  Widget animationWidget(
      Animation<double> animation, BuildContext context, Widget child,
      {EasyAnimationDirection style, bool show}) {
    Alignment alignment;

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
    var m = Matrix4.identity()..setEntry(3, 2, 0.001);

    switch (style) {
      case EasyAnimationDirection.ttb:
      case EasyAnimationDirection.btt:
      case EasyAnimationDirection.thv:

        /// 解决向上翻 90°没有完全隐藏问题
        if (value == 0) {
          m..setEntry(3, 2, 0.0);
        }
        return m..rotateX((1 - value) * pi / 2);
      case EasyAnimationDirection.rtl:
      case EasyAnimationDirection.ltr:
      case EasyAnimationDirection.tvc:

        /// 解决向上翻 90°没有完全隐藏问题
        if (value == 0) {
          m..setEntry(3, 2, 0.0);
        }
        return m..rotateY((1 - value) * pi / 2);
    }
    return m;
  }
}
