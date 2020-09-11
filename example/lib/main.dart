import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_transition_animation/easy_message.dart';
import 'package:flutter_transition_animation/flutter_easy_message.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Easy show message Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

enum ChildType { msg, img, view }

class _MyHomePageState extends State<MyHomePage> {
  EasyAnimationDirection showFlipStyle = EasyAnimationDirection.btt;
  EasyAnimationDirection hideFlipStyle = EasyAnimationDirection.btt;

  EasyShowOrHideStyle style = EasyShowOrHideStyle.defaultStyle;
  EasyShowOrHideStyle dismissStyle = EasyShowOrHideStyle.defaultStyle;

  Curve _showCurve = Curves.linear;
  Curve _hideCurve = Curves.linear;
  ChildType type = ChildType.msg;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            Container(
              height: 200,
              width: 300,
              color: Colors.black12,
              key: UniqueKey(),
              alignment: Alignment.topCenter,
              child: Container(
                width: 200,
                height: 250,
                child: FlutterEasyMessage(
                  child: child,
                  messageChild: messageChild,
                  duration: Duration(seconds: 2),
                  hideAnimationStyle: dismissStyle,
                  showAnimationStyle: style,
                  showAnimaitonDirection: showFlipStyle,
                  hideAnimaitonDirection: hideFlipStyle,
                  hideDuration: Duration(seconds: 1),
                  showDuration: Duration(seconds: 1),
                  curve: _showCurve,
                  reverseCurve: _hideCurve,
                ),
              ),
            ),
            Text('浮窗类型'),
            _widgetChild(),
            Text('出现动画类型'),
            _widgetStyle(true),
            Text('消失动画类型'),
            _widgetStyle(false),
            Text('隐藏方向  style==EasyShowOrHideStyle.size 可用 \n '),
            Text('出现动画方向'),
            _widget(true),
            Text('隐藏动画方向'),
            _widget(false),
            Text('进入动画曲线<左右滑动选择更多>'),
            CupertinoScrollbar(
              child: SingleChildScrollView(
                child: _curve(true),
                scrollDirection: Axis.horizontal,
              ),
            ),
            Text('隐藏动画曲线<左右滑动选择更多>'),
            CupertinoScrollbar(
              child: SingleChildScrollView(
                child: _curve(false),
                scrollDirection: Axis.horizontal,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {});
        },
        tooltip: 'Increment',
        child: Icon(Icons.refresh),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void fresh() {
    if (mounted) setState(() {});
  }

  /// 动画类型
  Widget _widgetStyle(bool show) {
    return CupertinoSegmentedControl<EasyShowOrHideStyle>(
        children: {
          EasyShowOrHideStyle.defaultStyle: Padding(
            padding: EdgeInsets.all(5.0),
            child: Text("defaultStyle"),
          ),
          EasyShowOrHideStyle.size: Padding(
            padding: EdgeInsets.all(5.0),
            child: Text("size"),
          ),
          EasyShowOrHideStyle.fade: Padding(
            padding: EdgeInsets.all(5.0),
            child: Text("fade"),
          ),
          EasyShowOrHideStyle.flip: Padding(
            padding: EdgeInsets.all(5.0),
            child: Text("翻转"),
          )
        },
        selectedColor: Colors.blueAccent,
        onValueChanged: (v) {
          if (show == false) {
            dismissStyle = v;
          } else {
            style = v;
          }
          fresh();
        },
        groupValue: show == true ? style : dismissStyle);
  }

  Widget _widget(bool show) {
    return CupertinoSegmentedControl<EasyAnimationDirection>(
        children: {
          EasyAnimationDirection.rtl: Padding(
            padding: EdgeInsets.all(5.0),
            child: Text("<-"),
          ),
          EasyAnimationDirection.ltr: Padding(
            padding: EdgeInsets.all(5.0),
            child: Text("->"),
          ),
          EasyAnimationDirection.btt: Padding(
            padding: EdgeInsets.all(5.0),
            child: Text("↑"),
          ),
          EasyAnimationDirection.ttb: Padding(
            padding: EdgeInsets.all(5.0),
            child: Text("↓"),
          ),
          EasyAnimationDirection.tvc: Padding(
            padding: EdgeInsets.all(5.0),
            child: Text(show ? "<-->" : ">-<"),
          ),
          EasyAnimationDirection.thv: Padding(
            padding: EdgeInsets.all(5.0),
            child: Text(show ? "↕" : "--"),
          )
        },
        selectedColor: Colors.blueAccent,
        onValueChanged: (v) {
          if (show) {
            showFlipStyle = v;
          } else {
            hideFlipStyle = v;
          }

          fresh();
        },
        groupValue: show == true ? showFlipStyle : hideFlipStyle);
  }

  Widget _widgetChild() {
    return CupertinoSegmentedControl<ChildType>(
      children: {
        ChildType.msg: Padding(
          padding: EdgeInsets.all(5.0),
          child: Text("msg"),
        ),
        ChildType.img: Padding(
          padding: EdgeInsets.all(5.0),
          child: Text("img"),
        ),
        ChildType.view: Padding(
          padding: EdgeInsets.all(5.0),
          child: Text("view"),
        ),
      },
      groupValue: type,
      onValueChanged: (v) {
        type = v;
        fresh();
      },
    );
  }

  Widget _curve(bool show) {
    return CupertinoSegmentedControl<Curve>(
      children: {
        Curves.linear: Padding(
          padding: EdgeInsets.all(5.0),
          child: Text('linear'),
        ),
        Curves.bounceInOut: Padding(
          padding: EdgeInsets.all(5.0),
          child: Text('bounceInOut'),
        ),
        Curves.bounceOut: Padding(
          padding: EdgeInsets.all(5.0),
          child: Text('bounceOut'),
        ),
        Curves.bounceIn: Padding(
          padding: EdgeInsets.all(5.0),
          child: Text('bounceIn'),
        ),
        Curves.easeIn: Padding(
          padding: EdgeInsets.all(5.0),
          child: Text('easeIn'),
        ),
        Curves.easeInToLinear: Padding(
          padding: EdgeInsets.all(5.0),
          child: Text('easeInToLinear'),
        ),
        Curves.linearToEaseOut: Padding(
          padding: EdgeInsets.all(5.0),
          child: Text('linearToEaseOut'),
        ),
        Curves.bounceIn: Padding(
          padding: EdgeInsets.all(5.0),
          child: Text('bounceIn'),
        ),
        Curves.bounceOut: Padding(
          padding: EdgeInsets.all(5.0),
          child: Text('bounceOut'),
        ),
        Curves.decelerate: Padding(
          padding: EdgeInsets.all(5.0),
          child: Text('decelerate'),
        ),
        Curves.easeInBack: Padding(
          padding: EdgeInsets.all(5.0),
          child: Text('easeInBack'),
        ),
        Curves.easeInCirc: Padding(
          padding: EdgeInsets.all(5.0),
          child: Text('easeInCirc'),
        ),
        Curves.easeInCubic: Padding(
          padding: EdgeInsets.all(5.0),
          child: Text('easeInCubic'),
        ),
        Curves.easeInExpo: Padding(
          padding: EdgeInsets.all(5.0),
          child: Text('easeInExpo'),
        ),
        Curves.easeInOut: Padding(
          padding: EdgeInsets.all(5.0),
          child: Text('easeInOut'),
        ),
        Curves.easeInOutBack: Padding(
          padding: EdgeInsets.all(5.0),
          child: Text('easeInOutBack'),
        ),
        Curves.easeInOutCirc: Padding(
          padding: EdgeInsets.all(5.0),
          child: Text('easeInOutCirc'),
        ),
        Curves.slowMiddle: Padding(
          padding: EdgeInsets.all(5.0),
          child: Text('slowMiddle'),
        ),
        Curves.fastOutSlowIn: Padding(
          padding: EdgeInsets.all(5.0),
          child: Text('fastOutSlowIn'),
        ),
      },
      onValueChanged: (v) {
        if (show == true) {
          _showCurve = v;
        } else {
          _hideCurve = v;
        }
        fresh();
      },
      groupValue: show == true ? _showCurve : _hideCurve,
    );
  }

  Widget get messageChild {
    switch (type) {
      case ChildType.msg:
        return Container(
          child: Text(
            '今天有大雨，记得带伞🌲😯',
          ),
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.black38,
              borderRadius: BorderRadius.all(Radius.circular(10))),
        );
      case ChildType.img:
        return Container(
          child: Image.asset(
            'img/0.jpeg',
            fit: BoxFit.fitWidth,
          ),
          height: 100,
          width: 200,
          decoration: BoxDecoration(
              color: Colors.black38,
              borderRadius: BorderRadius.all(Radius.circular(10))),
        );
      case ChildType.view:
        return Container(
          child: Row(
            children: [
              Image.asset(
                'img/0.jpeg',
                fit: BoxFit.fitWidth,
              ),
              Expanded(
                child: Text(
                  'www.fgyong.cn \n 快来关注我 www.github/ifgyong',
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
          height: 100,
          // width: 200,
          decoration: BoxDecoration(
              color: Colors.black38,
              borderRadius: BorderRadius.all(Radius.circular(10))),
        );
    }
  }

  Widget get child => Container(
        padding: EdgeInsets.only(top: 100),
        child: OutlineButton(
          child: Text('我是 child，可以 \n 点击 弹出提示框'),
          onPressed: () {
            setState(() {});
          },
        ),
      );
}
