import 'package:bloc/bloc.dart';
import '../../models/fire_model.dart';

import '../../services/fires_service.dart';

part 'fires_event.dart';
part 'fires_state.dart';

class FiresBloc extends Bloc<FiresEvent, FiresState> {
  FiresBloc() : super(FiresInitial()) {
    on<FetchFiresEvent>(
      (event, emit) async {
        emit(FiresLoading());
        try {
          final fires = await fetchFireData();
          emit(
            FiresSuccess(
              fires: fires,
            ),
          );
        } catch (error) {
          print('-----------<<exception is $error');
          emit(
            FiresError(
              errorMessage: 'Failed to fetch data',
            ),
          );
        }
      },
    );
  }
}
