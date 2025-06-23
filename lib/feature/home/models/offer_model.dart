class OfferModel {
  final String title;
  final String description;
  final String imageUrl;
  final DateTime startDate;
  final DateTime endDate;
  final bool isActive;

  OfferModel({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.startDate,
    required this.endDate,
    required this.isActive,
  });

  factory OfferModel.fromJson(Map<String, dynamic> json) {
    return OfferModel(
      title: json['title'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      isActive: json['isActive'] as bool,
    );
  }

 

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'isActive': isActive,
    };
  }
}