import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Frosted Glass',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> transforAnimation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    transforAnimation = new Tween(
      begin: 600.0,
      end: 0.0,
    ).animate(new CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOut,
    ));

    Future.delayed(Duration(milliseconds: 300), () {
      animationController.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    TextStyle black24Bold = TextStyle(
      color: Color(0xff4F4F4F),
      fontSize: 24,
      fontFamily: "SBold",
      fontWeight: FontWeight.w800,
    );

    TextStyle black16semibold = TextStyle(
      color: Color(0xff4F4F4F),
      fontSize: 16,
      fontFamily: "SSemiBold",
      fontWeight: FontWeight.w600,
    );

    TextStyle black14semibold = TextStyle(
      color: Color(0xff4F4F4F),
      fontSize: 14,
      fontFamily: "SSemiBold",
      fontWeight: FontWeight.w600,
    );

    TextStyle black14 = TextStyle(
      color: Color(0xff4F4F4F),
      fontSize: 14,
      fontFamily: "SReguler",
    );

    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "assets/images/bg.jpg",
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          AnimatedBuilder(
            animation: animationController,
            builder: (context, child) {
              return Transform.scale(
                scale: 1 - ((transforAnimation.value / 600.0) / 2),
                child: Transform.translate(
                  offset: Offset(0, transforAnimation.value),
                  child: Center(
                    child: ClipRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 10.0,
                          sigmaY: 10.0,
                        ),
                        child: Opacity(
                          opacity: 1 - (transforAnimation.value / 600.0),
                          child: Container(
                            width: 298,
                            height: 431,
                            decoration: new BoxDecoration(
                              color: Colors.white.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  "assets/images/ic_donut.svg",
                                  width: 62,
                                  height: 62,
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 23),
                                  child: Text(
                                    "DONUT",
                                    style: black24Bold,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(bottom: 26),
                                  width: 150,
                                  child: Text(
                                    "Don’t go nut, just eat the donut",
                                    textAlign: TextAlign.center,
                                    style: black16semibold,
                                  ),
                                ),
                                CupertinoButton(
                                  padding: EdgeInsets.all(0),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 14,
                                      horizontal: 72,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: Text(
                                      "Create Account",
                                      style: black14semibold,
                                    ),
                                  ),
                                  onPressed: () {
                                    animationController.reverse();
                                  },
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 26),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        "Already have account?",
                                        style: black14,
                                      ),
                                      Text(
                                        " Log In",
                                        style: black14semibold,
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
