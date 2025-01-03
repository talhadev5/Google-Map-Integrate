import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:tophotels/modules/view/map/current_location.dart';
import 'package:tophotels/modules/widgets/custom_navbar.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  loadLocation();
  runApp(const MyApp());
}

loadLocation() async {
  // Check if location services are enabled

 
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const CustomNavBar());
  }
}
