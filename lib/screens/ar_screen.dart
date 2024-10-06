import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_cube/flutter_cube.dart';

class ARScreen extends StatefulWidget {
  const ARScreen({super.key});

  @override
  _ARScreenState createState() => _ARScreenState();
}

class _ARScreenState extends State<ARScreen> {
  late CameraController cameraController;
  late Future<void> _initializeControllerFuture;

  // List of points with their information
  final List<Map<String, dynamic>> points = [
    {
      'position': Offset(100, 200), // x, y coordinates
      'info': 'Point 1: This is some information about Point 1.',
    },
    {
      'position': Offset(200, 300), // x, y coordinates
      'info': 'Point 2: This is some information about Point 2.',
    },
    // Add more points as needed
  ];

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    // Get the list of available cameras
    final cameras = await availableCameras();
    // Select the rear camera
    final camera = cameras.first;

    cameraController = CameraController(
      camera,
      ResolutionPreset.high,
    );

    // Initialize the camera controller
    _initializeControllerFuture = cameraController.initialize();
    setState(() {});
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  // Function to show a dialog with information
  void _showInfoDialog(BuildContext context, String info) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Information'),
          content: Text(info),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AR Model View'),
        backgroundColor: const Color.fromARGB(255, 61, 18, 162),
      ),
      body: Stack(
        children: [
          FutureBuilder<void>(
            future: _initializeControllerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                // Camera is ready, show the camera preview
                return CameraPreview(cameraController);
              } else {
                // Show a loading indicator while the camera initializes
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
          // Overlay clickable points
          ...points.map((point) {
            return Positioned(
              left: point['position'].dx,
              top: point['position'].dy,
              child: GestureDetector(
                onTap: () {
                  _showInfoDialog(context, point['info']);
                },
                child: Container(
                  width: 20, // Size of the clickable point
                  height: 20, // Size of the clickable point
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            );
          }).toList(),
          // Add 3D model
          Positioned(
            left: 100, // Adjust this value to position your 3D model
            top: 100, // Adjust this value to position your 3D model
            child: SizedBox(
              width: 150, // Adjust the size of the 3D model
              height: 150, // Adjust the size of the 3D model
              child: Cube(
                onSceneCreated: (Scene scene) {
                  scene.world.add(Object(
                    fileName: 'assets/images/Globe.obj', // Update with your model's path
                    scale: Vector3(1.0, 1.0, 1.0), // Adjust scale as needed
                    position: Vector3(0.0, 0.0, 0.0), // Center the model in the scene
                  ));
                },
              ),
            ),
          ),
          // Text at the bottom
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: const Text(
              'Tap on the red dots for more information!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
