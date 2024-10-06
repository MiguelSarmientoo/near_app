import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class ColombiaARScreen extends StatefulWidget {
  const ColombiaARScreen({super.key});

  @override
  _ColombiaARScreenState createState() => _ColombiaARScreenState();
}

class _ColombiaARScreenState extends State<ColombiaARScreen> {
  late CameraController cameraController;
  late Future<void> _initializeControllerFuture;

  // Default image path
  String currentImage = 'assets/images/colombia.png'; // Default image for Colombia

  // List of points with Monserrate facts
  List<Map<String, dynamic>> points = [];

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

  // Function to update the image and add a new point (clear previous points)
  void _updateImageAndAddDot(String imagePath, Offset position, String info) {
    setState(() {
      // Clear previous points (remove previous dots)
      points.clear();
      currentImage = imagePath;
      points.add({
        'position': position,
        'info': info,
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Colombia AR Model'),
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
          // Center image of Monserrate
          Center(
            child: Image.asset(
              currentImage,
              width: 350,
              height: 350,
              fit: BoxFit.contain,
            ),
          ),
          // Display dynamic red dots
          ...points.map((point) {
            return Positioned(
              left: point['position'].dx,
              top: point['position'].dy,
              child: GestureDetector(
                onTap: () {
                  _showInfoDialog(context, point['info']);
                },
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            );
          }).toList(),
          Positioned(
            bottom: 70,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _updateImageAndAddDot(
                      'assets/images/mon_past.png', // Image for the past
                      Offset(100, 300), // Position for the dot
                      'Past: Monserrate has been a sacred place for centuries, revered by Indigenous people long before the Spanish arrived, serving as a spiritual and cultural landmark.',
                    );
                  },
                  child: const Text('Past'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _updateImageAndAddDot(
                      'assets/images/mon.png', // Image for the present
                      Offset(200, 330), // Position for the dot
                      'Present: Today, Monserrate is a popular pilgrimage and tourist destination, offering panoramic views of Bogotá and showcasing its rich history and culture.',
                    );
                  },
                  child: const Text('Present'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _updateImageAndAddDot(
                      'assets/images/mon_future.png', // Image for the future
                      Offset(250, 300), // Position for the dot
                      'Future: Continued development and tourism could enhance Monserrate’s accessibility, but it is crucial to balance modernization with the preservation of its cultural heritage.',
                    );
                  },
                  child: const Text('Future'),
                ),
              ],
            ),
          ),
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