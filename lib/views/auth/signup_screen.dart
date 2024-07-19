import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:push_notify/services/auth_service.dart';
import 'package:push_notify/services/notification_service.dart';
import 'package:push_notify/views/home/home_screen.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});
  static String id = "SignUpScreen";

  TextEditingController emailField = TextEditingController();
  TextEditingController passField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.all(20),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "SIGN UP",
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: emailField,
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: passField,
            ),
            SizedBox(
              height: 30,
            ),
            FilledButton(
              onPressed: () {
                Auth.instance.signUp(emailField.text, passField.text).then(
                  (status) {
                    if (status == Status.success) {
                      GoRouter.of(context).goNamed(HomeScreen.id);
                      NotificationService.instance.storeFcmToken();
                    }
                  },
                );
              },
              child: Text("Sign Up"),
            )
          ],
        ),
      ),
    );
  }
}
