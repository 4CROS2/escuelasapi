import 'package:escuelasapi/bloc/app/app_cubit.dart';
import 'package:escuelasapi/pages/productview/productdetail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
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
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            column: 2,
            children: [
              ...List.generate(state.dataApi.length, (index) {
                return FutureBuilder(
                  future: Future.delayed(Duration(milliseconds: 200 * index)),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return const SizedBox.shrink();
                      default:
                        return AnimatedOpacity(
                          duration: Duration(milliseconds: 200 * index) ,
                          opacity: snapshot.connectionState == ConnectionState.done ? 1 : 0,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(context, CupertinoPageRoute(builder: (context) => ProductPage(product: index,id:state.dataApi[index].id),));
                            },
                            child: Hero(
                              tag: state.dataApi[index].id.toString(),
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(.12),
                                    blurRadius: 12,
                                    offset: const Offset(2, 10),
                                  )
                                ]),
                                child: Column(
                                  children: [
                                    /* CachedNetworkImage(
                                      imageUrl: state.dataApi[index].images.first,
                                      placeholder: (context, url) => const CircularProgressIndicator(),
                                      errorWidget: (context, url, error) => const Icon(Icons.error),
                                    ),
                                     */
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(7),
                                      child: Image.network(
                                        state.dataApi[index].images.first,
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      height: 50,
                                      child: Text(
                                        state.dataApi[index].title,
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.redHatText(
                                          textStyle: const TextStyle(
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                    }
                  },
                );
              }),
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
