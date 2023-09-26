import 'package:escuelasapi/bloc/app/app_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:palette_generator/palette_generator.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitial());

  changeViewportFraction({required double viewportFraction}) {
    emit(state.copyWith(pageValue: viewportFraction));
  }

  void dominantColor({context, required int imageIndex}) async {
    List<Color> colors = [];
    AppCubit product = BlocProvider.of<AppCubit>(context);
    bool verification = product.state.filteredData!.isEmpty;
    List<String> images = verification ? product.state.dataApi![imageIndex].images : product.state.filteredData![imageIndex].images; 
    int itemPosition = 0;
    for (var image in images) {
      final PaletteGenerator colorGenerated = await PaletteGenerator.fromImageProvider(NetworkImage(image));
      colors.insert(itemPosition, colorGenerated.dominantColor!.color);
      itemPosition++;
    }
    emit(state.copyWith(predominantColor: colors));
  }
}
