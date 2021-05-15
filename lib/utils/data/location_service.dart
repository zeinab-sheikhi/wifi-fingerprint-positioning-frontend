// ignore: import_of_legacy_library_into_null_safe
import 'package:location/location.dart';

class LocationService {

  final Location location = Location();

  Future<PermissionStatus> checkPermissions() async {
    PermissionStatus permissionGrantedResult = await location.hasPermission();
    return  permissionGrantedResult;
  }

  Future<void> requestPermission() async {
    await location.requestPermission();
  }

  Future<bool> checkService() async {
    bool serviceEnabledResult = await location.serviceEnabled();
    return serviceEnabledResult;
  }

  Future<void> requestService() async {
    await location.requestService();
  }
}