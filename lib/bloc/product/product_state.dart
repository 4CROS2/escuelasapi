part of 'product_cubit.dart';

class ProductState extends Equatable {
  final double pageValue;
  final List<Color> predominantColor;
  const ProductState({required this.pageValue,required this.predominantColor});

  @override
  List<Object> get props => [pageValue,predominantColor];

  ProductState copyWith({
    double? pageValue,
    List<Color>? predominantColor,
  }) {
    return ProductState(pageValue: pageValue ?? this.pageValue,predominantColor: predominantColor ?? this.predominantColor);
  }
}

final class ProductInitial extends ProductState {
  ProductInitial() : super(pageValue: .0, predominantColor: [Colors.white,Colors.white,Colors.white]);
}
