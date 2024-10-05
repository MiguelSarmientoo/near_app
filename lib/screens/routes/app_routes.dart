import 'package:flutter/material.dart';
import '../home_screen.dart' as HomeScreenModule;
import '../login_screen.dart' as LoginScreenModule;
import '../intro/OnBoardingScreen1.dart';
import '../intro/OnBoardingScreen2.dart';
import '../intro/OnBoardingScreen3.dart';
import '../intro/OnBoardingScreen4.dart';
import '../map_screen.dart';
import '../more_information.dart';
import '../ar_screen.dart'; // Importar la nueva pantalla
import '../marker_data.dart'; // Asegúrate de que esta importación sea correcta

class AppRoutes {
  static const String home = '/home';
  static const String login = '/login';
  static const String intro1 = '/intro1'; 
  static const String intro2 = '/intro2'; 
  static const String intro3 = '/intro3'; 
  static const String intro4 = '/intro4';
  static const String map = '/map';
  static const String moreInfo = '/more_info';
  static const String arScreen = '/ar_screen'; // Nueva ruta para ar_screen

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => HomeScreenModule.HomeScreen());
      case login:
        return MaterialPageRoute(builder: (_) => LoginScreenModule.LoginScreen());
      case intro1:
        return MaterialPageRoute(builder: (_) => OnboardingScreen1());
      case intro2:
        return MaterialPageRoute(builder: (_) => OnboardingScreen2());
      case intro3:
        return MaterialPageRoute(builder: (_) => OnboardingScreen3());
      case intro4:
        return MaterialPageRoute(builder: (_) => OnboardingScreen4());
      case map:
        return MaterialPageRoute(
          builder: (_) => MapScreen(markers: markers), // Asegúrate de usar 'markers'
        );
      case moreInfo:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => MoreInformationScreen(
            title: args['title'],
            latitude: args['latitude'],
            longitude: args['longitude'],
            description: args['description'],
            image: args['image'],
          ),
        );
      case arScreen: // Manejar la nueva ruta
        return MaterialPageRoute(builder: (_) => ARScreen());
      default:
        return MaterialPageRoute(builder: (_) => OnboardingScreen1());
    }
  }
}
