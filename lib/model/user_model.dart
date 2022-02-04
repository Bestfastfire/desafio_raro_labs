class UserModel{
  final Map user;

  int get parkingSize => user['parking_size'];
  String get name => user['name'];
  int get id => user['id'];

  UserModel(this.user);
}