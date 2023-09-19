import 'package:cached_network_image/cached_network_image.dart';
import 'package:escuelasapi/bloc/app/app_cubit.dart';
import 'package:escuelasapi/bloc/app/model/apimodel.dart';
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
      buildWhen: (previous, current) {
        return previous.filteredData != current.filteredData && current is InitializedApi;
      },
      builder: (context, state) {
        if (state is InitializedApi) {
          int produtsLength = state.filteredData.isEmpty ? state.dataApi.length : state.filteredData.length;
          List<Api> data = state.filteredData.isEmpty ? state.dataApi : state.filteredData;
          return Column(
            children: [
              MasonryGrid(
                crossAxisSpacing: 10,
                mainAxisSpacing: 20,
                column: 2,
                children: [
                  ...List.generate(produtsLength, (index) {
                    return FutureBuilder(
                      future: Future.delayed(Duration(milliseconds: 200 * index)),
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return const SizedBox.shrink();
                          default:
                            return AnimatedOpacity(
                              duration: Duration(milliseconds: 200 * index),
                              opacity: snapshot.connectionState == ConnectionState.done ? 1 : 0,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                      builder: (context) => ProductPage(product: index, id: state.filteredData[index].id),
                                    ),
                                  );
                                },
                                child: Material(
                                  child: Hero(
                                    tag: data[index].id.toString(),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                                      clipBehavior: Clip.hardEdge,
                                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(.12),
                                          blurRadius: 6,
                                          offset: const Offset(2, 2),
                                        )
                                      ]),
                                      child: Column(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(7),
                                            child: CachedNetworkImage(
                                              progressIndicatorBuilder: (context, url, progress) => Center(
                                                child: CircularProgressIndicator(
                                                  value: progress.downloaded.toDouble(),
                                                ),
                                              ),
                                              imageUrl: data[index].images.first,
                                              fit: BoxFit.cover,
                                              errorWidget: (context, url, error) => const Icon(Icons.error),
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            height: 50,
                                            child: Text(
                                              data[index].title,
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.redHatText(
                                                textStyle: const TextStyle(
                                                  fontSize: 14,
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
                              ),
                            );
                        }
                      },
                    );
                  }),
                ],
              ),
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
