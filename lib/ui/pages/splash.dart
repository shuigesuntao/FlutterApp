import 'package:flutter/material.dart';
import 'package:flutter_app/utils/utils_index.dart';
import 'package:flutter_app/common/common.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flukit/flukit.dart';

class SplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashPageState();
  }
}

class SplashPageState extends State<SplashPage> {
  TimerUtil _timerUtil;

  List<String> _guideList = [
    Utils.getImgPath('guide1'),
    Utils.getImgPath('guide2'),
    Utils.getImgPath('guide3'),
    Utils.getImgPath('guide4'),
  ];

  List<Widget> _bannerList = new List();

  ///0 欢迎页 1 倒计时中 2 引导页
  int _status = 0;
  int _count = 3;

  @override
  void initState() {
    super.initState();

    _initAsync();
  }

  void _initAsync() {
    Observable.just(1).delay(Duration(milliseconds: 1000)).listen((_) {
      if (!SpUtil.getBool(Constant.KEY_GUIDE) && _guideList.isNotEmpty)
        _initBanner();
      else
        _doCountDown();
    });
  }

  void _initBanner() {
    _initBannerData();
    setState(() {
      _status = 2;
    });
  }

  void _initBannerData() {
    for (int i = 0, length = _guideList.length; i < length; i++) {
      if (i == length - 1) {
        _bannerList.add(Stack(
          children: <Widget>[
            Image.asset(
              _guideList[i],
              fit: BoxFit.fill,
              width: double.infinity,
              height: double.infinity,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.only(bottom: 160.0),
                child: InkWell(
                  onTap: () {
                    _goMain();
                  },
                  child: CircleAvatar(
                    radius: 48.0,
                    backgroundColor: Colors.indigoAccent,
                    child: Padding(
                      padding: EdgeInsets.all(2.0),
                      child: Text(
                        '立即体验',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16.0, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ));
      } else
        _bannerList.add(Image.asset(
          _guideList[i],
          fit: BoxFit.fill,
          width: double.infinity,
          height: double.infinity,
        ));
    }
  }

  void _doCountDown() {
    setState(() {
      _status = 1;
    });
    _timerUtil = new TimerUtil(mTotalTime: 3 * 1000);
    _timerUtil.setOnTimerTickCallback((int tick) {
      double _tick = tick / 1000;
      setState(() {
        _count = _tick.toInt();
      });
      if (_tick == 0) {
        _goMain();
      }
    });
    _timerUtil.startCountDown();
  }

  void _goMain() {
    Navigator.of(context).pushReplacementNamed('/MainPage');
  }

  Widget _buildSplashBg() {
    return new Image.asset(
      Utils.getImgPath('splash'),
      width: double.infinity,
      height: double.infinity,
      fit: BoxFit.fill,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: <Widget>[
          Offstage(
            offstage: _status != 0,
            child: _buildSplashBg(),
          ),
          Offstage(
            offstage: _status != 2,
            child: _bannerList.isEmpty
                ? Container()
                : Swiper(
                    autoStart: false,
                    circular: false,
                    indicator: CircleSwiperIndicator(
                        radius: 4.0,
                        padding: EdgeInsets.only(bottom: 30.0),
                        itemColor: Colors.black26),
                    children: _bannerList,
                  ),
          ),
          Offstage(
            offstage: _status != 1,
            child: Container(
              alignment: Alignment.bottomRight,
              margin: EdgeInsets.all(12.0),
              child: InkWell(
                onTap: () {
                  _goMain();
                },
                child: Container(
                  padding: EdgeInsets.all(12.0),
                  child: Text(
                    '跳过$_count',
                    style: TextStyle(fontSize: 14.0, color: Colors.white),
                  ),
                  decoration: BoxDecoration(
                      color: Color(0x66000000),
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      border:
                          Border.all(width: 0.33, color: Color(0xffe5e5e5))),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    if (_timerUtil != null) _timerUtil.cancel(); //记得中dispose里面把timer cancel。
  }
}
