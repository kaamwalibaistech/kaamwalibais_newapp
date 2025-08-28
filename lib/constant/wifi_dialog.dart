// import 'package:android_intent_plus/android_intent.dart';
// import 'package:flutter/material.dart';

// void openWifiSettings() {
//   const intent = AndroidIntent(
//     action: 'android.settings.WIFI_SETTINGS',
//   );
//   intent.launch();
// }

// void showWifiDialog(BuildContext context) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: const Text("No Internet Connection"),
//         content: const Text("Please enable Wi-Fi to continue."),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             child: const Text("Cancel"),
//           ),
//           TextButton(
//             onPressed: () {
//               openWifiSettings();
//               Navigator.pop(context);
//             },
//             child: const Text("Open Wi-Fi Settings"),
//           ),
//         ],
//       );
//     },
//   );
// }
