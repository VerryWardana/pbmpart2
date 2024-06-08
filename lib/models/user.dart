class User {
  final String id;
  final String nama;
  final String username;

  User({required this.id, required this.nama, required this.username});

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      nama: map['name'],
      username: map['username'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': nama,
      'username': username,
    };
  }
}
