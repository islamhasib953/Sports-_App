import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_fiers/Screens/onboarding_screen.dart';
class splashscreen extends StatefulWidget {
   splashscreen({super.key});

  @override
  State<splashscreen> createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen> with SingleTickerProviderStateMixin {
  late AnimationController _logocontroller;
  
  @override
  void initState() {
    super.initState();
    _logocontroller = AnimationController(vsync: this, duration: Duration(seconds: 1));
    _logocontroller.forward();

    Timer(
      Duration(seconds: 2), () {
       Navigator.pushReplacement(
         context,
        MaterialPageRoute(builder: (context) =>PageSwapperWidget()),
       );
    });
  }

  @override
  Widget build(BuildContext context) {
    final double splashscreenHeight = MediaQuery.of(context).size.height;
    final double splashscreenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.white,
                    Colors.white,
                    Color.fromRGBO(101, 158, 199, 1),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
             Center(
              child: ScaleTransition(
                scale: _logocontroller,
                child: Image.asset(
                  "lib/Assets/Images/Remove background project (6).png",
                  height: splashscreenHeight * 0.2, // Responsive image height
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _logocontroller.dispose();
    super.dispose();
  }
}