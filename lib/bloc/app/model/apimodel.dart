import 'package:equatable/equatable.dart';

class Api extends Equatable {
  final int id;
  final String title;
  final int price;
  final List<Category> categories;

  const Api(
    this.id,
    this.title,
    this.price,
    this.categories,
  );

  factory Api.fromJson(Map<String, dynamic> json) {
    return Api(
      json['id'] as int,
      json['title'] as String,
      json['price'] as int,
      json['categories'].map((categoryJson) => Category.fromJson(categoryJson)).toList(),
    );
  }

  @override
  List<Object> get props => [id, title, price, categories];
}

class Category {
  final int id;
  final String name;
  final String url;
  const Category(this.id, this.name, this.url);

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      json['id'] as int,
      json['name'] as String,
      json['url'] as String,
    );
  }
}
