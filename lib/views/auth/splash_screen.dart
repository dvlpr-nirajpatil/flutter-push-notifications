import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:push_notify/services/auth_service.dart';
import 'package:push_notify/views/auth/signin_screen.dart';
import 'package:push_notify/views/home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static String id = "SplashScreen";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState

    Future.delayed(Duration.zero, () {
      GoRouter.of(context)
          .goNamed(Auth.instance.isLogin ? HomeScreen.id : SignInScreen.id);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
