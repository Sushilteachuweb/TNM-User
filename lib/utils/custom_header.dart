import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/LocationProvider.dart';

class CustomHeader extends StatelessWidget {
  final bool showNotification;
  final VoidCallback? onNotificationTap;

  const CustomHeader({
    Key? key,
    this.showNotification = false, // ✅ Default to false for Play Store
    this.onNotificationTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      child: Stack(
        alignment: Alignment.center,
        children: [


          // Location and Notification positioned on sides
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Location Section
              Consumer<LocationProvider>(
                builder: (context, locationProvider, child) {
                  return GestureDetector(
                    onTap: () {
                      locationProvider.refreshLocation();
                    },
                    child: Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: Colors.blue,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              locationProvider.city,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                                height: 1.1,
                              ),
                            ),
                            Text(
                              locationProvider.area,
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 10,
                                height: 1.1,
                              ),
                            ),
                          ],
                        ),
                        if (locationProvider.isLoading)
                          const Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: SizedBox(
                              width: 12,
                              height: 12,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                              ),
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),

              // Notification Icon - Completely disabled for Play Store deployment
              const SizedBox(width: 22), // Placeholder to maintain layout
              
              // Original notification code (commented out):
              // if (showNotification)
              //   GestureDetector(
              //     onTap: onNotificationTap,
              //     child: Image.asset(
              //       'images/notification1.png',
              //       height: 22,
              //       color: Colors.blue,
              //     ),
              //   )
              // else
              //   const SizedBox(width: 22),
            ],
          ),
        ],
      ),
    );
  }
}
