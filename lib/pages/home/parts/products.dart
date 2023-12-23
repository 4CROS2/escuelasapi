import 'package:cached_network_image/cached_network_image.dart';
import 'package:escuelasapi/bloc/app/app_cubit.dart';
import 'package:escuelasapi/bloc/app/model/apimodel.dart';
import 'package:escuelasapi/pages/productview/productdetail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Products extends StatefulWidget {
  final AppState state;

  const Products({super.key, required this.state});

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  @override
  Widget build(BuildContext context) {
    bool collection = widget.state.filteredData!.isEmpty;
    List<Api>? data = collection ? widget.state.dataApi : widget.state.filteredData;
    final int produtsLength = data!.length;
    return SliverAnimatedGrid(
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10, childAspectRatio: 2.3 / 3),
      initialItemCount: produtsLength,
      itemBuilder: (context, index, animation) {
        return FadeTransition(
          opacity: CurvedAnimation(parent: animation, curve: Curves.easeInOut),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => ProductPage(
                      product: index,
                      id: widget.state.filteredData!.isNotEmpty ? widget.state.filteredData![index].id : widget.state.dataApi![index].id),
                ),
              );
            },
            child: Material(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(color: data[index].images.dominanColor.first, borderRadius: BorderRadius.circular(12), boxShadow: [
                  BoxShadow(
                    color: data[index].images.paletteColors.first.color,
                    blurRadius: 6,
                    offset: const Offset(2, 2),
                  )
                ]),
                child: Column(
                  children: [
                    Hero(
                      tag: data[index].id.toString(),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(7),
                        child: CachedNetworkImage(
                          progressIndicatorBuilder: (context, url, progress) => Center(
                            child: CircularProgressIndicator(
                              value: progress.downloaded.toDouble(),
                            ),
                          ),
                          imageUrl: data[index].images.url.first,
                          fit: BoxFit.cover,
                          errorWidget: (context, url, error) => const Icon(Icons.error),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: 50,
                      child: Text(
                        data[index].title,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.redHatText(
                          textStyle:  TextStyle(
                            fontSize: 14,
                            color: data[index].images.paletteColors.first.titleTextColor,
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
      },
    );
  }
}
