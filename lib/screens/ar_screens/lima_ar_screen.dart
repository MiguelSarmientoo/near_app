import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class LimaARScreen extends StatefulWidget {
  const LimaARScreen({super.key});

  @override
  _LimaARScreenState createState() => _LimaARScreenState();
}

class _LimaARScreenState extends State<LimaARScreen> {
  late CameraController cameraController;
  late Future<void> _initializeControllerFuture;

  // List of points with information about Andes Mountain
  final List<Map<String, dynamic>> points = [
    {
      'position': Offset(150, 300), // x, y coordinates
      'info': 'Fact 1: The Andes Mountain range is the longest continental mountain range in the world.',
    },
    {
      'position': Offset(200, 350), // x, y coordinates
      'info': 'Fact 2: The Andes spans seven countries, including Argentina, Chile, and Peru.',
    },
    {
      'position': Offset(250, 400), // x, y coordinates
      'info': 'Fact 3: The highest peak in the Andes is Mount Aconcagua, standing at 6,959 meters.',
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
        title: const Text('Andes Mountain AR Model'),
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
          // Center image of the Andes Mountains, using the same image 'lima.png'
          Center(
            child: Image.asset(
              'assets/images/lima.png', // Keeping the same image path as per your request
              width: 350, // Adjust the size as needed
              height: 350, // Adjust the size as needed
              fit: BoxFit.contain, // Maintain aspect ratio
            ),
          ),
          // Overlay clickable points on the image
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
