// ignore_for_file: overridden_fields

part of 'app_cubit.dart';

class AppState extends Equatable {
  final List<Api>? dataApi;
  final List<Api>? filteredData;
  const AppState({this.dataApi, this.filteredData});

  @override
  List<Object> get props => [dataApi!, filteredData!];

  AppState copyWith({
    List<Api>? dataApi,
    List<Api>? filteredData,
  }) {
    return AppState(dataApi: dataApi ?? this.dataApi, filteredData: filteredData ?? this.filteredData);
  }
}

final class AppInitial extends AppState {}

final class InitializedApi extends AppState {
  @override
  final List<Api> dataApi;
  @override
  final List<Api> filteredData;
  const InitializedApi(
    {required this.dataApi,
    required this.filteredData,}
  );

  @override
  List<Object> get props => [dataApi, filteredData];
}

final class ErrorState extends AppState {
  final String text;
  const ErrorState({required this.text});
  @override
  List<Object> get props => [text];
}
