import 'package:bloc/bloc.dart';
import 'package:fire_guard_app/src/features/fire_tasks/data/models/fire_node_model.dart';
import 'package:fire_guard_app/src/features/fire_tasks/data/models/fire_station_center_model.dart';
import 'package:fire_guard_app/src/features/fire_tasks/data/respository/fire_node_repository.dart';
import 'package:fire_guard_app/src/features/fire_tasks/data/respository/fire_station_center_repository.dart';
import 'package:meta/meta.dart';

import '../../../../../../core/helper/bloc_helper.dart';

part 'fire_station_center_details_event.dart';
part 'fire_station_center_details_state.dart';

class FireStationCenterDetailsAndFireNodesBloc
    extends Bloc<FireStationCenterDetailsEvent, FireStationCenterDetailsState> {
  final FireNodeRepo fireNodeRepo;
  final FireStationCenterRepo fireStationCenterRepo;
  FireStationCenterDetailsAndFireNodesBloc({
    required this.fireStationCenterRepo,
    required this.fireNodeRepo,
  }) : super(FireStationCenterDetailsInitial()) {
    on<GetFireStationCenterDetailsAndFireNodes>((event, emit) async {
      emit(FireStationCenterLoading());
      var failureOrFireStationCenterDetails =
          await fireStationCenterRepo.getFireStationCenterDetails();
      var failureOrFireNodes = await fireNodeRepo.getFireNodes();

      List<FireNodeModel> fireNodes = [];

      failureOrFireNodes.fold((filure) {}, (nodes) {
        fireNodes = nodes;
      });

      failureOrFireStationCenterDetails.fold((failure) {
        emit(
          FireStationCenterDetailsFailure(
            errorMessage: FailureHelper.mapFailureToMessage(
              failure,
            ),
          ),
        );
      }, (fireStationCenterDetails) {
        print(fireNodes);
        emit(
          FireStationCenterSuccess(
            fireStationCentersDetails: fireStationCenterDetails,
            fireNodes: fireNodes,
          ),
        );
      });
    });
  }
}
