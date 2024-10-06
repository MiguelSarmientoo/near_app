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

  // Current image path
  String currentImage = 'assets/images/glacieri.png';

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

  // Function to update the image and add a new red dot (clear previous dots)
  void _updateImageAndAddDot(String imagePath, Offset position, String info) {
    setState(() {
      // Clear previous points (remove previous dot)
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
          // Center image based on the selected timeline
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
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      _updateImageAndAddDot(
                        'assets/images/1920glacier.png',
                        Offset(150, 300), // Set the desired position for the dot
                        'Past: Pedersen Glacier once extended into the lagoon, a massive ice field in the early 20th century.',
                      );
                    },
                    child: const Text('1920'),
                  ),
                ),
                const SizedBox(width: 10), // Space between buttons
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      _updateImageAndAddDot(
                        'assets/images/2005glacier.png',
                        Offset(200, 350), // Set the desired position for the dot
                        'Past: Pedersen Glacier once extended into the lagoon, a massive ice field in the early 20th century.',
                      );
                    },
                    child: const Text('2005'),
                  ),
                ),
                const SizedBox(width: 10), // Space between buttons
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      _updateImageAndAddDot(
                        'assets/images/futureglacier.png',
                        Offset(250, 400), // Set the desired position for the dot
                        'Future: Predicted to continue shrinking, possibly disappearing, affecting freshwater and ecosystems in the region.',
                      );
                    },
                    child: const Text('Future'),
                  ),
                ),
                const SizedBox(width: 10), // Space between buttons
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      _updateImageAndAddDot(
                        'assets/images/glacieri.png',
                        Offset(200, 350), // Set the desired position for the dot
                        'Present: Rapidly retreating, with much of the glacier melted, leaving exposed land and an ice-free lagoon.',
                      );
                    },
                    child: const Text('Now'),
                  ),
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
