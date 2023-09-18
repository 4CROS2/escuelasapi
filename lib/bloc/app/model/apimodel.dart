class Api {
  final int id;
  final String title;
  final int price;
  final String description;
  final List<String> images;
  final DateTime creationAt;
  final DateTime updatedAt;
  final Categoria categoria;

  Api({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.images,
    required this.creationAt,
    required this.updatedAt,
    required this.categoria,
  });

  factory Api.fromJson(Map<String, dynamic> json) {
    return Api(
      id: json['id'],
      title: json['title'],
      price: json['price'],
      description: json['description'],
      images: List<String>.from(json['images']),
      creationAt: DateTime.parse(json['creationAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      categoria: Categoria.fromJson(json['category']),
    );
  }
}

class Categoria {
  final int id;
  final String name;
  final String image;
  final DateTime creationAt;
  final DateTime updatedAt;

  Categoria({
    required this.id,
    required this.name,
    required this.image,
    required this.creationAt,
    required this.updatedAt,
  });

  factory Categoria.fromJson(Map<String, dynamic> json) {
    return Categoria(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      creationAt: DateTime.parse(json['creationAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}

// Ejemplo de uso


