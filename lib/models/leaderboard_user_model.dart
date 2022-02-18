class LeaderboardUserModel {
  LeaderboardUserModel({required this.username, required this.time});

  LeaderboardUserModel.fromJson(Map<String, Object?> json)
      : this(
          username: json['username']! as String,
          time: json['time']! as String,
        );

  final String username;
  final String time;

  Map<String, Object?> toJson() {
    return {
      'username': username,
      'time': time,
    };
  }
}
