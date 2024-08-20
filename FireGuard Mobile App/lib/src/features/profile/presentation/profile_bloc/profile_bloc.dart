// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fire_guard_app/core/helper/bloc_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import 'package:fire_guard_app/src/features/profile/data/model/fire_brigade_profile_model.dart';
import 'package:fire_guard_app/src/features/profile/data/repository/profile_repository.dart';


part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileRepository profileRepository;
  ProfileBloc({
    required this.profileRepository,
  }) : super(ProfileInitial()) {
    on<GetFireBrigadeProfile>((event, emit) async {
      emit(ProfileLoading());

      var failureOrProfile = await profileRepository.getFireBrigadeProfile();

      failureOrProfile.fold((failure) {
        emit(
          ProfileFailure(
            errorMessage: FailureHelper.mapFailureToMessage(
              failure,
            ),
          ),
        );
      }, (profile) {
        emit(
          ProfileSuccess(
            fireBrigadePofileModel: profile,
          ),
        );
      });
    });
  }
}
