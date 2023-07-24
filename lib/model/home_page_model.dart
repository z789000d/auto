import 'package:web_auto/model/product_model.dart';

class HomePageModel {
  final List<ProductModel> pageViewImages;
  final List<ProductModel> productImages;

  HomePageModel({
    required this.pageViewImages,
    required this.productImages,
  });

  HomePageModel copyWith(
      {List<ProductModel>? pageViewImages, List<ProductModel>? productImages}) {
    return HomePageModel(
        pageViewImages: pageViewImages ?? this.pageViewImages,
        productImages: productImages ?? this.productImages);
  }
}
