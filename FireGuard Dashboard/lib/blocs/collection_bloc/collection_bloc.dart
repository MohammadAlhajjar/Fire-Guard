import 'dart:convert';

import 'package:bloc/bloc.dart';
import '../../models/collection_system_model.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import '../../main.dart';

part 'collection_event.dart';
part 'collection_state.dart';

class CollectionBloc extends Bloc<CollectionEvent, CollectionState> {
  CollectionBloc() : super(CollectionInitial()) {
    on<FetchColllectionSystemForMap>((event, emit) async {
      emit(CollectionLoading());
      try {
        final response = await http.get(
          Uri.parse(
              'https://firegard.cupcoding.com/backend/public/api/admin/collection-systems'),
          headers: {
            'Authorization': 'Bearer ${sharedPreferences.getString('token')}'
          },
        );
        print('========================');
        print(response.body);
        if (response.statusCode == 200) {
          var data = json.decode(response.body);
          CollectionSystemModel collectionSystemModel =
              CollectionSystemModel.fromMap(data['data']);
          emit(CollectionSuccess(
            collectionSystemModel: collectionSystemModel,
          ));
        } else {
          emit(CollectionError(errorMessage: 'Failed to fetch data'));
        }
      } catch (error) {
        emit(CollectionError(errorMessage: error.toString()));
      }
    });
  }
}
