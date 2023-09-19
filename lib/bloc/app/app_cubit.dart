import 'dart:convert';

import 'package:escuelasapi/bloc/app/model/apimodel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  final String api = 'https://api.escuelajs.co/api/v1/products';
  AppCubit() : super(AppInitial());

  Future<void> getData() async {
    try {
      final response = await http.get(Uri.parse(api));
      if (response.statusCode == 200) {
        final apiModel = List<Api>.from(jsonDecode(response.body).map((model) => Api.fromJson(model)));
        emit(InitializedApi(dataApi: apiModel,filteredData: apiModel));
      } else {
        emit(const ErrorState(text: 'Error al obtener los datos de la API 1.'));
      }
    } catch (e) {
      emit(ErrorState(text: 'Error al obtener los datos de la API2. $e'));
    }
  }

  void filterData({required String filter}) {
    try {
      if (filter.toLowerCase() == 'all') {
        emit(InitializedApi(dataApi: state.dataApi!, filteredData:[] ));
      } else {
        final filteredData = state.dataApi?.where((element) => element.category.name == filter).toList();
        emit(InitializedApi(dataApi: state.dataApi!, filteredData: filteredData!));
      }
    } catch (e) {
      emit(ErrorState(text: 'error al filtrar: $e'));
    }
    
  }
}
