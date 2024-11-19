// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:try_aplus/common/bloc/auth/auth.dart';
// import 'package:try_aplus/features/auth/auth.dart';
// import 'package:try_aplus/features/dashboard/dashboard_screen.dart';
import 'package:toastification/toastification.dart';
import 'package:get_storage/get_storage.dart';

import 'package:api/lib.dart';
import 'package:tools/tools.dart';

import 'utils/utils.dart' show Routes;
import 'common/common.dart' show Toast;
import 'app_bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();
  Bloc.observer = AppBlocObserver();

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        RepositoryProvider(
          create: (context) => ApiRepository(
            errorHandler: (errors) {
              print('errorHandler');
              final exception = errors.firstWhereOrNull(
                (element) => element.isNotNullOrEmpty,
              );
              if (exception != null) {
                print('toastError');
                Toast.error(exception);
              }
            },
            baseUrl: 'https://reqres.in1/api',
            storage: GetStorage(),
          ),
        ),
        BlocProvider(
          create: (context) =>
              AuthenticationBloc(api: context.read<ApiRepository>())
                ..add(AuthenticationInitEvent()),
        ),
      ],
      child: const AppView(),
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: _navigatorKey,
        theme: ThemeData(useMaterial3: false),
        onGenerateRoute: (_) => Routes.splashScreen(),
        builder: (context, child) {
          return BlocConsumer<AuthenticationBloc, AuthenticationState>(
            listener: (ctx, state) async {
              if (state is Unauthenticated) {
                print('state un authenticated');
                // child = const LoginScreen();
                _navigator.pushAndRemoveUntil(
                  Routes.loginScreen(),
                  (_) => false,
                );
              }
              if (state is Authenticated) {
                print('state Authenticated');
                // child = const DashboardScreen();
                _navigator.pushAndRemoveUntil(
                  Routes.dashboardScreen(),
                  (_) => false,
                );
              }
              if (state is AuthenticationFailure) {
                print('auth failure: ${state.error}');
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.error),
                    duration: const Duration(seconds: 10),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: const Color.fromARGB(200, 34, 34, 34),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    margin: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height - 100,
                      right: 20,
                      left: 20,
                    ),
                  ),
                );
                _navigator.pushAndRemoveUntil(
                  Routes.loginScreen(),
                  (_) => false,
                );
              }
            },
            builder: (context, state) {
              print('builder: $state');
              // Widget currentScreen = const LoginScreen();
              // if (state is Authenticated) {
              //   currentScreen = const DashboardScreen();
              // }
              // return currentScreen;
              return child!;
            },
          );
        },
      ),
    );
  }
}
