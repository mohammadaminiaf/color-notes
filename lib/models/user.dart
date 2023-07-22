class User {
  final String email;
  final String? displayName;
  final String? profilePicUrl;

  User({
    required this.email,
    required this.displayName,
    required this.profilePicUrl,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'displayName': displayName,
      'profilePicUrl': profilePicUrl,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      email: map['email'] as String,
      displayName: map['displayName'] ?? '',
      profilePicUrl: map['profilePicUrl'] ?? '',
    );
  }
}
