import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:push_notify/firebase_options.dart';
import 'package:push_notify/services/notification_service.dart';
import 'package:push_notify/views/auth/signin_screen.dart';
import 'package:push_notify/views/auth/signup_screen.dart';
import 'package:push_notify/views/auth/splash_screen.dart';
import 'package:push_notify/views/home/home_screen.dart';
import 'package:push_notify/views/messages/message_screen.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  NotificationService.instance.init();
  runApp(Notify());
}

class Notify extends StatelessWidget {
  Notify({super.key});

  GoRouter router = GoRouter(
    navigatorKey: navigatorKey,
    routes: [
      GoRoute(
        path: '/',
        name: SplashScreen.id,
        builder: (context, state) => SplashScreen(),
      ),
      GoRoute(
        path: '/auth',
        name: SignInScreen.id,
        builder: (context, state) => SignInScreen(),
        routes: [
          GoRoute(
            path: 'signup',
            name: SignUpScreen.id,
            builder: (context, state) => SignUpScreen(),
          )
        ],
      ),
      GoRoute(
        path: '/home',
        name: HomeScreen.id,
        builder: (context, state) => HomeScreen(),
        routes: [
          GoRoute(
            path: 'messages',
            name: MessagesScreen.id,
            builder: (context, state) => MessagesScreen(),
          )
        ],
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}
