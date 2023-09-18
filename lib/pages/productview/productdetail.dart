import 'package:escuelasapi/bloc/app/app_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductPage extends StatefulWidget {
  final int product;
  final int id;
  const ProductPage({super.key, required this.product,required this.id});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
          return SafeArea(
              child: PageView.builder(
            itemCount: state.dataApi!.length,
            itemBuilder: (context, index) {
              return Hero(
                tag: widget.id.toString(),
                child: Image.network(
                  state.dataApi![widget.product].images[index],
                ),
              );
            },
          ));
        },
      ),
    );
  }
}
