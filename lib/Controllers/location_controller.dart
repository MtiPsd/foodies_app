import 'package:foodies/Data/Repository/location_repo.dart';
import 'package:foodies/Models/response_model.dart';
import 'package:foodies/Models/address_model.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart';
import 'package:get/get.dart';
import 'dart:convert';

class LocationController extends GetxController implements GetxService {
  final LocationRepo locationRepo;
  LocationController({
    required this.locationRepo,
  });

  bool _loading = false;
  bool get loading => _loading;

  // For service zone
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // Whether the user is in service zone or not
  bool _inZone = false;
  bool get inZone => _inZone;

  // Showing and hiding button as map loads
  bool _buttonDisabled = true;
  bool get buttonDisabled => _buttonDisabled;

  late Position _position;
  Position get position => _position;

  late Position _pickPosition;
  Position get pickPosition => _pickPosition;

  Placemark _placemark = Placemark();
  Placemark get placemark => _placemark;

  Placemark _pickPlacemark = Placemark();
  Placemark get pickPlacemark => _pickPlacemark;

  // All addresses from server save into this list
  List<AddressModel> _addressList = <AddressModel>[];
  List<AddressModel> get addressList => _addressList;

  // All addresses from server save into this list
  late List<AddressModel> _allAddressList;
  List<AddressModel> get allAddressList => _allAddressList;

  final List<String> _addressTypeList = ["home", "office", "others"];
  List<String> get addressTypeList => _addressTypeList;

  int _addressTypeIndex = 0;
  int get addressTypeIndex => _addressTypeIndex;

  late Map<String, dynamic> _getAddress;
  Map<String, dynamic> get getAddress => _getAddress;

  late MapController _mapController;
  MapController get mapController => _mapController;

  bool _updateAddress = true;
  bool _changeAddress = true;

  void setMapController(MapController mapController) {
    _mapController = mapController;
  }

  void updatePosition(
    MapPosition mapPosition,
    bool fromAddLocationScreen,
  ) async {
    _loading = true;

    if (_updateAddress) {
      try {
        if (fromAddLocationScreen) {
          _position = Position(
            longitude: mapPosition.center!.longitude,
            latitude: mapPosition.center!.latitude,
            timestamp: DateTime.now(),
            accuracy: 1.0,
            altitude: 1.0,
            heading: 1.0,
            speed: 1.0,
            speedAccuracy: 1.0,
          );
        } else {
          _pickPosition = Position(
            longitude: mapPosition.center!.longitude,
            latitude: mapPosition.center!.latitude,
            timestamp: DateTime.now(),
            accuracy: 1.0,
            altitude: 1.0,
            heading: 1.0,
            speed: 1.0,
            speedAccuracy: 1.0,
          );
        }

        ResponseModel responseModel = await getZone(
          mapPosition.center!.latitude.toString(),
          mapPosition.center!.longitude.toString(),
          false,
        );

        // If button value is false , we are in service area
        _buttonDisabled = !responseModel.isSuccess;

        if (_changeAddress) {
          String address = await getAddressFromGeocode(
            LatLng(
              mapPosition.center!.latitude,
              mapPosition.center!.longitude,
            ),
          );

          fromAddLocationScreen
              ? _placemark = Placemark(name: address)
              : _pickPlacemark = Placemark(name: address);
        } else {
          _changeAddress = true;
        }
      } catch (e) {
        print(e);
      }
    } else {
      _updateAddress = true;
    }

    _loading = false;
    update();
  }

  Future<String> getAddressFromGeocode(LatLng latLng) async {
    String _address = "Unknown Location Found";

    Response response = await locationRepo.getAddressFromGeocode(latLng);

    /* 

    */

    bool hasLocation = response.body["features"].isNotEmpty;

    if (response.statusCode == 200) {
      if (hasLocation) {
        _address = response.body["features"][0]["place_name"].toString();
      }
    } else {
      print("error getting the Mapbox api");
    }

    return _address;
  }

  AddressModel getUserAddress() {
    late AddressModel addressModel;
    /* 
       Converting to map using jsonDecode
    */
    _getAddress = jsonDecode(locationRepo.getUserAddress());

    try {
      addressModel = AddressModel.fromJson(_getAddress);
    } catch (e) {
      print(e);
    }

    // print("Address Type is : ${addressModel.addressType}");

    return addressModel;
  }

  void setAddressTypeIndex(int index) {
    _addressTypeIndex = index;
    update();
  }

  Future<ResponseModel> saveAddress(AddressModel addressModel) async {
    _loading = true;
    update();

    Response response = await locationRepo.saveAddress(addressModel);
    ResponseModel responseModel;

    // print(response.body.toString());

    if (response.statusCode == 200) {
      /* 
         With the method below you get address from server and 
         also save the user address for future usage
      */
      await getAddressListFromServer();

      String message = response.body["message"];
      responseModel = ResponseModel(true, message);

      /* save user address in local storage */
      await saveUserAddress(addressModel);

      //
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }

    _loading = false;
    update();

    return responseModel;
  }

  Future<void> getAddressListFromServer() async {
    Response response = await locationRepo.getAllAddress();

    // print(response.body[0]);

    if (response.statusCode == 200) {
      /* 
         If user changes his address we 
         need to clear the list first
      */
      _addressList = <AddressModel>[];
      _allAddressList = <AddressModel>[];

      response.body.forEach((address) {
        _addressList.add(AddressModel.fromJson(address));
        _allAddressList.add(AddressModel.fromJson(address));
      });
    } else {
      _addressList = <AddressModel>[];
      _allAddressList = <AddressModel>[];
    }

    update();
  }

  Future<bool> saveUserAddress(AddressModel addressModel) async {
    /* 
       Actually you could do it without
       .toJson() but for a better result
       we convert our object to json first
    */
    String userAddress = jsonEncode(addressModel.toJson());

    return await locationRepo.saveUserAddress(userAddress);
  }

  void clearAddressData() {
    _addressList = [];
    _allAddressList = [];
    locationRepo.clearUserAddress();
    update();
  }

  String getUserAddressFromLocalStorage() {
    return locationRepo.getUserAddress();
  }

  void setUpdatedAddressFromPickLocationScreen() {
    _position = _pickPosition;
    _placemark = _pickPlacemark;
    _updateAddress = false;
    update();
  }

  Future<ResponseModel> getZone(String lat, String lng, bool markerLoad) async {
    late ResponseModel responseModel;
    if (markerLoad) {
      _loading = true;
    } else {
      _isLoading = true;
    }
    update();

    Response response = await locationRepo.getZone(lat, lng);

    if (response.statusCode == 200) {
      _inZone = true;
      responseModel = ResponseModel(true, response.body["zone_id"].toString());
    } else {
      _inZone = false;
      responseModel = ResponseModel(false, response.statusText!);
    }

    if (markerLoad) {
      _loading = false;
    } else {
      _isLoading = false;
    }

    update();
    return responseModel;
  }

  // searchLocation(BuildContext context, String text) async {
  //   if (text.isNotEmpty) {
  //     Response response = await locationRepo.searchLocation(text);

  //     if (response.statusCode == 200) {
  //     } else {}
  //   }
  // }

  void setLatLngForSearch({required LatLng latLng, required String address}) {
    _loading = true;
    _pickPosition = Position(
      longitude: latLng.longitude,
      latitude: latLng.latitude,
      timestamp: DateTime.now(),
      accuracy: 1.0,
      altitude: 1.0,
      heading: 1.0,
      speed: 1.0,
      speedAccuracy: 1.0,
    );

    _pickPlacemark = Placemark(name: address);
    _changeAddress = false;

    _loading = false;
    update();
  }
}
