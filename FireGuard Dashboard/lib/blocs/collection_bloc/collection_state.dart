part of 'collection_bloc.dart';

@immutable
sealed class CollectionState {}

final class CollectionInitial extends CollectionState {}

final class CollectionSuccess extends CollectionState {
  final CollectionSystemModel collectionSystemModel;

  CollectionSuccess({required this.collectionSystemModel});
}

final class CollectionLoading extends CollectionState {}

final class CollectionError extends CollectionState {
  final String errorMessage;

  CollectionError({required this.errorMessage});
}
