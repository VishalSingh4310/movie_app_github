import 'package:flutter/material.dart';
import 'package:movies_app/components/bottom_nav.dart';
import 'package:movies_app/pages/home.dart';

class MyRoute {
  static String HOME = "/";
  static String DETAILS = "/";
  static String FAV = "/";
  static String PROFILE = "/";
}

class MainRoute {
  static Map<String, Widget Function(BuildContext)> get mainRoutes => {
        MyRoute.HOME: (context) => const CustomBottomNav(),
        // MyRoute.DETAILS: (context)=>Details(),
        // MyRoute.FAV: (context)=>Fav(),
        // MyRoute.PROFILE: (context)=>Profile(),
      };
}
