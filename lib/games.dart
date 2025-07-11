

import 'package:aquaterrax/PlantWateringGame.dart';
import 'package:aquaterrax/Recompensas.dart';
import 'package:aquaterrax/Reportes.dart';
import 'package:aquaterrax/TrashCollectingGame.dart';
import 'package:aquaterrax/help.dart';
import 'package:aquaterrax/main.dart';
import 'package:aquaterrax/map.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class JuegosPage extends StatelessWidget {
  final List<Map<String, String>> juegos = [
    {'nombre': 'Juego 1', 'imagen': 'assets/juego1.jpg', 'descripcion': 'Descripción del Juego 1'},
    {'nombre': 'EcoHéroes', 'imagen': 'assets/juego2.jpg', 'descripcion': '¡Únete a la aventura de EcoHéroes! En este divertido y educativo juego, los niños aprenderán sobre la importancia de cuidar nuestro planeta mientras se convierten en verdaderos guardianes del medio ambiente. Tu misión es recoger la basura que encuentras en las calles y depositarla en el bote de basura. Cada vez que recojas un desecho, recibirás un sonido de felicitación y verás cómo tu puntaje aumenta. ¡Pero eso no es todo! Una vez que hayas recogido toda la basura, serás recompensado con una emocionante celebración y podrás aprender más sobre cómo proteger nuestra Tierra. ¿Estás listo para hacer del mundo un lugar más limpio y hermoso? ¡Juega ahora y conviértete en un EcoHéroe!'},
    {'nombre': 'AquaGardens: La Aventura de Riego', 'imagen': 'assets/juego3.jpg', 'descripcion': 'Es un juego educativo donde los niños se convierten en pequeños jardineros responsables. En un mundo colorido lleno de plantas sedientas, los jugadores deben moverse y regar cada planta para ayudarlas a crecer y prosperar. Con controles simples y gráficos vibrantes, este juego es perfecto para niños de todas las edades.'},
    {'nombre': 'Juego 4', 'imagen': 'assets/juego4.jpg', 'descripcion': 'Descripción del Juego 4'},
    {'nombre': 'Juego 5', 'imagen': 'assets/juego5.jpg', 'descripcion': 'Descripción del Juego 5'},
    {'nombre': 'Juego 6', 'imagen': 'assets/juego6.jpg', 'descripcion': 'Descripción del Juego 6'},
  ];

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
               _buildActionButton(context, 'Mapa'),
                _buildActionButton(context, 'Reportes'),
                _buildActionButton(context, 'Recompensas'),
                _buildActionButton(context, 'Juegos', isSelected: true),
                _buildActionButton(context, 'Cómo Ayudar'),
                _buildActionButton(context, 'Contactos'),
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
            padding: EdgeInsets.all(16.0),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,  // Dos cuadros por fila
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: juegos.length,
              shrinkWrap: true, 
              physics: NeverScrollableScrollPhysics(), 
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    _mostrarDetallesJuego(context, juegos[index]);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                        image: AssetImage(juegos[index]['imagen']!),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        
                      decoration: BoxDecoration(
            color: Colors.black54, 
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(5), top: Radius.circular(5)), // Esquinas redondeadas en la parte inferior
          ),
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          juegos[index]['nombre']!,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          _buildFooter(), 
        ],
      ),
    ),
  );
}

void _goToHome(BuildContext context) {
  Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MyApp()),
          );
}



  void _mostrarDetallesJuego(BuildContext context, Map<String, String> juego) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(juego['nombre']!),
        content: SingleChildScrollView( // Hacer el contenido desplazable
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                juego['imagen']!,
                height: 300, // Ajusta la altura de la imagen
                fit: BoxFit.cover, // Ajustar la imagen
              ),
              SizedBox(height: 20),
              Text(juego['descripcion']!),
            ],
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
               if (juego['nombre'] == 'AquaGardens: La Aventura de Riego') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GameWidget(game: PlantWateringGame(context))),
                  );
                } else if (juego['nombre'] == 'EcoHéroes') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => GameWidget(game: TrashCollectingGame(context))),
                      );
                }
                else {
                  Navigator.of(context).pop(); 
                }
              },
            child: Text('Jugar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cerrar'),
          ),
        ],
      );
    },
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