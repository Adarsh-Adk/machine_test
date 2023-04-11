import 'package:flutter/material.dart';
import 'package:machine_test/custom_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.adb_sharp,
      size: 100,
      color: Colors.white,
    );
  }

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pushReplacementNamed(context, CustomRouter.homeScreen);
    });
    super.initState();
  }
}
