import 'package:foodies/Constants/app_constants.dart';
import 'package:foodies/Constants/snack_bar.dart';
import 'package:foodies/Features/Location/Widgets/blur_container.dart';
import 'package:foodies/Controllers/location_controller.dart';
import 'package:foodies/Features/Location/Widgets/loading_container.dart';
import 'package:foodies/Features/Location/Widgets/location_dialogue.dart';
import 'package:foodies/Features/Location/Widgets/save_address_button.dart';
import 'package:foodies/Models/address_model.dart';
import 'package:foodies/Routes/route_helper.dart';
import 'package:lottie/lottie.dart' show Lottie;
import 'package:foodies/Constants/colors.dart';
import 'package:foodies/Constants/utils.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PickLocationScreen extends StatefulWidget {
  final bool fromSignUp;
  final bool fromAddress;
  final MapController mapController;

  const PickLocationScreen({
    Key? key,
    required this.fromSignUp,
    required this.fromAddress,
    required this.mapController,
  }) : super(key: key);

  @override
  State<PickLocationScreen> createState() => _PickLocationScreenState();
}

class _PickLocationScreenState extends State<PickLocationScreen> {
  late MapPosition _mapPosition;
  late LatLng _initialPosition;
  late MapController _mapController;

  @override
  void initState() {
    super.initState();

    if (Get.find<LocationController>().addressList.isEmpty) {
      _initialPosition = LatLng(45.51563, -122.677433);
      _mapPosition = MapPosition(
        center: LatLng(45.51563, -122.677433),
        zoom: 17.0,
      );
    } else {
      if (Get.find<LocationController>().addressList.isNotEmpty) {
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
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationController>(
        builder: (LocationController locationController) {
      return Scaffold(
        backgroundColor: AppColors.mainBackground,
        body: SafeArea(
          child: Center(
            child: SizedBox(
              width: double.maxFinite,
              child: Stack(
                children: <Widget>[
                  //

                  // ****************************** MapBox ******************************

                  FlutterMap(
                    options: MapOptions(
                      center: _initialPosition,
                      zoom: 17.0,
                      onMapCreated: (MapController mapController) {
                        _mapController = mapController;
                      },
                      onPositionChanged:
                          (MapPosition mapPosition, bool hasGesture) {
                        _mapPosition = mapPosition;
                      },
                      onTap: (_, __) {
                        locationController.updatePosition(
                          _mapPosition,
                          false,
                        );
                      },
                    ),
                    children: <Widget>[
                      TileLayerWidget(
                        options: TileLayerOptions(
                          urlTemplate: AppConstants.MAP_TEMPLATE,
                          userAgentPackageName: AppConstants.PACKAGE_NAME,
                          additionalOptions: AppConstants.ADDITIONAL_OPTIONS,
                          backgroundColor: AppColors.mainBackground,
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
                                      _mapPosition.center!.latitude,
                                      _mapPosition.center!.longitude,
                                    ),
                                    width: rValue(
                                      context: context,
                                      defaultValue: 45.0,
                                      whenSmaller: 40.0,
                                    ),
                                    height: rValue(
                                      context: context,
                                      defaultValue: 45.0,
                                      whenSmaller: 40.0,
                                    ),
                                    builder: (BuildContext context) =>
                                        Lottie.asset(
                                      "assets/images/pick-location.json",
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : Marker(
                                    point: LatLng(
                                      _mapPosition.center!.latitude,
                                      _mapPosition.center!.longitude,
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
                                    builder: (BuildContext context) =>
                                        Lottie.asset(
                                      "assets/images/marker-loader.json",
                                    ),
                                  )
                          ],
                        ),
                      ),
                    ],
                  ),

                  // ****************************** Search Address ******************************

                  Positioned(
                    top: rValue(
                      context: context,
                      defaultValue: 45.0,
                      whenSmaller: 30.0,
                    ),
                    left: 20.0,
                    right: 20.0,
                    child: Container(
                      height: 50.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: BlurContainer(
                        text: locationController.pickPlacemark.name ??
                            "Click to pick a location",
                        onSearchTapped: _onSearchTapped,
                      ),
                    ),
                  ),

                  // ****************************** Pick Address Button ******************************

                  Positioned(
                    bottom: rValue(
                      context: context,
                      defaultValue: 20.0,
                      whenSmaller: 10.0,
                    ),
                    right: 0.0,
                    left: 0.0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 100.0)
                          .copyWith(bottom: 20.0),
                      child: !locationController.isLoading
                          ? SaveAddressButton(
                              text: locationController.inZone
                                  ? widget.fromAddress
                                      ? "Pick Address"
                                      : "Pick Location"
                                  : "Service is not available in your area",
                              onPressed: (locationController.buttonDisabled ||
                                      locationController.loading)
                                  ? null
                                  : () => _pickAddress(locationController),
                              fromAddLocationScreen: false,
                            )
                          : LoadingContainer(fromAddress: widget.fromAddress),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  // ****************************** Helper Methods ******************************

  void _pickAddress(LocationController locationController) {
    if (locationController.pickPlacemark.name != null &&
        locationController.pickPosition.latitude != 0) {
      if (widget.fromAddress) {
        if (widget.mapController != null) {
          widget.mapController.move(
            LatLng(
              locationController.pickPosition.latitude,
              locationController.pickPosition.longitude,
            ),
            11.0,
          );
          locationController.setUpdatedAddressFromPickLocationScreen();
          Get.back();
        }
      }
    }
  }

  void _onSearchTapped() {
    Get.dialog(
      LocationDialogue(
        mapController: _mapController,
      ),
      transitionCurve: Curves.bounceInOut,
      useSafeArea: true,
      barrierColor: const Color.fromARGB(175, 0, 0, 0),
      barrierDismissible: true,
      routeSettings: const RouteSettings(
        name: "search",
      ),
    );
  }
}
