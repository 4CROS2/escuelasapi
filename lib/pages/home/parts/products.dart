import 'package:escuelasapi/bloc/app/app_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masonry_grid/masonry_grid.dart';

class Products extends StatefulWidget {
  const Products({super.key});

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        if (state is InitializedApi) {
          return MasonryGrid(
            column: 2,
            children: [
              Container(
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.12),
                    blurRadius: 12,
                    offset: const Offset(2, 10),
                  )
                ]),
                child: Column(
                  children: [
                    ...state.dataApi.products.map((product) {
                      return Column(
                        children: [
                          Text('')
                        ],
                      );
                    })
                  ],
                ),
              )
            ],
          );
        } else if (state is ErrorState) {
          return Center(
            child: Text(state.text),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
