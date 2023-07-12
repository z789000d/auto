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
}
