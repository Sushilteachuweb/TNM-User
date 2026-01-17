import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import '../providers/LocationProvider.dart';

class LocationPermissionDialog {
  static Future<bool> checkAndShowDialog(BuildContext context) async {
    return true; // Skipping location check
    
    /*
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    LocationPermission permission = await Geolocator.checkPermission();

    if (!serviceEnabled || permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      if (context.mounted) {
        bool? result = await showDialog<bool>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              title: Row(
                children: [
                  Icon(Icons.location_on, color: Colors.blue, size: 28),
                  SizedBox(width: 10),
                  Text('Location Required'),
                ],
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    !serviceEnabled
                        ? 'Please enable location services to continue.'
                        : 'This app needs location permission to show nearby jobs and relevant content.',
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'You can change this later in settings.',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text(
                    'Not Now',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (!serviceEnabled) {
                      Navigator.of(context).pop(true);
                      await Geolocator.openLocationSettings();
                      // After returning from settings, fetch location
                      if (context.mounted) {
                        await Future.delayed(Duration(milliseconds: 500));
                        context.read<LocationProvider>().fetchLocation();
                      }
                    } else {
                      LocationPermission result = await Geolocator.requestPermission();
                      Navigator.of(context).pop(true);
                      // If permission granted, fetch location immediately
                      if (result == LocationPermission.always || result == LocationPermission.whileInUse) {
                        if (context.mounted) {
                          await Future.delayed(Duration(milliseconds: 300));
                          context.read<LocationProvider>().fetchLocation();
                        }
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Enable',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            );
          },
        );
        
        // If user enabled location, fetch it automatically
        if (result == true && context.mounted) {
          // Wait a bit for permission to be granted
          await Future.delayed(Duration(milliseconds: 500));
          context.read<LocationProvider>().fetchLocation();
        }
        
        return result ?? false;
      }
    }
    return true; // Permission already granted
    */
  }
}
