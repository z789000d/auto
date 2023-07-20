class ProductModel {
  final String id;
  final String category;
  final String name;
  final List<String> images;
  final String description;
  final String videoLink;

  ProductModel({
    required this.id,
    required this.category,
    required this.name,
    required this.images,
    required this.description,
    required this.videoLink,
  });

  ProductModel copyWith(
      {String? id,
      String? category,
      String? name,
      List<String>? images,
      String? description,
      String? videoLink}) {
    return ProductModel(
        id: id ?? this.id,
        category: category ?? this.category,
        name: name ?? this.name,
        images: images ?? this.images,
        description: description ?? this.description,
        videoLink: videoLink ?? this.videoLink);
  }
}
