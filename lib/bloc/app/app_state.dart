// ignore_for_file: overridden_fields

part of 'app_cubit.dart';

class AppState extends Equatable {
  final Api? dataApi;
  const AppState({this.dataApi});

  @override
  List<Object> get props => [dataApi!];

  AppState copyWith({
    Api? dataApi,
  }) {
    return AppState(dataApi: dataApi ?? this.dataApi);
  }
}

final class AppInitial extends AppState {}

final class InitializedApi extends AppState {
  @override
  final Api dataApi;
  const InitializedApi(
    this.dataApi,
  );

  @override
  List<Object> get props => [dataApi];
}

final class ErrorState extends AppState {
  final String text;
  const ErrorState({required this.text});
  @override
  List<Object> get props => [text];
}
