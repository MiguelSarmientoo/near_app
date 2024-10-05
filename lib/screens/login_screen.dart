import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Importar el paquete
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Usuario y contraseña estáticos
  final String staticEmail = 'miguel.sarmiento@gmail.com';
  final String staticPassword = 'password';

  // Controladores para obtener los datos ingresados por el usuario
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _checkLoginStatus(); // Verificar si ya está logueado
  }

  // Método para manejar el login
  void _login() async {
    String email = emailController.text;
    String password = passwordController.text;

    // Validar las credenciales estáticas
    if (email == staticEmail && password == staticPassword) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true); // Guardar el estado de login
      await prefs.setString('userEmail', email); // Guardar el email del usuario

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Incorrect credentials'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // Método para verificar si el usuario ya está logueado
  void _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Imagen de fondo
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/planet.png'), // Cambia a la ruta de tu imagen de fondo
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Filtro de oscuridad
          Container(
            color: Colors.black54, // Color negro con opacidad
          ),
          // Contenido de la pantalla
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    // Logo
                    Image.asset(
                      'assets/images/logo2.png', // Ruta de tu logo
                      height: 120,
                    ),
                    SizedBox(height: 10),

                    // Título
                    Text(
                      'Welcome to NE-AR',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 30),

                    // Campo de Email
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(color: Colors.white),
                        filled: true,
                        fillColor: Colors.white24,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        prefixIcon: Icon(Icons.email, color: Colors.white),
                      ),
                      style: TextStyle(color: Colors.white),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 20),

                    // Campo de Contraseña
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(color: Colors.white),
                        filled: true,
                        fillColor: Colors.white24,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        prefixIcon: Icon(Icons.lock, color: Colors.white),
                      ),
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(height: 40),

                    // Botón de Login
                    ElevatedButton(
                      onPressed: _login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        'Login',
                        style: TextStyle(
                          color: Color(0xFF4725F3),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
