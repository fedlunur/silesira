// import 'package:afrotieapp/models/itemDetails.dart';
import 'package:afrotieapp/models/product_model.dart';
import 'package:afrotieapp/pages/Add_property.dart';
import 'package:afrotieapp/pages/HomePage.dart';
import 'package:afrotieapp/pages/adding_accessories.dart';
import 'package:afrotieapp/pages/adding_car.dart';
import 'package:afrotieapp/pages/adding_electronics.dart';
import 'package:afrotieapp/pages/adding_fashion.dart';
import 'package:afrotieapp/pages/adding_house.dart';
import 'package:afrotieapp/pages/adding_other.dart';
import 'package:afrotieapp/pages/adding_services.dart';
import 'package:afrotieapp/pages/auth.dart';
import 'package:afrotieapp/pages/detail_page.dart';
import 'package:afrotieapp/pages/notification.dart';
import 'package:afrotieapp/pages/onboarding.dart';
import 'package:afrotieapp/pages/postedproperties.dart';
import 'package:afrotieapp/pages/profile.dart';
import 'package:afrotieapp/pages/resetand%20forgotpassword.dart';
import 'package:afrotieapp/pages/splash.dart';
import 'package:afrotieapp/pages/transactiondetail.dart';
import 'package:afrotieapp/pages/watchlist.dart';
import 'package:flutter/material.dart';
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
      builder: (context, state) => const HomePage(),
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
      builder: (context, state) => const ProfilePage(),
    ),
    GoRoute(
      path: '/notifications',
      builder: (context, state) => const NotificationPage(),
    ),
    GoRoute(
      path: '/transactionhistory',
      builder: (context, state) => TransactionHistoryPage(),
    ),
    GoRoute(
      path: '/postedproperties',
      builder: (context, state) => const PostedPropertiesPage(),
    ),
    GoRoute(
      path: '/watchlist',
      builder: (context, state) => WatchlistPage(),
    ),
    GoRoute(
      path: '/detail',
      builder: (context, state) {
        final product = state.extra as Product?;
        if (product == null) {
          return Scaffold(
            appBar: AppBar(title: const Text('Error')),
            body: const Center(child: Text('No product details available.')),
          );
        }
        return DetailsPage(product: product);
      },
    ),
    GoRoute(
      path: '/addproperty',
      builder: (context, state) => AddPropertyPage(),
    ),
    GoRoute(
      path: '/addhouseproperty',
      builder: (context, state) => const AddingHousePages(),
    ),
    GoRoute(
      path: '/addcarproperty',
      builder: (context, state) => const AddingCarPage(),
    ),
    GoRoute(
      path: '/addaccessoryproperty',
      builder: (context, state) => const AddingAccessoryPage(),
    ),
    GoRoute(
      path: '/addfashionproperty',
      builder: (context, state) => const AddingFashionPage(),
    ),
    GoRoute(
      path: '/addelectronicsproperty',
      builder: (context, state) => const AddingElectronicsPage(),
    ),
    GoRoute(
      path: '/addservices',
      builder: (context, state) => const AddingServicePage(),
    ),
    GoRoute(
      path: '/addotherservices',
      builder: (context, state) => const OtherServicePage(),
    ),
  ],
);
