class AddressModel {
  late int? _id;
  late String? _addressType;
  late String? _contactPersonName;
  late String? _contactPersonNumber;
  late String _address;
  late String _latitude;
  late String _longitude;

  AddressModel({
    id,
    required addressType,
    contactPersonName,
    contactPersonNumber,
    required address,
    required latitude,
    required longitude,
  }) {
    _id = id;
    _addressType = addressType;
    _contactPersonName = contactPersonName;
    _contactPersonNumber = contactPersonNumber;
    _address = address;
    _latitude = latitude;
    _longitude = longitude;
  }

  String get address => _address;
  String? get addressType => _addressType;
  String? get contactPersonName => _contactPersonName;
  String? get contactPersonNumber => _contactPersonNumber;
  String? get latitude => _latitude;
  String? get longitude => _longitude;

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
        id: json['id'] as int?,
        addressType: json['address_type'] as String?,
        contactPersonName: json['contact_person_name'] as String?,
        contactPersonNumber: json['contact_person_number'] as String?,
        address: json['address'] as String,
        latitude: json['latitude'] as String,
        longitude: json['longitude'] as String,
      );

  Map<String, dynamic> toJson() => {
        'id': _id,
        'address_type': _addressType,
        'contact_person_name': _contactPersonName,
        'contact_person_number': _contactPersonNumber,
        'address': _address,
        'latitude': _latitude,
        'longitude': _longitude,
      };
}
