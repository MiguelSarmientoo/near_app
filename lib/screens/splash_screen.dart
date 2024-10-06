import 'package:flutter/material.dart';
import 'dart:async';
import './routes/app_routes.dart';

class SplashScreen extends StatefulWidget {
  final bool showOnboarding;

  const SplashScreen({super.key, required this.showOnboarding});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final int _dotCount = 3; // Número de puntos en la animación
  List<double> _dotOpacity = []; // Lista para almacenar opacidad de los puntos
  Timer? _timer; // Temporizador para la animación
  bool _showLoading = false; // Controla si se debe mostrar el indicador de carga
  bool _showLogo = true; // Controla si se debe mostrar el logo

  @override
  void initState() {
    super.initState();
    _initializeDots();
    _startSplashScreen();
  }

  void _initializeDots() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..repeat(reverse: true);

    _dotOpacity = List.filled(_dotCount, 0.3); 

    _timer = Timer.periodic(const Duration(milliseconds: 600), (timer) {
      if (mounted) {
        setState(() {
          for (int i = 0; i < _dotCount; i++) {
            _dotOpacity[i] = (i == (timer.tick % _dotCount)) ? 1.0 : 0.3; 
          }
        });
      }
    });
  }

  void _startSplashScreen() async {
    await Future.delayed(const Duration(seconds: 3));

    setState(() {
      _showLogo = false; 
      _showLoading = true; 
    });

    await Future.delayed(const Duration(seconds: 2)); 
    if (widget.showOnboarding) {
      Navigator.of(context).pushReplacementNamed(AppRoutes.intro1);
    } else {
      Navigator.of(context).pushReplacementNamed(AppRoutes.home);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel(); 
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, 
      body: Stack(
        children: [
          // Imagen del splash
          Center(
            child: AnimatedOpacity(
              opacity: _showLogo ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 600),
              child: Image.asset(
                'assets/images/logosplash.png', 
                width: 250, 
                height: 250,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min, 
              children: [
                const SizedBox(height: 20),
                if (_showLoading) 
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(_dotCount, (index) {
                      return Opacity(
                        opacity: _dotOpacity[index],
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4.0),
                          width: 10.0,
                          height: 10.0,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                      );
                    }),
                  ),
                if (_showLoading) 
                  Column(
                    children: [
                      const SizedBox(height: 20), 
                      AnimatedOpacity(
                        opacity: _showLoading ? 1.0 : 0.0,
                        duration: const Duration(milliseconds: 600),
                        child: Image.asset(
                          'assets/images/splash2.png',
                          width: 100,
                          height: 100,
                        ),
                      ),
                    ],
                  ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
