class ModelClass {
  final String Uid;
  final String name;
  final String email;
  final String image;
  final String lastActive;
  final bool IsOnline;

  ModelClass({
    required this.Uid,
    required this.name,
    required this.email,
    required this.image,
    required this.lastActive,
    required this.IsOnline,
  });
  factory ModelClass.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      // Handle the case where the data is null or missing
      return ModelClass(
        Uid: '',
        name: '',
        email: '',
        image: '',
        lastActive: '',
        IsOnline: false,
      );
    }

    return ModelClass(
      Uid: json['uid'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      image: json['image'] ?? '',
      lastActive: json['lastActive'] ?? '',
      IsOnline: json['isOnline'] ?? true,
    );
  }
}
