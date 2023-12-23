import 'package:escuelasapi/bloc/app/app_cubit.dart';
import 'package:escuelasapi/pages/home/parts/categories.dart';
import 'package:escuelasapi/pages/home/parts/header.dart';
import 'package:escuelasapi/pages/home/parts/products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<AppCubit, AppState>(
          buildWhen: (previous, current) {
             return previous.filteredData != current.filteredData;
          },
          builder: (context, state) {
            if (state is InitializedApi) {
              return CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverPersistentHeader(
                    delegate: Header(),
                    pinned: false,
                    floating: true,
                  ),
                  SliverPersistentHeader(
                    delegate: CategoriesHeader(),
                    pinned: true,
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 20).add(
                      const EdgeInsets.only(top: 10),
                    ),
                    sliver: Products(state: state),
                    
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
        ),
      ),
    );
  }
}
