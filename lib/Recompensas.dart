import 'package:aquaterrax/Reportes.dart';
import 'package:aquaterrax/games.dart';
import 'package:aquaterrax/help.dart';
import 'package:aquaterrax/main.dart';
import 'package:aquaterrax/map.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RecompensasPage extends StatefulWidget {
  @override
  _RecompensasPageState createState() => _RecompensasPageState();
}

class _RecompensasPageState extends State<RecompensasPage> {
  final TextEditingController _usernameController = TextEditingController();

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.lightGreen[200],
      elevation: 0,
      toolbarHeight: 100,
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
                _buildActionButton(context, 'Recompensas', isSelected: true),
                _buildActionButton(context, 'Juegos'),
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
            color: Colors.lightGreen[100],
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _buildLoginButton(),
                    SizedBox(width: 16),
                    _buildSignupButton(),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '¡Únete a la conservación del agua y la tierra de Guanajuato!',
                              style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Por cada actividad que realices para combatir la contaminación del agua y la tierra, y que subas a este apartado, ganarás puntos y obtendrás recompensas.',
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Image.asset(
                          'assets/recompensas.png',
                          width: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Footer
          _buildFooter(),  
        ],
      ),
    ),
  );
}

 Widget _buildFooter() {
    return Container(
      color: Colors.grey[200],
      padding: EdgeInsets.all(20.0),
      child: Row(
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
                width: 200,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Tu dirección de correo',
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
                    // Lógica para suscribirse
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black87, // Color del botón
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.horizontal(right: Radius.circular(30)),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20),
                  ),
                  child: Text('Suscribirse', style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
              ),
            ],
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

  Widget _buildLoginButton() {
    return Container(
      width: 120,
      child: ElevatedButton(
        onPressed: () {
          _showLoginDialog();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.black,
        ),
        child: Text('Login', style: TextStyle(fontSize: 18)),
      ),
    );
  }

  Widget _buildSignupButton() {
    return Container(
      width: 120,
      child: ElevatedButton(
        onPressed: () {
          _showSignupDialog();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.black,
        ),
        child: Text('Signup', style: TextStyle(fontSize: 18)),
      ),
    );
  }

  void _showLoginDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(child: Text('Iniciar sesión')),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: 'Nombre de usuario o correo electrónico',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Contraseña',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
                TextButton(
                  onPressed: () {
                    
                  },
                  child: Text(
                    '¿Has olvidado tu contraseña?',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.black,
                  ),
                  child: Text('Iniciar sesión'),
                ),
                SizedBox(height: 10),
                Text('¿No tienes una cuenta?'),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _showSignupDialog();
                  },
                  child: Text(
                    'Registrarse',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancelar',
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showSignupDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(child: Text('Registrarse')),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Nombre de usuario',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Correo electrónico',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Contraseña',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 10),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Confirmar contraseña',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.black,
                  ),
                  child: Text('Registrarse'),
                ),
                SizedBox(height: 10),
                Text('¿Ya tienes una cuenta?'),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _showLoginDialog();
                  },
                  child: Text(
                    'Iniciar sesión',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancelar',
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        );
      },
    );
  }
}