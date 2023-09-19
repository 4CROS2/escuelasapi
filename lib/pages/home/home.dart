import 'package:escuelasapi/bloc/app/app_cubit.dart';
import 'package:escuelasapi/pages/home/parts/header.dart';
import 'package:escuelasapi/pages/home/parts/products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

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
          child: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            delegate: Header(),
            pinned: true,
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
            sliver: const SliverToBoxAdapter(child: Products()),
          )
        ],
      )),
    );
  }
}

class CategoriesHeader extends SliverPersistentHeaderDelegate {
  double extentCategoriesHeader = 90.0;
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return BlocBuilder<AppCubit, AppState>(builder: (context, state) {
      if (state is InitializedApi) {
        List<String> categories = state.dataApi.map((product) => product.category.name).toSet().toList();
        categories.insert(0, 'All');
        return CustomScrollView(
          scrollDirection: Axis.horizontal,
          slivers: [
            SliverList.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 18).add(
                    EdgeInsets.only(
                      right: index == categories.length - 1 ? 20 : 10,
                      left: index == 0 ? 20 : 0,
                    ),
                  ),
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        state.dataApi[index].category.image,
                      ),
                      fit: BoxFit.cover,
                    ),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(9),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withOpacity(.25), blurRadius: 12, offset: const Offset(5, 3)),
                      BoxShadow(
                        color: Colors.white.withOpacity((1 - (shrinkOffset / 90) * 2).clamp(0.0, 1.0)),
                        blurRadius: 12,
                        offset: const Offset(-3, -5),
                      ),
                    ],
                  ),
                  child: Text(
                    categories[index],
                    style: GoogleFonts.poppins(textStyle: const TextStyle(fontWeight: FontWeight.w700)),
                  ),
                );
              },
            ),
          ],
        );
      } else {
        return SizedBox(
          width: extentCategoriesHeader,
          height: extentCategoriesHeader,
        );
      }
    });
  }

  @override
  double get maxExtent => extentCategoriesHeader;

  @override
  double get minExtent => extentCategoriesHeader;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => false;
}
