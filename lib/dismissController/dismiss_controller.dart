import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///
/// Created by fgyong on 2020/9/10.
///

typedef DismissAcionCallBack = Widget Function(
    Animation<double>, BuildContext context);

class EasyDismiss extends StatefulWidget {
  final Widget child;
  final Curve curve;

  /// 返回时候 规则
  final Curve reverseCurve;
  final DismissAcionCallBack builder;
  final double upperBound, lowerBound;
  final Duration reverseDuration, duration;

  /// 是否是反向
  final bool reverse;

  /// 执行一次的动画 部件
  EasyDismiss(
      {Key key,
      this.child,
      this.curve = Curves.linear,
      @required this.builder,
      this.lowerBound = 0.0,
      this.upperBound = 1.0,
      this.reverse,
      this.duration,
      this.reverseDuration,
      this.reverseCurve})
      : assert(() {
          if (lowerBound != null &&
              upperBound != null &&
              lowerBound < upperBound) return true;
          return false;
        }()),
        super(key: key);
  @override
  State<StatefulWidget> createState() => __DismissState();
}

class __DismissState extends State<EasyDismiss> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: (context, child) {
        return widget.builder(
          _animation,
          context,
        );
      },
      animation: _animation,
    );
  }

  AnimationController _animationController;
  Animation<double> _animation;
  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      upperBound: widget.upperBound,
      reverseDuration: widget.reverseDuration,
      duration: widget.duration,
      lowerBound: widget.lowerBound,
    );
    if (widget.reverse == true) {
      _animationController.reverse(from: widget.upperBound);
    } else {
      _animationController.forward();
    }
    _animation = CurvedAnimation(parent: _animationController, curve: curve);
    super.initState();
  }

  Curve get reverseCurve => widget.reverseCurve ?? widget.curve;
  Curve get curve => widget.reverse == false ? widget.curve : reverseCurve;

  @override
  void dispose() {
    if (_animationController != null) {
      _animationController.stop(canceled: true);
      _animationController.dispose();
    }

    super.dispose();
  }
}
