import 'package:aquaterrax/games.dart';
import 'package:aquaterrax/help.dart';
import 'package:aquaterrax/main.dart';
import 'package:aquaterrax/map.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:html' as html;
import 'recompensas.dart';

class ReportesPage extends StatefulWidget {
  @override
  _ReportesPageState createState() => _ReportesPageState();
}

class _ReportesPageState extends State<ReportesPage> {
  final TextEditingController _reportController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();
  List<Report> reports = [];
  List<String> _imageUrls = [];
  List<bool> _showComments = [];

  void _submitReport() {
    if (_reportController.text.isNotEmpty || _imageUrls.isNotEmpty) {
      setState(() {
        reports.add(Report(text: _reportController.text, imageUrls: _imageUrls));
        _reportController.clear();
        _imageUrls = [];
        _showComments.add(false);
      });
    }
  }

  void _pickImage() async {
    final uploadInput = html.FileUploadInputElement();
    uploadInput.accept = 'image/*';
    uploadInput.click();

    uploadInput.onChange.listen((e) {
      final file = uploadInput.files!.first;
      final reader = html.FileReader();

      reader.readAsDataUrl(file);
      reader.onLoadEnd.listen((e) {
        setState(() {
          _imageUrls.add(reader.result as String);
        });
      });
    });
  }

  void _likeReport(int index) {
    setState(() {
      reports[index].likes++;
    });
  }

  void _addComment(int reportIndex, String comment) {
    setState(() {
      reports[reportIndex].comments.add(comment);
      _commentController.clear();
    });
  }

  void _toggleComments(int index) {
    setState(() {
      _showComments[index] = !_showComments[index];
    });
  }

  void _showFullReport(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          insetPadding: EdgeInsets.all(10),
          contentPadding: EdgeInsets.zero,
          backgroundColor: Colors.white,
          content: Container(
            width: MediaQuery.of(context).size.width * 0.5,
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                Text(reports[index].text),
                SizedBox(height: 8),
                if (reports[index].imageUrls.isNotEmpty)
                  Container(
                    height: 150,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: reports[index].imageUrls.map((imageUrl) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(
                                image: NetworkImage(imageUrl),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                SizedBox(height: 8),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.thumb_up),
                      onPressed: () => _likeReport(index),
                    ),
                    Text(reports[index].likes.toString()),
                    Spacer(),
                    IconButton(
                      icon: Icon(Icons.comment),
                      onPressed: () => _toggleComments(index),
                    ),
                  ],
                ),
                TextField(
                  controller: _commentController,
                  decoration: InputDecoration(
                    hintText: 'Añadir un comentario...',
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.send),
                      onPressed: () {
                        if (_commentController.text.isNotEmpty) {
                          _addComment(index, _commentController.text);
                        }
                      },
                    ),
                  ),
                  onSubmitted: (value) {
                    if (value.isNotEmpty) {
                      _addComment(index, value);
                    }
                  },
                ),
                if (_showComments[index])
                  Column(
                    children: reports[index].comments.map((comment) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(
                          comment,
                          style: TextStyle(color: Colors.black54),
                        ),
                      );
                    }).toList(),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

 void _goToHome(BuildContext context) {
  Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MyApp()),
          );
}


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
                _buildActionButton(context, 'Reportes',isSelected: true),
                _buildActionButton(context, 'Recompensas'),
                _buildActionButton(context, 'Juegos', ),
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
            padding: const EdgeInsets.all(35.0),
            child: Column(
              children: [
                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(), 
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 1.3,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                  ),
                  itemCount: reports.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => _showFullReport(index),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 4,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                reports[index].text,
                                style: TextStyle(fontSize: 13),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 4,
                              ),
                              Spacer(),
                              if (reports[index].imageUrls.isNotEmpty)
                                Center(
                                  child: Container(
                                    height: 92,
                                    width: 180,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(8),
                                      image: DecorationImage(
                                        image: NetworkImage(reports[index].imageUrls[0]),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              SizedBox(height: 9),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.thumb_up),
                                        onPressed: () => _likeReport(index),
                                      ),
                                      Text(reports[index].likes.toString()),
                                    ],
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.comment),
                                    onPressed: () => _toggleComments(index),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                            ),
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextField(
                                  controller: _reportController,
                                  maxLines: null,
                                  decoration: InputDecoration(
                                    hintText: 'Escribe un reporte',
                                    border: InputBorder.none,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: _imageUrls.map((imageUrl) {
                                    return Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(5),
                                        image: DecorationImage(
                                          image: NetworkImage(imageUrl),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            right: 10,
                            bottom: 10,
                            child: IconButton(
                              icon: Icon(Icons.photo),
                              onPressed: _pickImage,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: _submitReport,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          textStyle: TextStyle(color: Colors.black),
                        ),
                        child: Text('Enviar reporte'),
                      ),
                    ],
                  ),
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
}
class Report {
  String text;
  List<String> imageUrls;
  List<String> comments;
  int likes;

  Report({required this.text, required this.imageUrls, this.comments = const [], this.likes = 0});
}