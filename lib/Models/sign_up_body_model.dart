class SignUpBodyModel {
  String name;
  String phone;
  String email;
  String password;

  SignUpBodyModel({
    required this.name,
    required this.phone,
    required this.email,
    required this.password,
  });

  factory SignUpBodyModel.fromJson(Map<String, dynamic> json) =>
      SignUpBodyModel(
        name: json['f_name'] as String,
        phone: json['phone'] as String,
        email: json['email'] as String,
        password: json['password'] as String,
      );

  Map<String, dynamic> toJson() => {
        'f_name': name,
        'phone': phone,
        'email': email,
        'password': password,
      };
}
