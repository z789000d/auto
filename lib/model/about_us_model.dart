class AboutUsModel {
  String introduce;
  List<AboutUsImageModel> aboutUsImageModel;

  AboutUsModel({
    required this.introduce,
    required this.aboutUsImageModel,
  });

  AboutUsModel copyWith(
      {String? introduce, List<AboutUsImageModel>? aboutUsImageModel}) {
    return AboutUsModel(
        introduce: introduce ?? this.introduce,
        aboutUsImageModel: aboutUsImageModel ?? this.aboutUsImageModel);
  }
}

class AboutUsImageModel {
  final String id;
  final String images;

  AboutUsImageModel({
    required this.id,
    required this.images,
  });
}
