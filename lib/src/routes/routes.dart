import 'package:flutter/material.dart';

import 'package:films/src/pages/stateless/home-page.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/': (BuildContext context) => HomePage(),
  };
}
