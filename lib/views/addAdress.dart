import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive/hive.dart';
import 'package:home_made/constants.dart';
import 'package:location/location.dart';

class AddAddress extends StatefulWidget {
  @override
  _AddAddressState createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  TextEditingController areaController,
      streetNameController,
      buildingNumberController,
      apartmentNumber,
      addressController,
      phoneController = TextEditingController();

  Box adressBox;

  bool isLoading = true;
  List<Address> addresses;
  Location location = new Location();

  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;
  void checklocation() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
    print(_locationData);
    adressBox = Hive.box("name");
    if (adressBox.get("lang") == null) {
      adressBox.put("lang", 26.8206);
    }

    if (adressBox.get("lat") == null) {
      adressBox.put("lat", 30.8025);
    }
    adressBox.put("lang", _locationData.longitude);
    adressBox.put("lat", _locationData.longitude);

     Navigator.push(
        context,
        MaterialPageRoute(
            builder: (ctx) => MapSample(
                  lat: _locationData.latitude,
                  lang: _locationData.longitude,
                )));

    final coordinates =
        new Coordinates(_locationData.longitude, _locationData.longitude);

    addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    addToControllers();
    print(addresses[0]);
  }

  void addToControllers() {
    areaController.text = addresses[0].adminArea;
    streetNameController.text = addresses[0].addressLine;
  }

  @override
  void initState() {
    checklocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "اضف عنوان",
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'tajwal',
          ),
        ),
      ),
      body: Container(
        height: _height,
        width: _width,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 18.0,
              ),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (ctx) => MapSample(
                                    lang: adressBox.get("lang"),
                                    lat: adressBox.get("lat"),
                                  )));
                    },
                    child: Container(
                      color: yellow,
                      width: _width * .5,
                      height: 40,
                      child: Center(
                        child: Text(
                          "تحديد علي الخارطة",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontFamily: 'tajwal'),
                        ),
                      ),
                    ),
                  )),
            ),
            SizedBox(
              height: _height * .05,
            ),
            buildTextfield("المنطقة", areaController, false),
            buildTextfield("اسم الشارع", areaController, false),
            buildTextfield("رقم البناء", buildingNumberController, false),
            buildTextfield("رقم الشقة", apartmentNumber, false),
            buildTextfield("العنوان", addressController, false),
            buildTextfield("رقم الهاتف", phoneController, true),
          ],
        ),
      ),
    );
  }
}

class MapSample extends StatefulWidget {
  final double lang;
  final double lat;

  const MapSample({Key key, this.lang, this.lat}) : super(key: key);
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Box adressBox;

  @override
  void initState() {
    adressBox = Hive.box("name");
    if (adressBox.get("lang") == null) {
      adressBox.put("lang", widget.lang ?? 0);
    }

    if (adressBox.get("lat") == null) {
      adressBox.put("lat", widget.lat ?? 0);
    }

    super.initState();
  }

  Completer<GoogleMapController> _controller = Completer();
  BitmapDescriptor customIcon1;
  double zoom = 2000;
  LatLng _lastMapPosition = LatLng(0, 0);

  bool isMoving = false;
  @override
  Widget build(BuildContext context) {
    print(widget.lang);
    return SafeArea(
      child: new Scaffold(
        appBar: AppBar(
          backgroundColor: yellow,
          centerTitle: true,
          title: Text(
            "تحديد العنوان",
            style: TextStyle(color: Colors.white, fontFamily: 'tajwal'),
          ),
        ),
        body: Stack(
          children: [
            GoogleMap(
              mapType: MapType.normal,
              mapToolbarEnabled: true,
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              initialCameraPosition: CameraPosition(
                  target: LatLng(adressBox.get("lat"), adressBox.get("lang")),
                  zoom: 14.4746),
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              onCameraMove: (pos) {
                setState(() {
                  _lastMapPosition = pos.target;
                });
              },
              onCameraMoveStarted: () {
                setState(() {
                  isMoving = true;
                });
              },
              onCameraIdle: () {
                setState(() {
                  isMoving = false;
                });
              },
            ),
            Center(
              child: Image(
                image: AssetImage(
                  "assets/images/marker.png",
                ),
                color: isMoving ? Colors.orange.withOpacity(.3) : Colors.orange,
                height: 30,
              ),
            ),
          ],
        ),
        floatingActionButton: isMoving
            ? null
            : FloatingActionButton.extended(
                backgroundColor: yellow,
                onPressed: () async {
                  adressBox.put("lat", _lastMapPosition.latitude);
                  adressBox.put("lang", _lastMapPosition.longitude);

                  Navigator.pop(context);
                },
                label: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 48.0),
                  child: Text(
                    'تم التحديد',
                    style: TextStyle(color: Colors.white, fontFamily: 'tajwal'),
                  ),
                ),
              ),
      ),
    );
  }
}

Widget buildTextfield(
    String name, TextEditingController controller, bool isPhone) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextFormField(
      controller: controller,
      keyboardType: isPhone ? TextInputType.phone : TextInputType.text,
      cursorColor: Colors.grey,
      style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontFamily: 'tajwal',
          fontSize: 20),
      decoration: InputDecoration(
          focusedBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
          labelText: name,
          labelStyle: TextStyle(
              fontFamily: 'tajwal',
              fontWeight: FontWeight.bold,
              color: Colors.grey)),
    ),
  );
}
