import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:foodies/Constants/app_constants.dart';
import 'package:foodies/Features/Location/Screens/pick_location_screen.dart';
import 'package:foodies/Features/Location/Widgets/save_address_button.dart';
import 'package:foodies/Features/Auth/Widgets/custom_text_field.dart';
import 'package:foodies/Features/Auth/Widgets/form_button.dart';
import 'package:foodies/Controllers/location_controller.dart';
import 'package:foodies/Controllers/auth_controller.dart';
import 'package:foodies/Controllers/user_controller.dart';
import 'package:foodies/Models/response_model.dart';
import 'package:foodies/Models/address_model.dart';
import 'package:foodies/Routes/route_helper.dart';
import 'package:foodies/Constants/snack_bar.dart';
import 'package:foodies/Commons/big_text.dart';
import 'package:foodies/Constants/colors.dart';
import 'package:foodies/Constants/utils.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:location/location.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart' show Lottie;

class AddLocationScreen extends StatefulWidget {
  const AddLocationScreen({Key? key}) : super(key: key);

  @override
  State<AddLocationScreen> createState() => _AddLocationScreenState();
}

class _AddLocationScreenState extends State<AddLocationScreen> {
  //

  final Location _location = Location();
  late MapController _mapController;
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _contactPersonName = TextEditingController();
  final TextEditingController _contactPersonNumber = TextEditingController();
  late bool _isLogged;
  MapPosition _mapPosition = MapPosition(
    center: LatLng(45.51563, -122.677433),
    zoom: 17.0,
  );

  LatLng _initialPosition = LatLng(45.51563, -122.677433);

  @override
  void initState() {
    super.initState();

    _isLogged = Get.find<AuthController>().userLoggedIn();

    if (_isLogged) {
      // S^
      Get.find<UserController>().getUserInfo();
    }

    /*

      The user picked a location, So after coming to this
      page he wants to see his location on the map , That's why
      we are using the code below ..

    */

    if (Get.find<LocationController>().addressList.isNotEmpty) {
      /*

        The user might log in from another device !
        so we get the newest address from server and 
        save it in local storage

      */
      if (Get.find<LocationController>().getUserAddressFromLocalStorage() ==
          "") {
        AddressModel newestAddress = Get.find<LocationController>()
            .addressList
            .first; // addressList.fisrt is newset address NOT addressList.last

        Get.find<LocationController>().saveUserAddress(newestAddress);
      }

      AddressModel address = Get.find<LocationController>().getUserAddress();

      _initialPosition = LatLng(
        double.parse(address.latitude!),
        double.parse(address.longitude!),
      );
      _mapPosition = MapPosition(
        center: _initialPosition,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainBackground,

      // ****************************************** Appbar ******************************************

      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120.0),
        child: AppBar(
          toolbarHeight: 120.0,
          elevation: 0.0,
          title: BigText(
            text: "Add Location",
            size: rValue(
              context: context,
              defaultValue: 20.0,
              whenSmaller: 17.0,
            ),
          ),
          leading: Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: CircleAvatar(
              backgroundColor: AppColors.secondaryBackground,
              child: IconButton(
                onPressed: _goToPrevPage,
                padding: const EdgeInsets.only(left: 5.0),
                icon: Icon(
                  Icons.arrow_back_ios,
                  size: rValue(
                    context: context,
                    defaultValue: 19.0,
                    whenSmaller: 17.0,
                  ),
                ),
                color: Colors.grey,
              ),
            ),
          ),
          centerTitle: true,
          backgroundColor: AppColors.mainBackground,
        ),
      ),

      // ****************************************** Body ******************************************

      body: GetBuilder<UserController>(
        builder: (UserController userController) {
          if (_contactPersonName.text.isEmpty) {
            _contactPersonName.text = userController.userModel.name;
            _contactPersonNumber.text = userController.userModel.phone;
          }

          return GetBuilder<LocationController>(
            builder: (LocationController locationController) {
              /*
                 Address data will get from here and from local storage
                 if users don't tap on Map.
              */

              if (locationController.addressList.isNotEmpty) {
                _addressController.text =
                    locationController.getUserAddress().address;
              }
              /*
                 Address data will get from here when 
                 users tap on map.
              */
              _addressController.text = locationController.placemark.name ?? "";

              return SingleChildScrollView(
                //

                // ********************************** Column Animation **********************************

                child: AnimationLimiter(
                  child: Column(
                    children: AnimationConfiguration.toStaggeredList(
                      duration: const Duration(milliseconds: 800),
                      childAnimationBuilder: (Widget widget) => SlideAnimation(
                        verticalOffset: 50.0,
                        child: FadeInAnimation(
                          child: widget,
                        ),
                      ),
                      children: <Widget>[
                        //

                        // ********************************** MapBox **********************************

                        SizedBox(
                          height: rValue(
                            context: context,
                            defaultValue: 150.0,
                            whenSmaller: 135.0,
                          ),
                          width: MediaQuery.of(context).size.width,
                          child: Stack(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: AppColors.secondaryBackground,
                                      width: 4.0,
                                    ),
                                    borderRadius: BorderRadius.circular(25.0),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(25.0),

                                    // ************************** MapBox **************************

                                    child: FlutterMap(
                                      options: MapOptions(
                                        center: _initialPosition,
                                        zoom: 11.2,
                                        onMapCreated:
                                            (MapController mapController) {
                                          _mapController = mapController;

                                          locationController
                                              .setMapController(_mapController);
                                        },
                                        onPositionChanged:
                                            (MapPosition mapPosition,
                                                bool hasGesture) {
                                          _mapPosition = mapPosition;
                                        },
                                        onTap: (_, __) {
                                          locationController.updatePosition(
                                            _mapPosition,
                                            true,
                                          );
                                        },
                                      ),
                                      children: <Widget>[
                                        TileLayerWidget(
                                          options: TileLayerOptions(
                                            urlTemplate:
                                                AppConstants.MAP_TEMPLATE,
                                            userAgentPackageName:
                                                AppConstants.PACKAGE_NAME,
                                            additionalOptions:
                                                AppConstants.ADDITIONAL_OPTIONS,
                                            backgroundColor:
                                                AppColors.mainBackground,
                                          ),
                                        ),
                                        MarkerLayerWidget(
                                          options: MarkerLayerOptions(
                                              rotate: true,
                                              markers: <Marker>[
                                                //

                                                // ********************** Marker **********************

                                                !locationController.loading
                                                    ? Marker(
                                                        point: LatLng(
                                                          _mapPosition
                                                              .center!.latitude,
                                                          _mapPosition.center!
                                                              .longitude,
                                                        ),
                                                        builder: (BuildContext
                                                                context) =>
                                                            const Icon(
                                                          Icons.location_on,
                                                          color:
                                                              AppColors.mainRed,
                                                          size: 28.0,
                                                        ),
                                                      )
                                                    : Marker(
                                                        point: LatLng(
                                                          _mapPosition
                                                              .center!.latitude,
                                                          _mapPosition.center!
                                                              .longitude,
                                                        ),
                                                        width: rValue(
                                                          context: context,
                                                          defaultValue: 110.0,
                                                          whenSmaller: 90.0,
                                                        ),
                                                        height: rValue(
                                                          context: context,
                                                          defaultValue: 110.0,
                                                          whenSmaller: 90.0,
                                                        ),
                                                        builder: (BuildContext
                                                                context) =>
                                                            Lottie.asset(
                                                          "assets/images/marker-loader.json",
                                                        ),
                                                      ),
                                              ]),
                                        )
                                      ],
                                    ),

                                    // **********************************************************
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // ********************************** Address Type **********************************
                        const SizedBox(height: 15.0),

                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 35.0),
                          width: double.maxFinite,
                          child: const Text(
                            "Select your address type : ",
                            style: TextStyle(
                              fontFamily: "Josefin",
                              color: AppColors.secondaryBackground,
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.bold,
                              fontSize: 13.0,
                            ),
                          ),
                        ),

                        const SizedBox(height: 10.0),

                        Row(
                          children: <Widget>[
                            //

                            // ********************************** Type Buttons **********************************

                            Flexible(
                              flex: 2,
                              child: SizedBox(
                                height: rValue(
                                  context: context,
                                  defaultValue: 40.0,
                                  whenSmaller: 35.0,
                                ),
                                width: double.maxFinite,
                                child: ListView.builder(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  itemCount:
                                      locationController.addressTypeList.length,
                                  scrollDirection: Axis.horizontal,
                                  itemExtent: rValue(
                                    context: context,
                                    defaultValue: 65.0,
                                    whenSmaller: 62.0,
                                  ),
                                  shrinkWrap: true,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Container(
                                      margin: const EdgeInsets.only(left: 10.0),
                                      child: FormButton(
                                        text: "",
                                        mapButton: true,
                                        icon: index == 0
                                            ? locationController
                                                        .addressTypeIndex ==
                                                    index
                                                ? Icons.home
                                                : Icons.home_outlined
                                            : index == 1
                                                ? locationController
                                                            .addressTypeIndex ==
                                                        index
                                                    ? Icons.work
                                                    : Icons.work_outline
                                                : locationController
                                                            .addressTypeIndex ==
                                                        index
                                                    ? Icons.location_on
                                                    : Icons
                                                        .location_on_outlined,
                                        onPressed: () => _onTypePressed(
                                          index,
                                          locationController,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),

                            // ********************************** To Pick Location Screen **********************************

                            Flexible(
                              flex: 1,
                              child: Container(
                                margin: const EdgeInsets.only(right: 30.0),
                                child: FormButton(
                                  text: "Full Map",
                                  color1: AppColors.secondaryBackground,
                                  color2: AppColors.secondaryBackground,
                                  height: 35.0,
                                  textSize: rValue(
                                    context: context,
                                    defaultValue: 12.0,
                                    whenSmaller: 10.0,
                                  ),
                                  onPressed: () =>
                                      _toPickLocationPage(locationController),
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20.0),

                        // ********************************** Delivery Address **********************************

                        CustomTextField(
                          label: "Delivery Address",
                          icon: _addressController.text == ""
                              ? Icons.location_on_outlined
                              : Icons.location_on,
                          controller: _addressController,
                          mapTextField: true,
                          textColor: _addressController.text ==
                                  "Unknown Location Found"
                              ? AppColors.pizzaRed
                              : AppColors.mapText,
                        ),
                        SizedBox(
                          height: rValue(
                            context: context,
                            defaultValue: 35.0,
                            whenSmaller: 20.0,
                          ),
                        ),

                        // ********************************** Name **********************************

                        CustomTextField(
                          label: "Your Name",
                          icon: Icons.person,
                          controller: _contactPersonName,
                          mapTextField: true,
                          textColor: AppColors.mapText,
                        ),
                        SizedBox(
                          height: rValue(
                            context: context,
                            defaultValue: 35.0,
                            whenSmaller: 20.0,
                          ),
                        ),

                        // ********************************** Phone **********************************

                        CustomTextField(
                          label: "Your Number",
                          icon: Icons.phone,
                          controller: _contactPersonNumber,
                          mapTextField: true,
                          textColor: AppColors.mapText,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),

      bottomNavigationBar: GetBuilder<LocationController>(
        builder: (LocationController locationController) {
          return

              // ******************** Save Address ********************
              Padding(
            padding: const EdgeInsets.symmetric(horizontal: 100.0)
                .copyWith(bottom: 20.0),
            child: SaveAddressButton(
              text: "Save Address",
              onPressed: () => _saveAddress(locationController),
            ),
          );
        },
      ),
    );
  }

  // ****************************** Helper Methods ******************************

  void _goToPrevPage() {
    Get.offNamed(RouteHelper.goToHomeScreen());
  }

  void _onTypePressed(int index, LocationController locationController) {
    locationController.setAddressTypeIndex(index);
  }

  void _saveAddress(LocationController locationController) {
    AddressModel addressModel = AddressModel(
      addressType: locationController
          .addressTypeList[locationController.addressTypeIndex]
          .toString(),
      address: _addressController.text,
      latitude: locationController.position.latitude.toString(),
      longitude: locationController.position.longitude.toString(),
      contactPersonName: _contactPersonName.text,
      contactPersonNumber: _contactPersonNumber.text,
    );

    locationController.saveAddress(addressModel).then((ResponseModel response) {
      if (response.isSuccess) {
        //

        Get.toNamed(RouteHelper.goToHomeScreen());

        showSnackBar(
          title: "Address",
          text: "Saved successfully",
        );
      } else {
        showSnackBar(
          title: "Address",
          text: "Couldn't save address",
          titleColor: AppColors.mainRed,
        );
      }
    });
  }

  void _permissionHandler() async {
    // Ask to turn on location
    bool serviceEnabled = await _location.serviceEnabled();

    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();

      if (!serviceEnabled) {
        return;
      }
    }

    // Ask for location permission
    PermissionStatus permissionGranted = await _location.hasPermission();

    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _location.requestPermission();

      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
  }

  void _getCurrentLocation() async {
    LocationData currentLocation = await _location.getLocation();
  }

  void _toPickLocationPage(LocationController locationController) {
    Get.toNamed(
      RouteHelper.goToPickLocationScreen(),
      arguments: PickLocationScreen(
        fromAddress: true,
        fromSignUp: false,
        mapController: locationController.mapController,
      ),
    );
    // _permissionHandler();
  }
}
