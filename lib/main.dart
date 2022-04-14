import 'dart:io';

import 'package:employer_details/api/models/employee_list_model.dart';
import 'package:employer_details/modules/employer_list/employer_list_view.dart';
import 'package:employer_details/modules/splash/splash_view.dart';
import 'package:employer_details/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Hive.initFlutter();
  Directory dir = await getApplicationDocumentsDirectory();
  Hive
    ..init(dir.path)
    ..registerAdapter<EmployerModel>(EmployerModelAdapter());
  Hive.registerAdapter<Address>(AddressAdapter());
  Hive.registerAdapter<Geo>(GeoAdapter());
  Hive.registerAdapter<Company>(CompanyAdapter());
  await Hive.openBox<EmployerModel>(Utils.employerListBox);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashPage(),
    );
  }
}
