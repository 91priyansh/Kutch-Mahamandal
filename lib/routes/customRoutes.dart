import 'package:flutter/cupertino.dart';
import 'package:kutchmahamandalbhav/pages/changeLanguagePage.dart';
import 'package:kutchmahamandalbhav/pages/homePage.dart';
import 'package:kutchmahamandalbhav/pages/notFoundPage.dart';
import 'package:kutchmahamandalbhav/pages/splashScreen.dart';
import 'package:kutchmahamandalbhav/routes/routesName.dart';

class CustomRoutes {
  static Route<dynamic> allRoutes(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case splash:
        {
          return CupertinoPageRoute(builder: (context) => SplashScreen());
        }
      case home:
        {
          return CupertinoPageRoute(builder: (context) => HomePage());
        }
      case changeLanguage:
        {
          return ChangeLanguagePage.route(routeSettings);
        }
    }

    return CupertinoPageRoute(builder: (context) => NotFoundPage());
  }
}
