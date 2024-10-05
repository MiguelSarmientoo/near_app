import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './screens/routes/app_routes.dart';

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
              backgroundColor: Color(0xFF3F22BA), // Color del encabezado
              elevation: 0,
              centerTitle: true,
              titleTextStyle: TextStyle(
                color: Colors.white, // Color del texto en el encabezado
                fontSize: 20, // Ajusta el tamaño de fuente según sea necesario
                fontWeight: FontWeight.bold, // Puedes cambiar el peso de la fuente si es necesario
              ),
            ),
            scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
          ),
          // Si ya ha visto el Onboarding, muestra la pantalla de login o home
          initialRoute: showOnboarding ? AppRoutes.intro1 : AppRoutes.login,
          onGenerateRoute: AppRoutes.generateRoute,
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}

// Función que verifica si el Onboarding ya fue mostrado
Future<bool> _shouldShowOnboarding() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool('onboarding_seen') ?? true; // Si no existe, se muestra
}
