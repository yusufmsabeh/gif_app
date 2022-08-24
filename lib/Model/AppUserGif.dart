class AppUserGif {
  String? userName;
  String? avatarUrl;
  AppUserGif({required this.userName, required this.avatarUrl});
  AppUserGif.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      userName = 'NoUserName';
      avatarUrl = 'https://cdn-icons-png.flaticon.com/512/456/456212.png';
    } else {
      userName = json['username'] ?? 'no username';
      avatarUrl = json['avatar_url'] ??
          'https://cdn-icons-png.flaticon.com/512/456/456212.png';
    }
  }
  AppUserGif.fromFirebaseJson(Map<String, dynamic>? json) {
    if (json == null) {
      userName = 'NoUserName';
      avatarUrl = 'https://cdn-icons-png.flaticon.com/512/456/456212.png';
    } else {
      userName = json['userName'] ?? 'no username';
      avatarUrl = json['avatarUrl'] ??
          'https://cdn-icons-png.flaticon.com/512/456/456212.png';
    }
  }

  toJson() => {'userName': userName, 'avatarUrl': avatarUrl};
}
