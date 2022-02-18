class UserModel {
  UserModel({required this.username});

  UserModel.fromJson(Map<String, Object?> json)
      : this(
          username: json['username']! as String,
        );

  final String username;

  Map<String, Object?> toJson() {
    return {
      'username': username,
    };
  }
}
