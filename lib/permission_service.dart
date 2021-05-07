// ignore: import_of_legacy_library_into_null_safe
import 'package:location/location.dart';

class PermissionsService {

  Location location = new Location();

  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;

  /// Request the user's permission to use their location when the app is in use
   requestLocationPermission() async {
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
    // var status = await Permission.location.request();
    //
    // switch (status){
    //   case PermissionStatus.denied:
    //     openAppSettings();
    //     break;
    //   default:
    //     print("granted");
    // }

  }
  // checkLocationPermission() async {
  //   if (await Permission.locationWhenInUse.serviceStatus.isDisabled) {
  //     openAppSettings();
  //   }
  // }
}