// lib/screens/routes/app_routes.dart
import 'package:flutter/material.dart';
import '../home_screen.dart' as HomeScreenModule;
import '../intro/OnBoardingScreen1.dart';
import '../intro/OnBoardingScreen2.dart';
import '../intro/OnBoardingScreen3.dart';
import '../intro/OnBoardingScreen4.dart';
import '../map_screen.dart';
import '../more_information.dart';
import '../ar_screen.dart';
import '../how_to_avoid_screen.dart';
import '../marker_data.dart';

class AppRoutes {
  static const String home = '/home';
  static const String intro1 = '/intro1'; 
  static const String intro2 = '/intro2'; 
  static const String intro3 = '/intro3'; 
  static const String intro4 = '/intro4';
  static const String map = '/map';
  static const String moreInfo = '/more_info';
  static const String arScreen = '/ar_screen';
  static const String howToAvoid = '/how_to_avoid';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreenModule.HomeScreen());
      case intro1:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen1());
      case intro2:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen2());
      case intro3:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen3());
      case intro4:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen4());
      case map:
        return MaterialPageRoute(builder: (_) => MapScreen(markers: markers));
      case moreInfo:
        if (settings.arguments is Map<String, dynamic>) {
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (_) => MoreInformationScreen(
              title: args['title'],
              latitude: args['latitude'],
              longitude: args['longitude'],
              description: args['description'],
              image: args['image'],
              pastImage: args['pastImage'],
              futureImage: args['futureImage'],
              howtoavoid: args['howtoavoid'],
            ),
          );
        }
        return _errorRoute(); // Manejo de errores
      case arScreen: 
        return MaterialPageRoute(builder: (_) => const ARScreen());
      case howToAvoid: 
        if (settings.arguments is Map<String, dynamic>) {
          final args = settings.arguments as Map<String, dynamic>; 
          return MaterialPageRoute(
            builder: (_) => HowToAvoidScreen(
              title: args['title'],
              latitude: args['latitude'],
              longitude: args['longitude'],
              description: args['description'],
              image: args['image'],
              pastImage: args['pastImage'],
              futureImage: args['futureImage'],
              howtoavoid: args['howtoavoid'],
            ),
          );
        }
        return _errorRoute();
      default:
        return _errorRoute(); 
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: const Center(child: Text('No se encontró la ruta')),
      ),
    );
  }
}
