class UserModel {
  int id;
  String name;
  String email;
  String phone;
  int orderCount;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.orderCount,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'] as int,
        name: json['f_name'] as String,
        email: json['email'] as String,
        phone: json['phone'] as String,
        orderCount: json['order_count'] as int,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'f_name': name,
        'email': email,
        'phone': phone,
        'order_count': orderCount,
      };
}
