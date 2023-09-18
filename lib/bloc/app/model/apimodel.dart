class Api {
  final List<Product> products;

  Api.fromJson(Map<String, dynamic> json) : products = (json['products'] as List).map((productJson) => Product.fromJson(productJson)).toList();
}

class Product {
  final int id;
  final String title;
  final String images;
  final String description;
  final String price;

  Product.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        description = json['description'],
        price = json['price'],
        images = json['images'];
}
