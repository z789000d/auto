class NewsModel {
  List<NewsItemModel> newsItemModel;

  NewsModel({
    required this.newsItemModel,
  });

  NewsModel copyWith({List<NewsItemModel>? newsItemModel}) {
    return NewsModel(newsItemModel: newsItemModel ?? this.newsItemModel);
  }
}

class NewsItemModel {
  final String id;
  final String newsText;

  NewsItemModel({
    required this.id,
    required this.newsText,
  });
}
