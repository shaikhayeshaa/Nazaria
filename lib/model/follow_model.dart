class FollowInfo {
  final String uid;
  final String name;
  final String image;
  final String followedAt;

  FollowInfo({
    required this.uid,
    required this.name,
    required this.image,
    required this.followedAt,
  });

  factory FollowInfo.fromJson(Map<String, dynamic> json) {
    return FollowInfo(
      uid: json['uid'],
      name: json['name'],
      image: json['image'],
      followedAt: json['followedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'image': image,
      'followedAt': followedAt,
    };
  }
}
