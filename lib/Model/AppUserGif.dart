class AppUserGif {
  String? userName;
  String? avatarUrl;
  AppUserGif({required this.userName, required this.avatarUrl});
  AppUserGif.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      userName = 'NoUserName';
      avatarUrl = 'https://cdn-icons-png.flaticon.com/512/456/456212.png';
    } else {
      userName = json['username'];
      avatarUrl = json['avatar_url'];
    }
  }
}
