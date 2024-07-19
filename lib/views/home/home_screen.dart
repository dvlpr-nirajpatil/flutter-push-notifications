import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:push_notify/services/auth_service.dart';
import 'package:push_notify/views/auth/signin_screen.dart';
import 'package:push_notify/views/messages/message_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static String id = "HomeScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HOME SCREEN"),
        actions: [
          IconButton(
            onPressed: () {
              GoRouter.of(context).goNamed(MessagesScreen.id);
            },
            icon: Icon(Icons.message),
          ),
          IconButton(
            onPressed: () {
              Auth.instance.signOut();
              GoRouter.of(context).goNamed(SignInScreen.id);
            },
            icon: Icon(Icons.logout_sharp),
          ),
        ],
      ),
    );
  }
}
