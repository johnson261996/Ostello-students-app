import 'package:geolocator/geolocator.dart';

Future<Position> determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;
  final GeolocatorPlatform locator = GeolocatorPlatform.instance;

  // Test if location services are enabled.
  serviceEnabled = await locator.isLocationServiceEnabled();

  if (!serviceEnabled) {
    final opened = await locator.openLocationSettings();

    if (!opened) {
      return Future.error('Location services are disabled.');
    }
  }

  permission = await locator.checkPermission();

  if (permission == LocationPermission.denied) {
    permission = await locator.requestPermission();

    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error(
      'Location permissions are permanently denied, we cannot request permissions.',
    );
  }

  return await locator.getCurrentPosition();
}
