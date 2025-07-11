import 'package:aquaterrax/Reportes.dart';
import 'package:aquaterrax/games.dart';
import 'package:aquaterrax/help.dart';
import 'package:aquaterrax/map.dart';
import 'package:aquaterrax/recompensas.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';




void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AquaTerraHome(),
    );
  }
}

class AquaTerraHome extends StatefulWidget {
  @override
  _AquaTerraHomeState createState() => _AquaTerraHomeState();
}

class _AquaTerraHomeState extends State<AquaTerraHome> {
  String _selectedMunicipio = 'San José Iturbide';

 @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.lightGreen[200],
      elevation: 0,
      toolbarHeight: 100,
      title: Row(
        children: [
          Image.asset(
            'assets/AquaTerraxx.png',
            height: 130,
          ),
          SizedBox(width: 5),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _buildActionButton('Mapa'),
                _buildActionButton('Reportes'),
                _buildActionButton('Recompensas'),
                _buildActionButton('Juegos') ,
                _buildActionButton('Cómo Ayudar'),
                _buildActionButton('Contactos'),
              ],
            ),
          ),
        ],
      ),
    ),
    body: SingleChildScrollView(
      child: Column(
        children: [
          Container(
            color: Colors.lightGreen[100],
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 60),
                            child: Text(
                              'Juntos, conservaremos \nel agua y la tierra en \nGuanajuato.',
                              style: TextStyle(
                                fontSize: 50,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.only(left: 60),
                            child: Row(
                              children: [
                                Text(
                                  'Selecciona tu municipio:',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.black87),
                                ),
                                SizedBox(width: 20),
                                Container(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 12),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                        offset: Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: DropdownButton<String>(
                                    value: _selectedMunicipio,
                                    items: <String>[
                                      'San José Iturbide',
                                      'León',
                                      'Irapuato',
                                      'Celaya',
                                    ].map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        _selectedMunicipio = newValue!;
                                      });
                                    },
                                    underline: SizedBox(),
                                    icon: Icon(Icons.arrow_drop_down,
                                        color: Colors.black87),
                                    style: TextStyle(
                                        color: Colors.black87, fontSize: 16),
                                    dropdownColor: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 600,
                      height: 400,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          'assets/Earth2.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          _buildFooter(),
        ],
      ),
    ),
  );
}


  
 Widget _buildActionButton(String label) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0),
    child: TextButton(
      onPressed: () {
        if (label == 'Juegos') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => JuegosPage()),
          );
        }
        else if(label == 'Cómo Ayudar') {
           Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HelpPage()),
          );
        }
         else if(label == 'Mapa') {
           Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MapPage()),
          );
        }
         else if(label == 'Recompensas') {
           Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RecompensasPage()),
          );
        }
         else if(label == 'Reportes') {
           Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ReportesPage()),
          );
        }
       
      },
      child: Text(
        label,
        style: TextStyle(
          color: Colors.black,
          fontSize: 22,
        ),
      ),
    ),
  );
}


  Widget _buildFooter() {
    return Container(
      color: Colors.grey[200],
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(color: Colors.grey),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            
              Row(
                children: [
                  Text('Síguenos', style: TextStyle(fontSize: 16)),
                  SizedBox(width: 20),
                  Icon(FontAwesomeIcons.facebook, color: Colors.black87),
                  SizedBox(width: 15),
                  Icon(FontAwesomeIcons.twitter, color: Colors.black87),
                  SizedBox(width: 15),
                  Icon(FontAwesomeIcons.instagram, color: Colors.black87),
                  SizedBox(width: 15),
                  Icon(FontAwesomeIcons.youtube, color: Colors.black87),
                ],
              ),
              
             Row(
  children: [
    Text('Suscríbete al correo', style: TextStyle(fontSize: 16)),
    SizedBox(width: 10),
    Container(
      width: 300, 
      decoration: BoxDecoration(
        borderRadius: BorderRadius.horizontal(left: Radius.circular(30)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),  
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Your email address',
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.horizontal(left: Radius.circular(30)),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    ),
    Container(
      height: 52,  
      child: ElevatedButton(
        onPressed: () {
        
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black87,  
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.horizontal(right: Radius.circular(30)),
          ),
          padding: EdgeInsets.symmetric(horizontal: 20),
        ),
        child: Text(
          'Subscribe',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    ),
  ],
),

            ],
          ),
          SizedBox(height: 10),
          Center(
            child: Text(
              'San José Iturbide, Guanajuato.\n© 2024 GreenWave Innovators. Todos los derechos reservados.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black54),
            ),
          ),
        ],
      ),
    );
  }
}