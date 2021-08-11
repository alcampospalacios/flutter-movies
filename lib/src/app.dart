import 'package:films/src/providers/movies-provider.dart';
import 'package:flutter/material.dart';

// ignore: todo
// TODO: Custom imports
import 'package:films/src/routes/routes.dart';
import 'package:provider/provider.dart';

class AppState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MoviesProvider(),
          lazy: false,
        )
      ],
      child: MyApp(),
    );
  }
}

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
