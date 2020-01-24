import 'dart:math';

import 'package:flutter/material.dart';
import '../widgets/cat.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  Animation<double> catAnimation;
  AnimationController catController;

  Animation<double> boxAnimation;
  AnimationController boxAnimationController;

  @override
  void initState() {
    super.initState();
    catController = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );

    //! Tween Untuk mengatur awal dan akhir seperti animasi dari bawah ke atas

    catAnimation = Tween(begin: -50.0, end: -80.0).animate(
      CurvedAnimation(
        parent: catController,
        curve: Curves.easeIn,
      ),
    );

    boxAnimationController = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );

    boxAnimation = Tween(begin: pi * 0.6, end: pi * 0.85).animate(
      CurvedAnimation(
        parent: boxAnimationController,
        curve: Curves.easeInOut,
      ),
    );
    boxAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        boxAnimationController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        boxAnimationController.forward();
      }
    });
    boxAnimationController.forward();
  }

  void onTap() {
    boxAnimationController.stop();
    if (catController.isCompleted) {
      boxAnimationController.forward();
      catController.reverse();
    } else if (catController.isDismissed) {
      boxAnimationController.stop();
      catController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animation Cat'),
      ),
      body: Container(
        color: Colors.blue,
        child: GestureDetector(
          onTap: onTap,
          child: Center(
            child: Stack(
              overflow: Overflow.visible,
              children: <Widget>[
                buildCatAnimation(),
                buildBox(),
                buildLeftFlap(),
                buildRightFlap(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildCatAnimation() {
    return AnimatedBuilder(
      animation: catAnimation,
      builder: (context, child) {
        return Positioned(
          child: child,
          top: catAnimation.value,
          right: 0,
          left: 0,
        );
      },
      child: Cat(),
    );
  }

  Widget buildBox() {
    return Container(
      constraints: BoxConstraints.expand(height: 200.0, width: 200.0),
      decoration: BoxDecoration(color: Colors.brown),
    );
  }

  Widget buildLeftFlap() {
    return Positioned(
      left: 10.0,
      child: AnimatedBuilder(
        animation: boxAnimation,
        child: Container(
          constraints: BoxConstraints.expand(height: 10, width: 125),
          color: Colors.brown[800],
        ),
        builder: (BuildContext context, Widget child) {
          return Transform.rotate(
            angle: boxAnimation.value,
            child: child,
            alignment: Alignment.topLeft,
          );
        },
      ),
    );
  }

  Widget buildRightFlap() {
    return Positioned(
      right: 10.0,
      child: AnimatedBuilder(
        animation: boxAnimation,
        child: Container(
          constraints: BoxConstraints.expand(height: 10, width: 125),
          color: Colors.brown[800],
        ),
        builder: (BuildContext context, Widget child) {
          return Transform.rotate(
            angle: -boxAnimation.value,
            child: child,
            alignment: Alignment.topRight,
          );
        },
      ),
    );
  }
}
