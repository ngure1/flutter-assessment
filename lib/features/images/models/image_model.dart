class ImagesApiResponseModel {
  final int total;
  final int totalHits;
  final List<ImagesModel> hits;

  ImagesApiResponseModel({
    required this.total,
    required this.totalHits,
    required this.hits,
  });

  factory ImagesApiResponseModel.fromJson(Map<String, dynamic> json) {
    return ImagesApiResponseModel(
      total: json['total'] ?? 0,
      totalHits: json['totalHits'] ?? 0,
      hits:
          (json['hits'] as List<dynamic>?)
              ?.map((hit) => ImagesModel.fromJson(hit))
              .toList() ??
          [],
    );
  }
}

class ImagesModel {
  final String photographerName;
  final String imageUrl;
  final List<String> tags;
  final int id;

  ImagesModel({
    required this.photographerName,
    required this.tags,
    required this.imageUrl,
    required this.id,
  });

  factory ImagesModel.fromJson(Map<String, dynamic> json) {
    return ImagesModel(
      id: json['id'] ?? 0,
      photographerName: json['user'] ?? 'Unknown',
      // todo : add placeholder image url
      imageUrl: json['webformatURL'] ?? '',
      tags:
          (json['tags'] as String?)
              ?.split(',')
              .map((tag) => tag.trim())
              .where((tag) => tag.isNotEmpty)
              .toList() ??
          [],
    );
  }
}
