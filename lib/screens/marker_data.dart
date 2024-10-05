import 'package:latlong2/latlong.dart';

class MarkerData {
  final String title;
  final LatLng position;
  final String description;
  final String image; 

  MarkerData({
    required this.title, 
    required this.position, 
    required this.description, 
    required this.image,
  });
}

final List<MarkerData> markers = [
  MarkerData(
    title: 'Mumbai',
    position: LatLng(19.0760, 72.8777),
    description: 'Mumbai enfrenta riesgos de inundaciones debido al aumento del nivel del mar y patrones climáticos cambiantes.',
    image: 'assets/images/mumbai.jpg', // Añade la ruta de la imagen
  ),
  MarkerData(
    title: 'Madagascar',
    position: LatLng(-18.7669, 46.8691),
    description: 'Madagascar está experimentando sequías y la pérdida de biodiversidad debido al cambio climático.',
    image: 'assets/images/madagascar.jpg', // Añade la ruta de la imagen
  ),
  MarkerData(
    title: 'Colombia',
    position: LatLng(4.5709, -74.2973),
    description: 'Colombia enfrenta deforestación y pérdida de hábitats, lo que afecta su biodiversidad.',
    image: 'assets/images/colombia.jpg', // Añade la ruta de la imagen
  ),
  MarkerData(
    title: 'Coconut Creek',
    position: LatLng(26.2518, -80.1789),
    description: 'Coconut Creek está en riesgo de huracanes más intensos y cambios en el clima local.',
    image: 'assets/images/coconut_creek.jpeg', // Añade la ruta de la imagen
  ),
  MarkerData(
    title: 'Lima, Peru',
    position: LatLng(-12.0464, -77.0428),
    description: 'Lima enfrenta escasez de agua y sequías debido al cambio climático.',
    image: 'assets/images/lima_peru.jpg', // Añade la ruta de la imagen
  ),
];
