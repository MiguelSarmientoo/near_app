import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './screens/routes/app_routes.dart';
import './screens/splash_screen.dart';  // Importa el SplashScreen

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final bool showOnboarding = await _shouldShowOnboarding();
  runApp(MyApp(showOnboarding: showOnboarding));
}

class MyApp extends StatelessWidget {
  final bool showOnboarding;

  const MyApp({super.key, required this.showOnboarding});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return MaterialApp(
          title: 'NEAR APP',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            fontFamily: 'Montserrat',
            appBarTheme: const AppBarTheme(
              backgroundColor: Color(0xFF3F22BA),
              elevation: 0,
              centerTitle: true,
              titleTextStyle: TextStyle(
                color: Colors.white, 
                fontSize: 20, 
                fontWeight: FontWeight.bold, 
              ),
            ),
            scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
          ),
          home: SplashScreen(showOnboarding: showOnboarding), 
          onGenerateRoute: AppRoutes.generateRoute,
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}

Future<bool> _shouldShowOnboarding() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool('onboarding_seen') ?? true;
}
