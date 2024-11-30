import 'package:afrotieapp/pages/HomePage.dart';
import 'package:afrotieapp/pages/auth.dart';
import 'package:afrotieapp/pages/home_page.dart';
import 'package:afrotieapp/pages/onboarding.dart';
import 'package:afrotieapp/pages/postedproperties.dart';
import 'package:afrotieapp/pages/profile.dart';
import 'package:afrotieapp/pages/resetand%20forgotpassword.dart';
import 'package:afrotieapp/pages/search_and_filter_page.dart';
import 'package:afrotieapp/pages/splash.dart';
import 'package:afrotieapp/pages/transactiondetail.dart';
import 'package:afrotieapp/pages/watchlist.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  initialLocation: '/home',
  routes: [
    GoRoute(
      path: '/splash',
      builder: (context, state) => SplashScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => HomePage(),
    ),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingPage(),
    ),
    GoRoute(
      path: '/auth',
      builder: (context, state) => const AuthPage(),
    ),
    GoRoute(
        path: '/forgetresset',
        builder: (context, state) {
          final isResetMode = state.extra != null &&
              (state.extra as Map)['isResetMode'] == true;
          return ForgetResetPasswordPage(isResetMode: isResetMode);
        }),
    GoRoute(
      path: '/profile',
      builder: (context, state) => ProfilePage(),
    ),
    GoRoute(
      path: '/transactionhistory',
      builder: (context, state) => TransactionHistoryPage(),
    ),
    GoRoute(
      path: '/postedproperties',
      builder: (context, state) => PostedPropertiesPage(),
    ),
    GoRoute(
      path: '/watchlist',
      builder: (context, state) => WatchlistPage(),
    ),

    //     GoRoute(
    //   path: '/filter',
    //   builder: (context, state) => SearchAndFilterPage(),
    // ),
    //AuthPage
    // Add more routes here as needed
  ],
);
