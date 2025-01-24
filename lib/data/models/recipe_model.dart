class RecipeModel {
  final int id;
  final String title;
  final String image;
  final int readyInMinutes;

  RecipeModel({
    required this.id,
    required this.title,
    required this.image,
    required this.readyInMinutes,
  });

  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    return RecipeModel(
      id: json['id'],
      title: json['title'],
      image: json['image'],
      readyInMinutes: json['readyInMinutes'] ?? 0,
    );
  }
}
