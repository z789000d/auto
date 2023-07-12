class Utils {
  static String? getYouTubeVideoId(String videoUrl) {
    // YouTube 影片連結的正則表達式模式
    RegExp regExp = RegExp(
      r'^(?:https?:\/\/)?(?:www\.)?'
      r'(?:youtu\.be\/|youtube\.com\/(?:embed\/|v\/|watch\?v=|watch\?.+&v=))'
      r'([^?&]+)(?:\?t=.+)?(?:\?.+)?$',
    );

    // 檢查連結是否符合 YouTube 影片的格式
    if (regExp.hasMatch(videoUrl)) {
      // 提取影片 ID
      String videoId = regExp.firstMatch(videoUrl)?.group(1) ?? '';
      return videoId;
    } else {
      // 非有效的 YouTube 影片連結
      return null;
    }
  }
}
