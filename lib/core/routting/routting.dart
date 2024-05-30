import 'package:flutter/material.dart';
import 'package:your_project_name/core/routting/routes.dart';
import 'package:your_project_name/view/sport/sport_screen.dart';

import '../../view/business/business_screen.dart';
import '../../view/layout/layout_screen.dart';
import '../../view/tech/tech_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.layout:
        return MaterialPageRoute(
          builder: (_) => const LayoutScreen(),
        );
      case Routes.tech:
        return MaterialPageRoute(
          builder: (_) => const TechScreen(),
        );
      case Routes.business:
        return MaterialPageRoute(
          builder: (_) => const BusinessScreen(),
        );
      case Routes.sports:
        return MaterialPageRoute(
          builder: (_) => const SportsScreen(),
        );
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
