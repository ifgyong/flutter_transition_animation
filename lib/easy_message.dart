import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'flutter_easy_message.dart';

///
/// Created by fgyong on 2020/9/10.
///

// enum EasyMessageStyle {
//   defaultStyle,
//   /*渐隐渐显*/
//   fade,
//   /*大小变化*/
//   size,
//   /*翻转*/
//   flip,
// }
enum EasyShowOrHideStyle {
  defaultStyle,
  /*渐隐渐显*/
  fade,
  /*大小变化*/
  size,
  /*翻转*/
  flip,
}

// ignore: must_be_immutable
class FlutterEasyMessage extends StatelessWidget {
  /// 主题 部件
  final Widget child;

  /// 展示 动画的部件
  final Widget messageChild;

  /// 动画停留时间展示时间默认 [1000ms]
  final Duration duration;

  /// 展示动画时间 默认 [300ms]
  final Duration showDuration;

  /// 隐藏动画时间 默认 [300ms]
  final Duration hideDuration;

  /// 动画出现类别 默认是[EasyShowOrHideStyle.defaultStyle]
  final EasyShowOrHideStyle showAnimationStyle;

  /// 动画消失类别 默认是[EasyShowOrHideStyle.defaultStyle]
  final EasyShowOrHideStyle hideAnimationStyle;

  /// 动画出现时候的方向，默认是[EasyAnimaitonDirection.ltr]
  final EasyAnimationDirection showAnimaitonDirection;

  /// 动画隐藏时候的方向,默认是[EasyAnimaitonDirection.btt]
  final EasyAnimationDirection hideAnimaitonDirection;

  /// 进入的时候的规则,默认是[Curves.linear] [https://api.flutter.dev/flutter/animation/Curves-class.html]
  final Curve curve;

  /// 返回时候 规则,默认是[Curves.linear][https://api.flutter.dev/flutter/animation/Curves-class.html]
  final Curve reverseCurve;

  FlutterEasyMessage({
    @required this.child,
    @required this.messageChild,
    @required this.duration,
    this.showDuration,
    this.hideDuration,
    this.curve = Curves.linear,
    this.reverseCurve = Curves.linear,
    this.showAnimationStyle,
    this.hideAnimationStyle,
    this.showAnimaitonDirection = EasyAnimationDirection.ltr,
    this.hideAnimaitonDirection = EasyAnimationDirection.btt,
  });

  @override
  Widget build(BuildContext context) {
    return _DefaultWidget(
      child: child,
      messageChild: messageChild,
      duration: duration,
      showAnimation: getAnimation(showAnimationStyle),
      hideAnimation: getAnimation(hideAnimationStyle),
      showDuration: showDuration,
      hideAnimationDirection: hideAnimaitonDirection,
      showAnimationDirection: showAnimaitonDirection,
      reverseCurve: reverseCurve,
      curve: curve,
    );
  }

  EasyAnimaiton defaultAnimation = EasyFadeAnimaiton();

  /// 根据类型获取到处理动画的类
  EasyAnimaiton getAnimation(EasyShowOrHideStyle animationStyle) {
    switch (animationStyle) {
      case EasyShowOrHideStyle.fade:
        return defaultAnimation;
      case EasyShowOrHideStyle.size:
        return EasySizeAnimaiton();
      case EasyShowOrHideStyle.flip:
        return EasyFlipAnimaiton();
      default:
        return defaultAnimation;
    }
  }
}

class _DefaultWidget extends StatefulWidget {
  final Widget child;
  final Widget messageChild;
  final Duration duration;
  final Curve curve;

  final EasyAnimaiton showAnimation;
  final EasyAnimaiton hideAnimation;

  /// 动画出现时候的方向
  final EasyAnimationDirection showAnimationDirection;

  /// 动画隐藏时候的方向
  final EasyAnimationDirection hideAnimationDirection;

  /// 展示动画时间 默认 300ms
  final Duration showDuration;

  /// 隐藏动画时间 默认 300ms
  final Duration hideDuration;

  /// 返回时候 规则
  /// 查看所有效果 [https://api.flutter.dev/flutter/animation/Curves-class.html]
  final Curve reverseCurve;

  /// 默认的 提示框
  _DefaultWidget(
      {@required this.child,
      @required this.messageChild,
      @required this.duration,
      this.curve,
      this.showDuration,
      this.hideDuration,
      @required this.showAnimation,
      this.hideAnimation,
      this.showAnimationDirection,
      this.hideAnimationDirection,
      this.reverseCurve})
      : assert(child != null),
        assert(messageChild != null),
        assert(duration != null),
        assert(
          showAnimation != null,
        );

  @override
  __DefaultWidgetState createState() {
    return __DefaultWidgetState();
  }
}

class __DefaultWidgetState extends State<_DefaultWidget> {
  Widget get child => widget.child;
  Widget get messageChild => widget.messageChild;

  /// 停留的周期
  Duration get duration => widget.duration;
  bool _dismiss = false;

  /// 出现周期
  Duration get showDuration =>
      widget.showDuration ?? Duration(milliseconds: 300);

  /// 隐藏 周期
  Duration get hideDuration =>
      widget.hideDuration ?? Duration(milliseconds: 300);

  /// 出现动画
  EasyAnimaiton get easyAnimaiton => widget.showAnimation;

  /// 隐藏动画
  EasyAnimaiton get easyHideAnimaiton =>
      widget.hideAnimation ?? widget.showAnimation;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: ValueKey(_dismiss),
      child: EasyDismiss(
        builder: (animation, context) {
          Widget ch;
          if (_dismiss == true) {
            ch = easyHideAnimaiton.animationWidget(
                animation, context, messageChild,
                style: widget.hideAnimationDirection, show: false);
          } else {
            ch = easyAnimaiton.animationWidget(animation, context, messageChild,
                style: widget.showAnimationDirection, show: true);
          }
          // return ch;
          return Stack(
            children: [
              Positioned(
                child: child,
              ),
              Positioned(
                child: Container(
                  child: ch,
                ),
              )
            ],
          );
        },
        duration: showDuration,
        reverseDuration: hideDuration,
        reverse: _dismiss,
        reverseCurve: widget.reverseCurve,
        curve: widget.curve,
      ),
    );
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      /// 隐藏小部件
      Timer(widget.duration, () {
        _dismiss = true;
        if (mounted) setState(() {});
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
