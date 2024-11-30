import 'package:afrotieapp/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ForgetResetPasswordPage extends StatefulWidget {
  final bool isResetMode;
  const ForgetResetPasswordPage({super.key, this.isResetMode = false});

  @override
  State<ForgetResetPasswordPage> createState() =>
      _ForgetResetPasswordPageState();
}

class _ForgetResetPasswordPageState extends State<ForgetResetPasswordPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  late bool isResetMode;
  bool isPasswordCorrect = false;

  @override
  void initState() {
    super.initState();
    isResetMode = widget.isResetMode;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    double appBarHeight = MediaQuery.of(context).size.height * 0.08;
    double fontSize = MediaQuery.of(context).size.width < 360 ? 20 : 22;
    double verticalSpacing = MediaQuery.of(context).size.height * 0.02;
    double fieldSpacing = MediaQuery.of(context).size.height * 0.03;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(appBarHeight),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppTheme.customColor, Color(0xFF112D4E)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.zero,
          ),
          child: AppBar(
            title: Padding(
              padding: EdgeInsets.only(top: appBarHeight * 0.2),
              child: Text(
                isResetMode ? 'Reset Password' : 'Forgot Password',
                style: theme.textTheme.headlineSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: fontSize,
                ),
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            leading: Padding(
              padding: EdgeInsets.only(top: appBarHeight * 0.2),
              child: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  if (GoRouter.of(context).canPop()) {
                    GoRouter.of(context).pop();
                  } else {
                    GoRouter.of(context).go('/home');
                  }
                },
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        // Enable scrolling when keyboard is up
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFF9F7F7), AppTheme.customColor],
            ),
          ),
          child: SafeArea(
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      isResetMode ? "Reset Password" : "Forgot Password",
                      textAlign: TextAlign.center,
                      style: theme.textTheme.headlineMedium
                          ?.copyWith(color: AppTheme.customColor),
                    ),
                    SizedBox(height: verticalSpacing),
                    Text(
                      isResetMode
                          ? "Enter your new password below"
                          : "Enter your email address to receive a password reset link.",
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    SizedBox(height: fieldSpacing),
                    // Email Field (only visible in Forgot Password mode)
                    if (!isResetMode)
                      TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          labelText: "Email Address",
                          filled: true,
                          fillColor: Color(0xFFDBE2EF),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    SizedBox(height: fieldSpacing),
                    if (isResetMode || isPasswordCorrect) ...[
                      // New Password Field
                      TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: "New Password",
                          filled: true,
                          fillColor: Color(0xFFDBE2EF),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      SizedBox(height: fieldSpacing),
                      // Confirm Password Field
                      TextField(
                        controller: confirmPasswordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: "Confirm New Password",
                          filled: true,
                          fillColor: Color(0xFFDBE2EF),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      SizedBox(height: fieldSpacing),
                    ],
                    // Action Button
                    ElevatedButton(
                      onPressed: () {
                        if (!isResetMode) {
                          String email = emailController.text;
                          if (email.isNotEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content:
                                    Text('Reset password link sent to $email'),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content:
                                    Text('Please enter a valid email address'),
                              ),
                            );
                          }
                        } else {
                          String email = emailController.text;
                          String password = passwordController.text;
                          String confirmPassword =
                              confirmPasswordController.text;
                          if (password.isNotEmpty &&
                              confirmPassword.isNotEmpty &&
                              password == confirmPassword) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    'Password reset successful for $email'),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'Please fill in all fields and ensure passwords match'),
                              ),
                            );
                          }
                        }
                      },
                      child: Text(
                        isResetMode ? "Reset Password" : "Send Reset Link",
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: Colors.white),
                      ),
                    ),
                    SizedBox(height: verticalSpacing),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          isResetMode = !isResetMode;
                        });
                      },
                      child: Text(
                        isResetMode
                            ? "Forgot your email? Go back to forget password"
                            : "Have a reset link? Go back to reset password",
                        style: theme.textTheme.bodySmall
                            ?.copyWith(color: Color(0xFF112D4E)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
