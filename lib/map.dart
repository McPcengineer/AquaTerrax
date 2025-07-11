import 'package:aquaterrax/Recompensas.dart';
import 'package:aquaterrax/Reportes.dart';
import 'package:aquaterrax/games.dart';
import 'package:aquaterrax/help.dart';
import 'package:aquaterrax/main.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late GoogleMapController mapController;
  final LatLng _center = const LatLng(20.6574, -101.3563); 

 
  final Set<Polygon> _contaminatedZones = {
    Polygon(
      polygonId: PolygonId('contaminatedZone1'),
      points: [
        LatLng(20.658, -101.355),
        LatLng(20.658, -101.358),
        LatLng(20.655, -101.358),
        LatLng(20.655, -101.355),
      ],
      fillColor: Colors.red.withOpacity(0.4), 
      strokeColor: Colors.red,
      strokeWidth: 3,
    ),
  };

  
  final Set<Polygon> _nonContaminatedZones = {
    Polygon(
      polygonId: PolygonId('nonContaminatedZone1'),
      points: [
        LatLng(20.660, -101.360),
        LatLng(20.660, -101.362),
        LatLng(20.658, -101.362),
        LatLng(20.658, -101.360),
      ],
      fillColor: Colors.green.withOpacity(0.4),
      strokeColor: Colors.green,
      strokeWidth: 3,
    ),
  };

  String? _contaminatedZoneName;
  String? _nonContaminatedZoneName;

  @override
  void initState() {
    super.initState();
    _getPlaceNames();
  }

  void _getPlaceNames() async {
    try {
     
      List<Placemark> contaminatedPlacemarks = await placemarkFromCoordinates(20.6565, -101.3565);
      if (contaminatedPlacemarks.isNotEmpty) {
        setState(() {
          _contaminatedZoneName = "${contaminatedPlacemarks[0].locality}, ${contaminatedPlacemarks[0].country}";
        });
      }

    
      List<Placemark> nonContaminatedPlacemarks = await placemarkFromCoordinates(20.659, -101.361);
      if (nonContaminatedPlacemarks.isNotEmpty) {
        setState(() {
          _nonContaminatedZoneName = "${nonContaminatedPlacemarks[0].locality}, ${nonContaminatedPlacemarks[0].country}";
        });
      }
    } catch (e) {
      print("Error al obtener nombres de lugares: $e");
    
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      backgroundColor: Colors.lightGreen[200],
      elevation: 0,
      toolbarHeight: 100,
      automaticallyImplyLeading: false,

      title: Row(
        children: [
          GestureDetector(
              onTap: () => _goToHome(context),

              child: Image.asset(
                 'assets/AquaTerraxx.png',
                height: 130,
              ),
            ),
          SizedBox(width: 5),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _buildActionButton(context, 'Mapa' , isSelected: true),
                _buildActionButton(context, 'Reportes'),
                _buildActionButton(context, 'Recompensas'),
                _buildActionButton(context, 'Juegos') ,
                _buildActionButton(context, 'Cómo Ayudar'),
                _buildActionButton(context, 'Contactos'),
              ],
            ),
          ),
        ],
      ),
    ),
      body: Row(
        children: [
          Expanded(
            flex: 3,
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 14.0,
              ),
              polygons: _contaminatedZones.union(_nonContaminatedZones),
            ),
          ),
          Expanded(
            flex: 1,
            child: _buildSidebar(),
          ),
        ],
      ),
    );
  }

   void _goToHome(BuildContext context) {
  Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MyApp()),
          );
}


 Widget _buildActionButton(BuildContext context, String label, {bool isSelected = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: TextButton(
        onPressed: () {
          if (label == 'Juegos') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => JuegosPage()),
            );
          } else if (label == 'Cómo Ayudar') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HelpPage()),
            );
          } else if (label == 'Mapa') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MapPage()),
            );
          } else if (label == 'Recompensas') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RecompensasPage()),
            );
          } else if (label == 'Reportes') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ReportesPage()),
            );
          }
         
        },
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.blue : Colors.black, 
            fontSize: 22,
          ),
        ),
      ),
    );
  }


  Widget _buildSidebar() {
    return Container(
      padding: EdgeInsets.all(16.0),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Zonas Contaminadas:',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red),
          ),
          ListTile(
            title: Text(_contaminatedZoneName ?? 'Cargando...', style: TextStyle(color: Colors.red)),
          ),
          Divider(),
          Text(
            'Zonas No Contaminadas:',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green),
          ),
          ListTile(
            title: Text(_nonContaminatedZoneName ?? 'Cargando...', style: TextStyle(color: Colors.green)),
          ),
        ],
      ),
    );
  }
}
