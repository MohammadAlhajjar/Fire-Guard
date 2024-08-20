import 'dart:convert';

import 'package:bloc/bloc.dart';
import '../../main.dart';
import 'package:meta/meta.dart';

import '../../services/login_service.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginButtonPressed>((event, emit) async {
      emit(LoginLoading());
      try {
        final response = await login(event.username, event.password);
        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          if (data['token'] != null && data['refreshToken'] != null) {
            sharedPreferences.setString(
              'token',
              data['token'],
            );
            emit(LoginSuccess());
          } else {
            emit(
              LoginFailure(
                errorMessage: 'Invalid credentials',
              ),
            );
          }
        } else {
          emit(
            LoginFailure(
              errorMessage: 'Login failed',
            ),
          );
        }
      } catch (error) {
        print('------------------<<Exception Login: $error>>----------------');
        emit(LoginFailure(errorMessage: 'An error occurred'));
      }
    });
  }
}
