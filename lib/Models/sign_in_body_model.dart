class SignInBodyModel {
  String phone;
  String password;

  SignInBodyModel({required this.phone, required this.password});

  factory SignInBodyModel.fromJson(Map<String, dynamic> json) {
    return SignInBodyModel(
      phone: json['phone'] as String,
      password: json['password'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'phone': phone,
        'password': password,
      };
}
