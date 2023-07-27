class CatalogueModel {
  final String id;
  final String name;
  final List<CatalogueItemModel> images;

  CatalogueModel({
    required this.id,
    required this.name,
    required this.images,
  });

  CatalogueModel copyWith(
      {String? id, String? name, List<CatalogueItemModel>? images}) {
    return CatalogueModel(
        id: id ?? this.id,
        name: name ?? this.name,
        images: images ?? this.images);
  }
}

class CatalogueItemModel {
  final String id;
  final String name;
  final String images;

  CatalogueItemModel({
    required this.id,
    required this.name,
    required this.images,
  });

  CatalogueItemModel copyWith({String? id, String? name, String? images}) {
    return CatalogueItemModel(
        id: id ?? this.id,
        name: name ?? this.name,
        images: images ?? this.images);
  }
}
