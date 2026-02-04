class UserModel {
  String email;
  String name;
  String gender;
  String phoneNumber;
  String password;
  String passwordConfirmation;

  UserModel({
    required this.email,
    required this.name,
    required this.gender,
    required this.phoneNumber,
    required this.password,
    required this.passwordConfirmation,
  });

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "name": name,
      "gender": gender,
      "phone": phoneNumber,
      "password": password,
      "password_confirmation": passwordConfirmation,
    };
  }
}
