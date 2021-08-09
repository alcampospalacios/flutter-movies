import 'package:films/src/pages/stateless/detail-page.dart';
import 'package:flutter/material.dart';

import 'package:films/src/pages/stateless/home-page.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/': (BuildContext context) => HomePage(),
    'detail': (BuildContext context) => DetailPage()
  };
}
