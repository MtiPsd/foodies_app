import 'package:foodies/Constants/app_constants.dart';
import 'package:foodies/Constants/colors.dart';
import 'package:foodies/Constants/utils.dart';
import 'package:foodies/Controllers/location_controller.dart';
import 'package:get/get.dart';
import 'package:mapbox_search/mapbox_search.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class LocationDialogue extends StatefulWidget {
  final MapController mapController;
  const LocationDialogue({Key? key, required this.mapController})
      : super(key: key);

  @override
  State<LocationDialogue> createState() => _LocationDialogueState();
}

class _LocationDialogueState extends State<LocationDialogue>
    with SingleTickerProviderStateMixin {
  //

  TextEditingController controller = TextEditingController();

  late AnimationController animationController;

  late Animation<double> animation;

  @override
  void initState() {
    animationController = AnimationController(
      duration: const Duration(milliseconds: 1),
      vsync: this,
    );

    animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.fastOutSlowIn,
    );
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Call Controller

    return Container(
      padding: const EdgeInsets.all(20.0).copyWith(
        top: rValue(
          context: context,
          defaultValue: 45.0,
          whenSmaller: 31.0,
        ),
      ),
      alignment: Alignment.topCenter,
      child: Material(
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Ink(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: const Color.fromARGB(202, 59, 59, 72),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: "Search... ",
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: rValue(
                          context: context,
                          defaultValue: 14.0,
                          whenSmaller: 13.0,
                        ),
                      ),
                    ),
                    style: TextStyle(
                      fontFamily: "Josefin",
                      color: Colors.white70,
                      fontSize: rValue(
                        context: context,
                        defaultValue: 17.0,
                        whenSmaller: 13.0,
                      ),
                    ),
                    cursorColor: Colors.grey,
                    keyboardType: TextInputType.streetAddress,
                    enableSuggestions: true,
                    textInputAction: TextInputAction.search,
                    textCapitalization: TextCapitalization.words,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            FutureBuilder<Widget>(
              future: _buildSuggestions(context),
              initialData: const SizedBox(height: 0.0, width: 0.0),
              builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
                Widget widget = snapshot.data!;
                return widget;
              },
            ),
          ],
        ),
      ),
    );
  }

  // ****************************** Helper Methods ******************************

  Future<List<MapBoxPlace>?> _searchLocations() async {
    PlacesSearch placesSearch = PlacesSearch(
      apiKey: AppConstants.PUBLIC_KEY,
      limit: 6,
    );
    List<MapBoxPlace>? places = await placesSearch.getPlaces(controller.text);

    setState(() {});
    return places;
  }

  Future<Widget> _buildSuggestions(BuildContext context) async {
    List<MapBoxPlace>? places = await _searchLocations();
    List<MapBoxPlace> suggestions = places!.where((MapBoxPlace mapBoxPlace) {
      final String result = mapBoxPlace.placeName!.toLowerCase();
      final String input = controller.text.toLowerCase();

      return result.contains(input);
    }).toList();

    return GetBuilder<LocationController>(
      builder: (LocationController locationController) {
        return ListView.builder(
          itemCount: suggestions.length,
          shrinkWrap: true,
          cacheExtent: 200.0,
          itemBuilder: (BuildContext context, int index) {
            final MapBoxPlace suggestion = suggestions[index];

            List<double>? coordinates = suggestion.geometry!.coordinates;

            return Ink(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              decoration: BoxDecoration(
                //const Color.fromARGB(133, 171, 171, 171)
                color: AppColors.secondaryBackground,
                borderRadius: suggestion == suggestions.first
                    ? const BorderRadius.only(
                        topLeft: Radius.circular(15.0),
                        topRight: Radius.circular(15.0),
                      )
                    : suggestion == suggestions.last
                        ? const BorderRadius.only(
                            bottomLeft: Radius.circular(15.0),
                            bottomRight: Radius.circular(15.0),
                          )
                        : BorderRadius.circular(0.0),
              ),
              child: ListTile(
                title: Text(
                  suggestion.placeName!,
                  style: TextStyle(
                    fontFamily: "Mulish",
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: rValue(
                      context: context,
                      defaultValue: 14.0,
                      whenSmaller: 13.0,
                    ),
                    height: 1.3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  maxLines: 1,
                ),
                leading: Icon(
                  Icons.location_on_outlined,
                  color: Colors.grey,
                  size: rValue(
                    context: context,
                    defaultValue: 23.0,
                    whenSmaller: 20.0,
                  ),
                ),
                shape: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: suggestion != suggestions.last
                        ? AppColors.secondaryBackground
                        : Colors.transparent,
                    width: 3.0,
                  ),
                ),
                onTap: () {
                  // controller.text = suggestion.placeName!;
                  locationController.setLatLngForSearch(
                    latLng: LatLng(coordinates![1], coordinates[0]),
                    address: suggestion.placeName!,
                  );
                  _animatedMapMove(
                    LatLng(coordinates[1], coordinates[0]),
                    17.0,
                  );
                  Get.back();
                },
              ),
            );
          },
        );
      },
    );
  }

  void _animatedMapMove(LatLng destLocation, double destZoom) {
    final Tween<double> latTween = Tween<double>(
      begin: widget.mapController.center.latitude,
      end: destLocation.latitude,
    );
    final Tween<double> lngTween = Tween<double>(
      begin: widget.mapController.center.longitude,
      end: destLocation.longitude,
    );
    final Tween<double> zoomTween = Tween<double>(
      begin: widget.mapController.zoom,
      end: destZoom,
    );

    animationController.addListener(() {
      widget.mapController.move(
        LatLng(
          latTween.evaluate(animation),
          lngTween.evaluate(animation),
        ),
        zoomTween.evaluate(animation),
      );
    });

    animationController.forward();
  }
}


/* 
TypeAheadField(
                textFieldConfiguration: TextFieldConfiguration(
                  controller: controller,
                  textInputAction: TextInputAction.search,
                  autofocus: true,
                  textCapitalization: TextCapitalization.words,
                  keyboardType: TextInputType.streetAddress,
                ),
                onSuggestionSelected: (suggestion) {},
                // As we type, we get suggestions
                suggestionsCallback: (String pattern) {},
                itemBuilder: (BuildContext context, itemData) {},
              ),

*/