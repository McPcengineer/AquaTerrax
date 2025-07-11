import 'package:aquaterrax/games.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PlantWateringGame extends FlameGame with HasKeyboardHandlerComponents {
  final BuildContext context; 
  PlantWateringGame(this.context); 
  late SpriteComponent player;
  late List<SpriteComponent> plants; 
  late SpriteComponent background;
  late TextComponent scoreText; 
  int score = 0; 
  bool gameFinished = false;

  @override
  Future<void> onLoad() async {
    super.onLoad();

    background = SpriteComponent()
      ..sprite = await loadSprite('background.jpg') 
      ..size = size; 
      background.position = Vector2.zero(); 

    add(background); 

    
    player = SpriteComponent()
      ..sprite = await loadSprite('player.png') 
      ..size = Vector2(200, 200)
      ..position = Vector2(size.x / 2, size.y - 100);

    add(player); 

 
    plants = [];

 
    for (int i = 0; i < 8; i++) {
      final plant = SpriteComponent()
        ..sprite = await loadSprite('plant.png') 
        ..size = Vector2(200, 200)
        ..position = Vector2(
          (i + 1) * (size.x / 9), 
          100 + (i % 4) * 100, 
        );

      plants.add(plant);
      add(plant); 
    }

    scoreText = TextComponent(text: 'Plantas regadas: $score')
      ..position = Vector2(10, 10)
      ..textRenderer = TextPaint(
        style: TextStyle(color: Colors.white, fontSize: 24),
      );
    add(scoreText); 

  
    FlameAudio.audioCache.load('water_sound.mp3'); 
    FlameAudio.audioCache.load('kids_cheering.mp3');
  }

  @override
  void update(double dt) {
    super.update(dt);

   
    if (!gameFinished) {
      for (var plant in List.from(plants)) { 
        if (player.position.distanceTo(plant.position) < 50) {
          
          if (plant.isMounted) { 
            FlameAudio.play('water_sound.mp3'); 
            score++;
            scoreText.text = 'Plantas regadas: $score'; 
            remove(plant); 
       
            if (score >= 8) {
              gameFinished = true; 
              FlameAudio.play('kids_cheering.mp3');
              showFinishMessage(); 
            }
          }
        }
      }
    }
  }

  void showFinishMessage() {
  
    final finishMessage = TextComponent(text: '¡Felicitaciones! Ganaste\n¿Quieres reiniciar el juego?\nPresiona R para reiniciar\nO B para regresar')
      ..position = Vector2(size.x / 2 - 150, size.y / 2 - 50)
      ..textRenderer = TextPaint(
        style: TextStyle(color: Colors.green, fontSize: 24),
      );
    add(finishMessage);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    if (!gameFinished) {
      for (var plant in plants) {
        if (player.position.distanceTo(plant.position) < 50) {
          final textPainter = TextPainter(
            text: TextSpan(text: 'Regando la planta...', style: TextStyle(color: Colors.green, fontSize: 24)),
            textDirection: TextDirection.ltr,
          );
          textPainter.layout();
          textPainter.paint(canvas, Offset(size.x / 2 - 100, size.y / 2 - 50));
        }
      }
    }
  }

  @override
  KeyEventResult onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    const moveSpeed = 10.0;

  
    if (keysPressed.contains(LogicalKeyboardKey.arrowLeft)) {
      player.position.x -= moveSpeed;
    } else if (keysPressed.contains(LogicalKeyboardKey.arrowRight)) {
      player.position.x += moveSpeed;
    } else if (keysPressed.contains(LogicalKeyboardKey.arrowUp)) {
      player.position.y -= moveSpeed;
    } else if (keysPressed.contains(LogicalKeyboardKey.arrowDown)) {
      player.position.y += moveSpeed;
    }

   
    if (gameFinished && keysPressed.contains(LogicalKeyboardKey.keyR)) {
      resetGame();
    }

    if (gameFinished && keysPressed.contains(LogicalKeyboardKey.keyB)) {
    
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => JuegosPage()));

      return KeyEventResult.handled; 
    }
  
    return super.onKeyEvent(event, keysPressed);
  }

  Future<void> resetGame() async {
   
    plants.clear(); 
    score = 0; 
    gameFinished = false; 

    
    for (int i = 0; i < 8; i++) {
      final plant = SpriteComponent()
        ..sprite = await loadSprite('plant.png')
        ..size = Vector2(200, 200)
        ..position = Vector2(
          (i + 1) * (size.x / 9), 
          100 + (i % 4) * 100, 
        );

      plants.add(plant);
      add(plant); 
    }

    scoreText.text = 'Plantas regadas: $score';
    
    children.where((child) => child is TextComponent && child.text.contains('¡Felicitaciones! Ganaste')).forEach(remove);
  }
}
