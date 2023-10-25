class Users {
  String userName;
  String fullName;
  String email;
  String phoneNumber;
  String? password;
  String userDateOfBirth;
  String userImage;
  Users({
    this.password,
    required this.userDateOfBirth,
    required this.phoneNumber,
    required this.email,
    required this.fullName,
    required this.userName,
    required this.userImage,
  });
}
