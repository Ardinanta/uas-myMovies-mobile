class MovieVideo {
  const MovieVideo({
    required this.id,
    required this.name,
    required this.key,
    required this.site,
    required this.type,
  });

  final String id;
  final String name;
  final String key;
  final String site;
  final String type;

  bool get isYoutubeTrailer {
    return site.toLowerCase() == 'youtube' && type.toLowerCase() == 'trailer';
  }

  Uri? get youtubeUri {
    if (site.toLowerCase() != 'youtube' || key.isEmpty) {
      return null;
    }

    return Uri.https('www.youtube.com', '/watch', {'v': key});
  }
}
