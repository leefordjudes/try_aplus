import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:api/api.dart';
import 'package:api/user/user.dart';

part './authentication_event.dart';
part './authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final ApiRepository api;

  AuthenticationBloc({required this.api}) : super(Unauthenticated()) {
    on<AuthenticationInitEvent>(_onInit);
  }

  void _onInit(
    AuthenticationInitEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    print('AuthenticationInitEvent emited');
    // api.storage.remove('token');
    // api.storage.write('token', 'user-token1');
    final token = api.storage.read<String>('token');
    print('_onInit: token: $token');
    // Set member state
    if (token == null) {
      print('token null, unauthenticated');
      emit(Unauthenticated());
      api.storage.write('token', 'user-token1');
      return;
    }
    api.client.setHeader({'token': token});
    try {
      print('token available: $token');
      final UserProfileResponse profile = await api.getUserProfile();
      print('user: ${profile.toJson()}');
      return emit(Authenticated(user: profile));
    } catch (err) {
      print('AuthenticationInitEvent error: ${err.toString()}');
      return emit(AuthenticationFailure(err.toString()));
    }
  }
}
