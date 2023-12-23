import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
class Api {
  final int id;
  final String title;
  final int price;
  final String description;
  final Images images;
  final DateTime creationAt;
  final DateTime updatedAt;
  final Category category;

  Api({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.images,
    required this.creationAt,
    required this.updatedAt,
    required this.category,
  });

  static Future<Api> fromJson(Map<String, dynamic> json) async {
    return Api(
      id: json['id'],
      title: json['title'],
      price: json['price'],
      description: json['description'],
      images: await Images.fromJson(json),
      creationAt: DateTime.parse(json['creationAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      category: Category.fromJson(json['category']),
    );
  }
}

class Category {
  final int id;
  final String name;
  final String image;
  final DateTime creationAt;
  final DateTime updatedAt;

  Category({
    required this.id,
    required this.name,
    required this.image,
    required this.creationAt,
    required this.updatedAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      creationAt: DateTime.parse(json['creationAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}

class Images {
  final List<String> url;
  final List<Color> dominanColor;
  final List<PaletteColor> paletteColors;

  Images({
    required this.url,
    required this.dominanColor,
    required this.paletteColors,
  });

  static _dominanColor(List json) async {
    List<Color> colors = [];
    List<PaletteColor> paletteColors = [];
    for (var value in json) {
      var paletteGenerator = await PaletteGenerator.fromImageProvider(NetworkImage(value));
      colors.add(paletteGenerator.dominantColor!.color);
      paletteColors.addAll(paletteGenerator.paletteColors);
    }
    return [colors, paletteColors];
  }

  static Future<Images> fromJson(Map<String, dynamic> json) async {
    var colorsAndPalette = await _dominanColor(json['images']);
    return Images(
      url: List<String>.from(json['images']),
      dominanColor: colorsAndPalette[0],
      paletteColors: colorsAndPalette[1],
    );
  }
}
