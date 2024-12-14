import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todo/Database/todo_database.dart';
import 'package:todo/Pages/home_page.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:todo/Service/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.init();
  tz.initializeTimeZones();
  await TodoDatabase.initialize();
  runApp(ChangeNotifierProvider(
    create: (context) => TodoDatabase(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TODO',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        textTheme: GoogleFonts.jostTextTheme(),
      ),
      home: const HomePage(),
    );
  }
}
