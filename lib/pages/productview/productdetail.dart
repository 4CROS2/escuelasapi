import 'package:escuelasapi/bloc/app/app_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductPage extends StatefulWidget {
  final int product;
  final int id;
  const ProductPage({super.key, required this.product, required this.id});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(
      viewportFraction: .70,
    );
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            delegate: ProductHeader(
              height: MediaQuery.sizeOf(context).height,
              product: widget.product,
              pageController: _pageController,
              id: widget.id,
            ),
          ),
          SliverList.builder(
            itemBuilder: (context, index) => Text(
              index.toString(),
            ),
          )
        ],
      ),
    );
  }
}

class ProductHeader extends SliverPersistentHeaderDelegate {
  final double height;
  final int product;
  final int id;
  final PageController pageController;
  ProductHeader({
    required this.height,
    required this.pageController,
    required this.product,
    required this.id,
  });
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        var data = state.filteredData!.isEmpty ? state.dataApi![product].images : state.filteredData![product].images;
        return Container(
          decoration: BoxDecoration(
            color: Color.lerp(
              Colors.white,
              Colors.black,
              (shrinkOffset / height).clamp(0.0, 10.0),
            ),
          ),
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top - 10),
          height: MediaQuery.sizeOf(context).height * .55,
          child: PageView.builder(
            itemCount: data.length,
            controller: pageController,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              var images = data[index];
              var tag = index == 0 ? id.toString() : images;
              return Material(
                color: Colors.transparent,
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(27),
                    child: Hero(
                      tag: tag,
                      child: Image.network(
                        images,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  @override
  double get maxExtent => height * .60;

  @override
  double get minExtent => height * .50;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => false;
}
