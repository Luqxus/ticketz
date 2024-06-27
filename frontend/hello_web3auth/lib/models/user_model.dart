class UserModel {
  final String email;
  final String username;
  final DateTime createdAt;

  UserModel(
      {required this.email, required this.username, required this.createdAt});

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
        email: map['email'],
        username: map['username'],
        createdAt: map['createdAt']);
  }

  String get name => username;
  DateTime get createdDate => createdAt;
}
