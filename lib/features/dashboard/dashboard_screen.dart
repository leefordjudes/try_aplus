import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:api/api.dart';
import 'package:try_aplus/utils/utils.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late final String token;
  @override
  void initState() {
    super.initState();
    print('dashboard init state');
    final api = context.read<ApiRepository>();
    token = api.storage.read<String>('token')!;
    print('storage: ${api.storage.toString()}');
    print('read token: $token');
    // api.storage.remove('token').then((res) {
    //   final tkn = api.storage.read<String>('token');
    //   print('after token remove: $tkn');
    // });
    // print('token remove');
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
            Text('Dashboard Screen $token'),
            ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  Routes.signupScreen(),
                  (_) => false,
                );
              },
              child: const Text('Goto Login'),
            ),
          ],
        ),
      ),
    );
  }
}
