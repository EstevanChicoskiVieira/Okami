import 'dart:async';
import 'package:flutter/material.dart';
import 'home.dart';

class LoadPage extends StatefulWidget {
  const LoadPage({Key? key}) : super(key: key);

  @override
  _LoadPageState createState() => _LoadPageState();
}

class _LoadPageState extends State<LoadPage> {
  double imageSize = 70.0;
  int duration = 2000;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    goToHome();
    startGrowingImage();
  }

  void goToHome() async {
    await Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
            (Route<dynamic> route) => false,
      );
    });
  }

  void startGrowingImage() {
    timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() {
        imageSize += 20.0;
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedContainer(
              width: imageSize,
              height: imageSize,
              duration: Duration(milliseconds: duration),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('Assets/Logo.png'),
                  fit: BoxFit.contain, // Alterado para BoxFit.contain
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}