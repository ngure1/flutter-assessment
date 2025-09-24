class DashboardApiResponseModel {
  final int total;
  final int totalHits;
  final List<DashboardImagesModel> hits;

  DashboardApiResponseModel({
    required this.total,
    required this.totalHits,
    required this.hits,
  });

  factory DashboardApiResponseModel.fromJson(Map<String, dynamic> json) {
    return DashboardApiResponseModel(
      total: json['total'] ?? 0,
      totalHits: json['totalHits'] ?? 0,
      hits:
          (json['hits'] as List<dynamic>?)
              ?.map((hit) => DashboardImagesModel.fromJson(hit))
              .toList() ??
          [],
    );
  }
}

class DashboardImagesModel {
  final String photographerName;
  final String imageUrl;
  final List<String> tags;
  final int id;

  DashboardImagesModel({
    required this.photographerName,
    required this.tags,
    required this.imageUrl,
    required this.id,
  });

  factory DashboardImagesModel.fromJson(Map<String, dynamic> json) {
    return DashboardImagesModel(
      id: json['id'] ?? 0,
      photographerName: json['user'] ?? 'Unknown',
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
