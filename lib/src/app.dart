import 'package:flutter/material.dart';

// ignore: todo
// TODO: Custom imports
import 'package:films/src/routes/routes.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: getApplicationRoutes());
  }
}
