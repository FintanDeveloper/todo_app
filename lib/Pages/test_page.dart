// import 'package:flutter/material.dart';
// import 'package:todo/Service/notification_service.dart';

// class TestPage extends StatefulWidget {
//   const TestPage({super.key});

//   @override
//   State<TestPage> createState() => _TestPageState();
// }

// class _TestPageState extends State<TestPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               onPressed: () {
//                 NotificationService.showInstantNotification(
//                     "Instant Notification",
//                     "This shows an instant notifications");
//               },
//               child: const Text('Show Notification'),
//             ),
//             const SizedBox(height: 12),
//             ElevatedButton(
//               onPressed: () {
//                 DateTime scheduledDate = DateTime(
//                   2024,
//                   11,
//                   22,
//                   11,
//                   13,
//                 );
//                 NotificationService.scheduleNotification(
//                   0,
//                   "Scheduled Notification",
//                   "This notification is scheduled to appear after 7 seconds",
//                   scheduledDate,
//                 );
//               },
//               child: const Text('Schedule Notification'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
