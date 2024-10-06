import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import './routes/app_routes.dart';
import 'marker_data.dart'; 

class MapScreen extends StatefulWidget {
  final List<MarkerData> markers; // Recibe la lista de marcadores

  const MapScreen({super.key, required this.markers}); // Asegúrate de que esta importación sea correcta

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Position? _currentPosition;
  final MapController _mapController = MapController();
  bool _isMapReady = false;
  List<String> _suggestions = [];
  String _searchQuery = '';
  bool _isLegendExpanded = false; // Controla si la leyenda está expandida

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Los servicios de ubicación están deshabilitados.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Permiso de ubicación denegado.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Los permisos de ubicación están permanentemente denegados.');
    }

    _currentPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    setState(() {
      _isMapReady = true; // Marca el mapa como listo
    });
  }

  Future<void> _searchPlaces(String query) async {
    try {
      if (query.isNotEmpty) {
        List<Location> locations = await locationFromAddress(query);

        if (locations.isNotEmpty) {
          setState(() {
            _suggestions = locations.map((loc) => loc.toString()).toList(); // Muestra el nombre de la ubicación
          });

          final firstLocation = locations.first;
          _mapController.move(LatLng(firstLocation.latitude, firstLocation.longitude), 13.0);
        } else {
          setState(() {
            _suggestions = ['No se encontraron resultados para "$query"'];
          });
        }
      }
    } catch (e) {
      setState(() {
        _suggestions = ['Error al buscar la ubicación: ${e.toString()}'];
      });
    }
  }

void _showPlaceInfo(LatLng point, String title) {
  final marker = widget.markers.firstWhere((m) => m.title == title);

  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              marker.title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Image.asset(marker.image, height: 100),
            SizedBox(height: 10),
            Text('Latitude: ${point.latitude}'),
            Text('Longitude: ${point.longitude}'),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  AppRoutes.moreInfo,
                  arguments: {
                    'title': marker.title,
                    'latitude': point.latitude,
                    'longitude': point.longitude,
                    'description': marker.description,
                    'image': marker.image,
                    'pastImage': marker.pastImage, 
                    'futureImage': marker.futureImage, 
                    'howtoavoid': marker.howtoavoid,
                  },
                );
              },
              child: Text('More Information'),
            ),
          ],
        ),
      );
    },
  );
}

  void _showInfoDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Tip for Using the Map'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text('1. Try moving around the map if it does not  load'),
                Text('2. Do not click on locations before the map loads.'),
                Text('3. Verify that the location is allowed in the settings.'),
                Text('4. Click on the circle inside the location icons, and it will display the information.'),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
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
      title: const Text(
        'World Map',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      backgroundColor: const Color(0xFF3F22BA),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    ),
    body: Stack(
      children: [
        _currentPosition == null || !_isMapReady
            ? const Center(child: CircularProgressIndicator())
            : FlutterMap(
                mapController: _mapController,
                options: MapOptions(
                  onMapReady: () {
                    if (_currentPosition != null) {
                      _mapController.move(
                        LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
                        15.0,
                      );
                    }
                  },
                  onTap: (tapPosition, point) {
                    print('Tapped on: $point');
                  },
                ),
                children: [
                  TileLayer(
                    urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  ),
                  MarkerLayer(
                    markers: [
                      ...widget.markers.map((marker) => Marker(
                        point: marker.position,
                        width: 20,
                        height: 20,
                        child: GestureDetector(
                          onTap: () => _showPlaceInfo(marker.position, marker.title),
                          child: const Icon(Icons.location_on, color: Colors.red, size: 40),
                        ),
                      )),
                      if (_currentPosition != null)
                        Marker(
                          point: LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
                          width: 20,
                          height: 20,
                          child: const Icon(Icons.circle, color: Color.fromARGB(131, 39, 2, 107), size: 30),
                        ),
                    ],
                  ),
                ],
              ),
        Positioned(
          bottom: 20,
          left: 20,
          right: 20,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 3,
                  blurRadius: 7,
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Search for a place...',
                      border: InputBorder.none,
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {
                          _searchPlaces(_searchQuery);
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (_suggestions.isNotEmpty)
          Positioned(
            top: 100,
            left: 20,
            right: 20,
            child: Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(8),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                child: Column(
                  children: _suggestions.map((suggestion) {
                    return ListTile(
                      title: Text(suggestion),
                      onTap: () {
                        final coords = suggestion.split(', ');
                        if (coords.length == 2) {
                          final latitude = double.tryParse(coords[0]);
                          final longitude = double.tryParse(coords[1]);
                          if (latitude != null && longitude != null) {
                            _mapController.move(LatLng(latitude, longitude), 15.0);
                            setState(() {
                              _searchQuery = ''; // Limpiar el campo de búsqueda
                              _suggestions.clear(); // Limpiar las sugerencias
                            });
                          }
                        }
                      },
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        Positioned(
          top: 20,
          right: 20,
          child: GestureDetector(
            onTap: () {
              _showInfoDialog(); // Llama a la función para mostrar la información
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              color: Colors.white,
              child: const Icon(Icons.info, color: Colors.black), // Botón de información
            ),
          ),
        ),
        Positioned(
          top: 20,
          right: 80, // Ajusta la posición para que no se superponga
          child: GestureDetector(
            onTap: () {
              setState(() {
                _isLegendExpanded = !_isLegendExpanded;
              });
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              color: Colors.white,
              child: Row(
                children: [
                  Text("Markers: ${widget.markers.length}"),
                  Icon(_isLegendExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down),
                ],
              ),
            ),
          ),
        ),
        if (_isLegendExpanded)
          Positioned(
            top: 70,
            right: 20,
            child: Container(
              width: 200,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 3,
                    blurRadius: 7,
                  ),
                ],
              ),
              child: Column(
                children: widget.markers.map((marker) {
                  return ListTile(
                    title: Text(marker.title),
                    onTap: () {
                      _mapController.move(marker.position, 15.0);
                      setState(() {
                        _isLegendExpanded = false;
                      });
                    },
                  );
                }).toList(),
              ),
            ),
          ),
      ],
    ),
  );
}
}