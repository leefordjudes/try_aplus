import 'package:api/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:try_aplus/features/auth/login_screen.dart';
import 'package:try_aplus/utils/utils.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  NavigatorState get _navigator => _navigatorKey.currentState!;
  @override
  void initState() {
    print('signup screen init state');
    final api = context.read<ApiRepository>();
    print('storage: ${api.storage.toString()}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Try Aplus'),
      ),
      body: Center(
        child: Column(
          children: [
            const Text('Signup Screen'),
            ElevatedButton(
              onPressed: () {
                _navigator.pushAndRemoveUntil(
                  Routes.loginScreen(),
                  (_) => false,
                );
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => const LoginScreen(),
                //   ),
                // );
              },
              child: const Text('Goto Login'),
            ),
          ],
        ),
      ),
    );
  }
}
