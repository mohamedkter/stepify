class SignupUserModel{
   final String name;
   final String email;
   final String password;

  SignupUserModel({
    required this.name,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
    };
  }

  factory SignupUserModel.fromJson(Map<String, dynamic> json) {
    return SignupUserModel(
      name: json['name'],
      email: json['email'],
      password: json['password'],
    );
  }
}