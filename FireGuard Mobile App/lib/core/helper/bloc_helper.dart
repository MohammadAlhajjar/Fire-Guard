import 'package:flutter_bloc/flutter_bloc.dart';

import '../error/fauilers.dart';

class FailureHelper{
  static String mapFailureToMessage(Failure failure) {
  switch (failure.runtimeType) {
    case OfflineFailure _:
      return 'Please check your internet connection....';
    case ServerFailure _:
      return 'Please check your credentials....';
    default:
      return 'Server problem, Please try again later....';
  }
}
}

class MyBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    print('onCreate -- ${bloc.runtimeType}');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('onChange -- ${bloc.runtimeType}, $change');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('onError -- ${bloc.runtimeType}, $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    print('onClose -- ${bloc.runtimeType}');
  }
}