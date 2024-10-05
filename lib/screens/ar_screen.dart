import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class ARScreen extends StatefulWidget {
  const ARScreen({super.key});

  @override
  _ARScreenState createState() => _ARScreenState();
}

class _ARScreenState extends State<ARScreen> {
  late CameraController cameraController;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    // Obtén la lista de cámaras disponibles en el dispositivo
    final cameras = await availableCameras();
    // Selecciona la cámara trasera
    final camera = cameras.first;

    cameraController = CameraController(
      camera,
      ResolutionPreset.high,
    );

    // Inicializa el controlador de la cámara
    _initializeControllerFuture = cameraController.initialize();
    setState(() {});
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Camera View'),
        backgroundColor: const Color.fromARGB(255, 61, 18, 162),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<void>(
              future: _initializeControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  // La cámara está lista, muestra la vista de la cámara
                  return CameraPreview(cameraController);
                } else {
                  // Muestra un indicador de carga mientras la cámara se inicializa
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'Welcome to the Camera Experience!',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Text(
                  'Here you can explore the camera features.',
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
