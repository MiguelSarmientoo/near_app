import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class MumbaiARScreen extends StatefulWidget {
  const MumbaiARScreen({super.key});

  @override
  _MumbaiARScreenState createState() => _MumbaiARScreenState();
}

class _MumbaiARScreenState extends State<MumbaiARScreen> {
  late CameraController cameraController;
  late Future<void> _initializeControllerFuture;

  // Current image path
  String currentImage = 'assets/images/mumbai.png'; // Default image for the park

  // List of dynamically added points with their information
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
        title: const Text('Sanjay Gandhi National Park AR Model'),
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
          // Center image of Sanjay Gandhi National Park
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
                      'assets/images/mumbai_past.png', // Image for Past
                      Offset(100, 300), // Set the desired position for the dot
                      'Past: The park was once an expansive forest and wildlife habitat, but urban development has encroached on its boundaries.',
                    );
                  },
                  child: const Text('Past'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _updateImageAndAddDot(
                      'assets/images/mumbai.png', // Image for Present
                      Offset(200, 330), // Set the desired position for the dot
                      'Present: SGNP currently serves as a crucial green lung for Mumbai, providing habitat for diverse flora and fauna amidst urban chaos.',
                    );
                  },
                  child: const Text('Present'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _updateImageAndAddDot(
                      'assets/images/mumbai_future.png', // Image for Future
                      Offset(250, 300), // Set the desired position for the dot
                      'Future: With conservation efforts, SGNP is predicted to maintain its ecological balance and enhance urban biodiversity. With out conservation effects the park will become dry',
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
