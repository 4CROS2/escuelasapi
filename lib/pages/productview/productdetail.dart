import 'package:escuelasapi/bloc/app/app_cubit.dart';
import 'package:escuelasapi/bloc/product/product_cubit.dart';
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
  final PageController _pageController = PageController(
    viewportFraction: .72,
  );
  final double pageValue = 0.0;

  void _fractionView() {
    ProductCubit page = BlocProvider.of<ProductCubit>(context);
    page.changeViewportFraction(viewportFraction: _pageController.page!);
  }

  @override
  void initState() {
    _pageController.addListener(_fractionView);
    ProductCubit images = BlocProvider.of<ProductCubit>(context);
    images.dominantColor(context: context, imageIndex: widget.product);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.removeListener(_fractionView);
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        List<Color> colors = state.predominantColor;
        double value = (double.parse(state.pageValue.toStringAsFixed(2)));
        return Scaffold(
          backgroundColor:
              Color.lerp(colors[value >= 0 && value <= .98 ? 0 : 1], colors[value >= 0 && value <= .98 ? 1 : 2], value < .99 ? value : value-1),
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
      },
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
      builder: (context, apiState) {
        var data = apiState.filteredData!.isEmpty ? apiState.dataApi![product].images : apiState.filteredData![product].images;
        return Container(
          decoration: BoxDecoration(
            color: Color.lerp(
              Colors.transparent,
              Colors.black,
              (shrinkOffset / height).clamp(0.0, 10.0),
            ),
          ),
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top - 10),
          height: MediaQuery.sizeOf(context).height * .55,
          child: BlocBuilder<ProductCubit, ProductState>(
            builder: (context, productState) {
              return PageView.builder(
                itemCount: data.length,
                controller: pageController,
                physics: const BouncingScrollPhysics(),
                /*  onPageChanged: (value) {
                  BlocProvider.of<ProductCubit>(context).dominantColor(imageProvider: data[value]);
                }, */
                itemBuilder: (context, index) {
                  final images = data[index];
                  final tag = index == 0 ? id.toString() : images;
                  final double pageValue = (productState.pageValue - index) / 10;
                  final double percent = (productState.pageValue > index ? 1 - pageValue : 1 + pageValue).clamp(.80, 1);

                  return Material(
                    color: Colors.transparent,
                    child: TweenAnimationBuilder(
                      tween: Tween(begin: percent, end: percent),
                      duration: const Duration(milliseconds: 70),
                      builder: (context, value, child) {
                        return Transform.scale(
                          scale: value,
                          child: child,
                        );
                      },
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
                    ),
                  );
                },
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
