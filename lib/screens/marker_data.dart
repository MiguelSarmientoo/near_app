import 'package:latlong2/latlong.dart';

class MarkerData {
  final String title;
  final LatLng position;
  final String description;
  final String image; // Imagen actual
  final String pastImage; // Imagen del pasado
  final String futureImage; // Imagen del futuro
  final String howtoavoid; // Cómo evitar el problema

  MarkerData({
    required this.title,
    required this.position,
    required this.description,
    required this.image,
    required this.pastImage,
    required this.futureImage,
    required this.howtoavoid,
  });
}

final List<MarkerData> markers = [
  MarkerData(
    title: 'Mumbai',
    position: LatLng(19.0760, 72.8777),
    description: 'Mumbai faces rising sea levels and severe flooding due to climate change, impacting its coastal infrastructure and public health. Intense rainfall has led to significant flooding, affecting millions of people and causing extensive property damage. 🌊🏙️',
    image: 'assets/images/mumbai.jpg',
    pastImage: 'assets/images/mumbai_past.jpg',
    futureImage: 'assets/images/mumbai_future.png',
    howtoavoid: 'To mitigate these risks, it is essential to implement an integrated approach that includes improving drainage systems and urban design. Authorities should invest in green infrastructure, such as parks and rooftop gardens, to absorb rainwater and reduce runoff. 🌱🏞️ Community involvement in restoring mangroves and coastal wetlands is crucial to protect the coast from future floods and enhance local biodiversity.',
  ),
  MarkerData(
    title: 'Madagascar',
    position: LatLng(-18.7669, 46.8691),
    description: 'Madagascar is experiencing intense droughts that affect agriculture and its rural population, while biodiversity loss endangers key ecosystems. Deforestation and changing land use patterns have led to habitat degradation and species extinction. 🌍🌾',
    image: 'assets/images/madagascar.jpg',
    pastImage: 'assets/images/madagascar_past.jpg',
    futureImage: 'assets/images/madagascar_future.jpg',
    howtoavoid: 'Promoting sustainable agricultural practices like crop rotation and agroecological techniques is crucial. Reforestation should be a priority, with initiatives involving local communities in planting and caring for native trees. 🌳💧 Establishing protected areas to safeguard endemic flora and fauna, along with creating incentives for conservation, will help recognize the vital role of biodiversity in human and economic well-being.',
  ),
  MarkerData(
    title: 'Colombia',
    position: LatLng(4.5709, -74.2973),
    description: 'Colombia faces high deforestation rates, impacting both its biodiversity and local climate, exacerbating the effects of climate change and habitat loss for numerous species. Illegal mining and agricultural expansion significantly contribute to this environmental crisis. 🌿🌋',
    image: 'assets/images/colombia.jpg',
    pastImage: 'assets/images/colombia_past.jpg',
    futureImage: 'assets/images/colombia_future.png',
    howtoavoid: 'Strengthening forest protection laws and ensuring compliance, especially in vulnerable areas, is vital. Community projects that value and promote ecotourism provide an alternative income source that reduces pressure on forests. 🏞️🌎 Education campaigns about reforestation and the importance of water conservation will help raise awareness of the natural resources and biodiversity Colombia has to offer.',
  ),
  MarkerData(
    title: 'Coconut Creek',
    position: LatLng(26.2518, -80.1789),
    description: 'Coconut Creek faces the risk of more frequent and intense hurricanes, along with rising temperatures, affecting local flora and fauna as well as residents’ safety. Unchecked urbanization has created areas vulnerable to flooding and landslides. 🌪️🏡',
    image: 'assets/images/coconut_creek.jpeg',
    pastImage: 'assets/images/coconut_creek_past.jpg',
    futureImage: 'assets/images/coconut_creek_future.jpeg',
    howtoavoid: 'Mitigation strategies should include creating green spaces and planting trees to act as natural barriers against hurricanes and storms. Implementing building codes that require materials and designs to withstand extreme weather events is essential. 🌳🚧 Community education on water management and emergency plans can make a significant difference in the community’s resilience to natural disasters.',
  ),
  MarkerData(
    title: 'Lima, Peru',
    position: LatLng(-12.0464, -77.0428),
    description: 'Lima faces severe water scarcity due to the retreat of Andean glaciers, impacting both drinking water supply and agriculture. Water pollution and inadequate resource management are critical issues that need addressing. 🚱🥦',
    image: 'assets/images/lima_peru.jpg',
    pastImage: 'assets/images/lima_peru_past.jpg',
    futureImage: 'assets/images/lima_peru_future.png',
    howtoavoid: 'To ensure a sustainable future, promoting efficient water management through rainwater harvesting and desalination technologies is essential. Government policies should focus on glacier conservation and protecting watersheds. 🌊🏞️ Raising awareness about responsible water use and developing drought-resistant crops will help communities adapt to new climate realities. Collaboration among governments, NGOs, and local communities will be key to ensuring proper and sustainable management of this vital resource.',
  ),
  MarkerData(
    title: 'Delhi',
    position: LatLng(28.6139, 77.2090),
    description: 'Delhi suffers from critical air pollution levels due to rapid urbanization, impacting the respiratory health of millions and reducing quality of life. Vehicle emissions, industrialization, and fossil fuel use are primary causes of this issue. 😷🏙️',
    image: 'assets/images/delhi.jpg',
    pastImage: 'assets/images/delhi_past.jpg',
    futureImage: 'assets/images/delhi_future.png',
    howtoavoid: 'To improve air quality in Delhi, it is essential to implement stricter emissions policies for industries and vehicles, as well as promote public transport and sustainable alternatives like cycling. 🚲🌳 Creating green spaces, such as urban parks and community gardens, will not only enhance air quality but also foster a sense of community. Awareness campaigns about environmental health and the use of air quality monitoring technologies will help keep the population informed about risks and actions they can take to mitigate pollution.',
  ),
];
