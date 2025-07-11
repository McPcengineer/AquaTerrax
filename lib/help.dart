import 'package:aquaterrax/Recompensas.dart';
import 'package:aquaterrax/Reportes.dart';
import 'package:aquaterrax/games.dart';
import 'package:aquaterrax/main.dart';
import 'package:aquaterrax/map.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HelpPage extends StatelessWidget {
  final List<Map<String, String>> recomendaciones = [
    {'titulo': 'Cuidado del Agua', 'imagen': 'assets/agua.jpg', 'descripcion': 'El agua es un recurso esencial para la vida, pero está siendo desperdiciado y contaminado a un ritmo alarmante. En casa, puedes hacer una gran diferencia con simples cambios en tu rutina diaria. Cierra el grifo mientras te cepillas los dientes, repara las fugas lo antes posible y utiliza dispositivos ahorradores de agua, como cabezales de ducha de bajo consumo. También puedes recolectar agua de lluvia para regar plantas y jardines, o instalar sistemas de reutilización de aguas grises en tu hogar. Recuerda que cada gota cuenta, y al ser consciente de tu uso de agua, estás contribuyendo a la conservación de este valioso recurso para las generaciones futuras.'},
    {'titulo': 'Plantar Árboles', 'imagen': 'assets/arboles.jpg', 'descripcion': 'Los árboles son los pulmones de nuestro planeta. Absorben dióxido de carbono (CO2), el principal gas de efecto invernadero responsable del cambio climático, y liberan oxígeno al aire. Al plantar árboles en tu jardín, comunidad o áreas verdes, estás contribuyendo directamente a la lucha contra el calentamiento global. Además, los árboles proporcionan sombra, ayudan a conservar la energía y mejoran la calidad del aire. Participar en campañas de reforestación o crear pequeños huertos en casa también son maneras efectivas de contribuir a la conservación ambiental. Recuerda, cada árbol plantado es una inversión en el futuro del planeta.'},
    {'titulo': 'Reciclar', 'imagen': 'assets/reciclar.jpg', 'descripcion': 'El reciclaje es una de las acciones más simples y efectivas que puedes realizar para reducir tu impacto en el medio ambiente. En casa, puedes empezar separando los residuos en categorías como plástico, vidrio, papel y orgánicos. Reciclar no solo ayuda a reducir la cantidad de residuos que terminan en los vertederos, sino que también ahorra energía y recursos naturales. Al reutilizar materiales y reducir el consumo de productos desechables, estás disminuyendo la demanda de materias primas y ayudando a reducir la contaminación que se genera en su producción. ¡Reciclar es un pequeño esfuerzo con grandes beneficios para el planeta!'},
    {'titulo': 'Evitar Plásticos', 'imagen': 'assets/plastico.jpg', 'descripcion': 'El plástico es uno de los mayores contaminantes de nuestro tiempo. Cada año, millones de toneladas de plástico terminan en los océanos, afectando a la vida marina y contaminando nuestros ecosistemas. Una forma sencilla de ayudar es evitar el uso de plásticos de un solo uso, como bolsas, botellas y pajillas. Opta por alternativas reutilizables como bolsas de tela, botellas de agua de acero inoxidable o vidrio, y envases de alimentos reutilizables. También es importante ser consciente al comprar productos y elegir aquellos que tengan menos empaque plástico o que utilicen materiales reciclables. Cada acción para reducir el uso de plástico ayuda a proteger la vida silvestre y el medio ambiente.'},
    {'titulo': 'Cuidado de la Biodiversidad', 'imagen': 'assets/biodiversidad.jpg', 'descripcion': 'La biodiversidad es esencial para el equilibrio de los ecosistemas y la supervivencia de todas las especies, incluyéndonos a nosotros. Sin embargo, las actividades humanas están destruyendo hábitats naturales a una velocidad sin precedentes. Desde casa, puedes contribuir al cuidado de la biodiversidad de varias maneras. Evita el uso de productos químicos y pesticidas en tu jardín, y planta especies nativas que favorezcan a los polinizadores, como las abejas y las mariposas. Participa en la conservación de especies en peligro apoyando organizaciones dedicadas a este fin, o incluso siendo voluntario en campañas de protección animal. Al proteger la flora y fauna local, estamos preservando la riqueza natural del planeta para las futuras generaciones.'},

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
                  _buildActionButton(context, 'Juegos'),
                  _buildActionButton(context, 'Cómo Ayudar', isSelected: true), // Indicar que esta opción es la seleccionada
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
            // Grid de recomendaciones
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 1,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              padding: EdgeInsets.all(16.0),
              itemCount: recomendaciones.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    _mostrarDetallesRecomendacion(context, recomendaciones[index]);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                        image: AssetImage(recomendaciones[index]['imagen']!),
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
                          recomendaciones[index]['titulo']!,
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
            // Footer
            _buildFooter(),
          ],
        ),
      ),
      bottomNavigationBar: null,
    );
  }

  void _goToHome(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyApp()),
    );
  }

  void _mostrarDetallesRecomendacion(BuildContext context, Map<String, String> recomendacion) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(
          recomendacion['titulo']!,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start, 
            children: [
             
              Row(
                mainAxisAlignment: MainAxisAlignment.center, 
                children: [
                  
                  Image.asset(
                    recomendacion['imagen']!,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(width: 10),
                  
                  Expanded(
                    child: Text(
                      recomendacion['descripcion']!,
                      textAlign: TextAlign.justify,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          Center(
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cerrar',
                style: TextStyle(fontSize: 18),
              ),
            ),
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
                   
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black87,
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
}