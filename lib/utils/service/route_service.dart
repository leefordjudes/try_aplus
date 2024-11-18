import 'package:flutter/material.dart';
import 'package:try_aplus/features/auth/auth.dart';
import 'package:try_aplus/features/dashboard/dashboard_screen.dart';

import '../../splash/splash.dart';

class NoAnimationMaterialPageRoute<T> extends MaterialPageRoute<T> {
  NoAnimationMaterialPageRoute({
    required super.builder,
    super.settings,
    super.maintainState = true,
    super.fullscreenDialog,
  });

  @override
  Duration get transitionDuration => const Duration(milliseconds: 0);
}

abstract class Routes {
  static Route<void> splashScreen() {
    print('route splash screen');
    return NoAnimationMaterialPageRoute<void>(
      builder: (ctx) => const SplashScreen(),
    );
  }

  static Route<void> loginScreen() {
    print('route login screen');
    return NoAnimationMaterialPageRoute<void>(
      builder: (ctx) => const LoginScreen(),
    );
  }

  static Route<void> dashboardScreen() {
    print('route dashboard screen');
    return NoAnimationMaterialPageRoute<void>(
      builder: (ctx) => const DashboardScreen(),
    );
  }

  static Route<void> signupScreen() {
    print('route signup screen');
    return NoAnimationMaterialPageRoute<void>(
      builder: (ctx) => const SignupScreen(),
    );
  }
}
