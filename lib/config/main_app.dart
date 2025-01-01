import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

class MainApp extends StatelessWidget {
  const MainApp({super,key});

  @override
  widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: RouteApp.routes,
      initialRoute: RouteApp.initial,
    );    
  }
}