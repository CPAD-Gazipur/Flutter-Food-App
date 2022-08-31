import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_food_app/config/colors.dart';
import 'package:flutter_food_app/providers/providers.dart';
import 'package:flutter_food_app/widgets/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

class GoogleMapScreen extends StatefulWidget {
  const GoogleMapScreen({Key? key}) : super(key: key);

  @override
  State<GoogleMapScreen> createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  LatLng _initialMapLocation = const LatLng(24.5957, 90.9224);
  final Location _location = Location();
  late GoogleMapController googleMapController;
  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;

  @override
  void initState() {
    super.initState();
    debugPrint('GETTING LOCATION PERMISSION');
    _getLocationPermission();
    _getCurrentLocation();
  }

  void _getLocationPermission() async {
    _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
  }

  void _getCurrentLocation() async {
    LocationData locationData = await _location.getLocation();

    _initialMapLocation =
        LatLng(locationData.latitude!, locationData.longitude!);

    debugPrint('MAP LOCATION: $_initialMapLocation');
  }

  void _onMapCreated(GoogleMapController value) {
    googleMapController = value;
    _location.onLocationChanged.listen((event) {
      googleMapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(event.latitude!, event.longitude!),
            zoom: 15,
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    CheckoutProvider checkoutProvider = Provider.of<CheckoutProvider>(context);
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'MapView',
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: _initialMapLocation,
                zoom: 15,
              ),
              mapType: MapType.normal,
              onMapCreated: _onMapCreated,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 50,
                width: double.infinity,
                margin: const EdgeInsets.only(
                  right: 60,
                  bottom: 40,
                  left: 20,
                  top: 40,
                ),
                child: MaterialButton(
                  onPressed: () async {
                    EasyLoading.show(status: 'Getting Location....');
                    await _location.getLocation().then((value) {
                      if (value.longitude != null) {
                        setState(() {
                          checkoutProvider.setLocation = value;
                          debugPrint(
                              'LOCATION: ${value.latitude}, ${value.longitude}');
                          EasyLoading.showSuccess('Done');
                          Navigator.pop(context);
                        });
                      } else {
                        EasyLoading.showError('Something went wrong.');
                      }
                    });
                  },
                  color: primaryColor,
                  shape: const StadiumBorder(),
                  child: const Text(
                    'Set Location',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
