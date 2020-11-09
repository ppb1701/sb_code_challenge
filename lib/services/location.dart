import 'package:location/location.dart' as loc;

class UserLocation {
  final double latitude;
  final double longitude;
  UserLocation({this.latitude, this.longitude});
}

class Location {
  double longitude;
  double latitude;

  //Retrieve the current latitude and longitude.
  Future<void> getCurrentLocation() async {
    try {
      // if (kIsWeb) {
        loc.Location l = new loc.Location();
        var userLocation = await l.getLocation();
        latitude = userLocation.latitude;
        longitude = userLocation.longitude;
        return;
      // }

      // Position position =
      //     await getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      // longitude = position.longitude;
      // latitude = position.latitude;
    } catch (e) {
      print(e);
    }
  }
}
