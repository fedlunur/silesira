// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'package:afrotieapp/pages/resetand%20forgotpassword.dart';
import 'package:afrotieapp/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = false;
  Timer? _restoreFullscreenTimer;

  @override
  void initState() {
    super.initState();
    _setFullscreen();
  }

  @override
  void dispose() {
    _restoreFullscreenTimer?.cancel();
    super.dispose();
  }

  void _setFullscreen() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
  }

  void _allowNotificationAccess() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    _restoreFullscreenTimer?.cancel();
    _restoreFullscreenTimer = Timer(const Duration(seconds: 5), _setFullscreen);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onVerticalDragStart: (_) => _allowNotificationAccess(),
      child: Scaffold(
        body: Stack(
          children: [
            // Background Gradient
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFFFAFAFA), Color(0xFF3F72AF)],
                ),
              ),
            ),
            // Decorative Circle
            Positioned(
              top: MediaQuery.of(context).padding.top - 50,
              left: -50,
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: AppTheme.customColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            // Content
            SafeArea(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child:
                      isLogin ? buildLoginForm(theme) : buildSignupForm(theme),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSignupForm(ThemeData theme) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          "Sign Up",
          textAlign: TextAlign.center,
          style: theme.textTheme.headlineMedium
              ?.copyWith(color: AppTheme.customColor),
        ),
        const SizedBox(height: 8),
        Text(
          "Join us and explore limitless opportunities!",
          textAlign: TextAlign.center,
          style:
              theme.textTheme.bodySmall?.copyWith(fontStyle: FontStyle.italic),
        ),
        const SizedBox(height: 32),
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.email),
          label: Text("Sign up with Google", style: theme.textTheme.bodyMedium),
        ),
        const SizedBox(height: 16),
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.phone),
          label: Text("Sign up with Phone", style: theme.textTheme.bodyMedium),
        ),
        const SizedBox(height: 32),
        TextButton(
          onPressed: () {
            setState(() {
              isLogin = true;
            });
          },
          child: Text("Already have an account? Log in",
              style: theme.textTheme.bodySmall),
        ),
      ],
    );
  }

  Widget buildLoginForm(ThemeData theme) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          "Log In",
          textAlign: TextAlign.center,
          style: theme.textTheme.headlineMedium
              ?.copyWith(color: AppTheme.customColor),
        ),
        const SizedBox(height: 8),
        Text(
          "Welcome back! Please log in to continue.",
          textAlign: TextAlign.center,
          style:
              theme.textTheme.bodySmall?.copyWith(fontStyle: FontStyle.italic),
        ),
        const SizedBox(height: 32),
        TextField(
          decoration: InputDecoration(
            labelText: "Email or Phone",
            filled: true,
            fillColor: Color(0xFFDBE2EF),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          obscureText: true,
          decoration: InputDecoration(
            labelText: "Password",
            filled: true,
            fillColor: Color(0xFFDBE2EF),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: 16),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ForgetResetPasswordPage()),
            );
          },
          child: Text(
            "Forgot Password?",
            style: theme.textTheme.bodySmall
                ?.copyWith(color: AppTheme.customColor),
          ),
        ),
        const SizedBox(height: 32),
        ElevatedButton(
          onPressed: () {
            context.push('/home');
          },
          child: Text("Log In",
              style: theme.textTheme.bodyLarge
                  ?.copyWith(color: AppTheme.customColor)),
        ),
        const SizedBox(height: 16),
        TextButton(
          onPressed: () {
            setState(() {
              isLogin = false;
            });
          },
          child: Text("Don't have an account? Sign up",
              style: theme.textTheme.bodySmall),
        ),
      ],
    );
  }
}
