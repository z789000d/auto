class CatalogueModel {
  final String id;
  final String name;
  final List<String> images;

  CatalogueModel({
    required this.id,
    required this.name,
    required this.images,
  });

  CatalogueModel copyWith({String? id, String? name, List<String>? images}) {
    return CatalogueModel(
        id: id ?? this.id,
        name: name ?? this.name,
        images: images ?? this.images);
  }
}
