import 'package:api/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:try_aplus/features/auth/signup_screen.dart';
import 'package:try_aplus/utils/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final String token;
  @override
  void initState() {
    print('login screen init state');
    final api = context.read<ApiRepository>();
    print('storage: ${api.storage.toString()}');
    token = api.storage.read<String>('token') ?? '';
    print('login screen token: $token');
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
            Text('Login Screen $token'),
            ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  Routes.dashboardScreen(),
                  (_) => false,
                );
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => const SignupScreen(),
                //   ),
                // );
              },
              child: const Text('Goto Signup'),
            ),
          ],
        ),
      ),
    );
  }
}
