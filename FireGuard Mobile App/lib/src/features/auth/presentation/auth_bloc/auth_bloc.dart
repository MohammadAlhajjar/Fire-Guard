// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fire_guard_app/core/error/fauilers.dart';
import 'package:fire_guard_app/core/helper/bloc_helper.dart';
import 'package:fire_guard_app/src/features/auth/data/model/sign_in_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import 'package:fire_guard_app/src/features/auth/data/repository/sign_in_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  SignInRepo signInRepo;
  AuthBloc({
    required this.signInRepo,
  }) : super(AuthInitial()) {
    on<SignInEvent>((event, emit) async {
      emit(SignInLoadingState());
      print('===========================');
      var result = await signInRepo.signIn(event.signInModel);

      result.fold((failure) {
        print(failure);
        emit(
          SignInFailureState(
            errorMessage: FailureHelper.mapFailureToMessage(failure),
          ),
        );
      }, (success) {
        emit(SignInSuccessState());
      });
    });
  }
}
