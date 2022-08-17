class ResponseModel {
  bool _isScuccess;
  String _message;

  ResponseModel(this._isScuccess, this._message);

  bool get isSuccess => _isScuccess;
  String get message => _message;

  factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
        json['isScuccess'] as bool,
        json['message'] as String,
      );

  Map<String, dynamic> toJson() => {
        'isScuccess': _isScuccess,
        'message': _message,
      };
}
