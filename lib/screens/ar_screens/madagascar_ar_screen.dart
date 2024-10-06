import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class MadagascarARScreen extends StatefulWidget {
  const MadagascarARScreen({super.key});

  @override
  _MadagascarARScreenState createState() => _MadagascarARScreenState();
}

class _MadagascarARScreenState extends State<MadagascarARScreen> {
  late CameraController cameraController;
  late Future<void> _initializeControllerFuture;

  // Current image path
  String currentImage = 'assets/images/mad.png'; // Default image for Madagascar

  // List of points with facts about Tsaranoro Massif
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
        title: const Text('Tsaranoro Massif AR Model'),
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
          // Center image
          Center(
            child: Image.asset(
              currentImage,
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
          // Bottom buttons for Past, Present, Future
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
                      'assets/images/mad_past.png', // Image for Past
                      Offset(150, 300), // Set the desired position for the dot
                      'Past: Tsaranoro Massif has long been a sacred site for the local Betsileo people, rich in cultural heritage.',
                    );
                  },
                  child: const Text('Past'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _updateImageAndAddDot(
                      'assets/images/mad.png', // Image for Present
                      Offset(200, 300), // Set the desired position for the dot
                      'Present: Today, Tsaranoro Massif attracts climbers and tourists, boosting local tourism and economy.',
                    );
                  },
                  child: const Text('Present'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _updateImageAndAddDot(
                      'assets/images/mad_future.png', // Image for Future
                      Offset(250, 350), // Set the desired position for the dot
                      'Future: With increased conservation efforts, Tsaranoro is set to preserve its unique biodiversity and climbing opportunities.',
                    );
                  },
                  child: const Text('Future'),
                ),
              ],
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