import 'package:flutter/material.dart';

// ignore: todo
// TODO: Custom imports
import 'package:films/src/routes/routes.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  // theme: ThemeData.dark(),
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(),
        initialRoute: '/',
        routes: getApplicationRoutes());
  }
}
