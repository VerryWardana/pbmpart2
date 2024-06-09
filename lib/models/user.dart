// models/user.dart

class User {
  String id;
  String nama;
  String username;
  String imageUrl;
  String email;
  String umur;
  String jenisKelamin;

  User(
      {required this.id,
      required this.nama,
      required this.username,
      required this.imageUrl,
      required this.email,
      required this.umur,
      required this.jenisKelamin});

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      nama: map['name'],
      username: map['username'],
      imageUrl: map['imageUrl'],
      email: map['email'],
      umur: map['umur'],
      jenisKelamin: map['jeniskelamin'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': nama,
      'username': username,
      'imageUrl': imageUrl,
      'email': email,
      'umur': umur,
      'jeniskelamin': jenisKelamin,
    };
  }
}
