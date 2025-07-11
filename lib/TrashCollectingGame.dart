import 'dart:math';

import 'package:aquaterrax/games.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TrashCollectingGame extends FlameGame with HasKeyboardHandlerComponents {
  final BuildContext context; 
  TrashCollectingGame(this.context); 
  late SpriteComponent player;
  late List<SpriteComponent> trashItems; 
  late SpriteComponent trashBin; 
  late SpriteComponent background;
  late TextComponent scoreText; 
  int score = 0; 
  bool gameFinished = false;

 @override
Future<void> onLoad() async {
  super.onLoad();

 
  background = SpriteComponent()
    ..sprite = await loadSprite('street_background.jpg') 
    ..size = size; 
  background.position = Vector2.zero(); 

  add(background); 

  
  player = SpriteComponent()
    ..sprite = await loadSprite('player2.png') 
    ..size = Vector2(100, 100)
    ..position = Vector2(size.x / 2, size.y - 150);

  add(player);

 
  trashItems = [];

  
  for (int i = 0; i < 8; i++) {
    final trash = SpriteComponent()
      ..sprite = await loadSprite('trash.png') 
      ..size = Vector2(50, 50)
      ..position = Vector2(
        Random().nextDouble() * (size.x - 50), 
        size.y - 60, 
      );

    trashItems.add(trash);
    add(trash); 
  }

  
  trashBin = SpriteComponent()
    ..sprite = await loadSprite('trash_bin.png') 
    ..size = Vector2(100, 100)
    ..position = Vector2(size.x / 2 - 50, size.y - 200); 

  add(trashBin); 


  scoreText = TextComponent(text: 'Basura recogida: $score')
    ..position = Vector2(10, 10)
    ..textRenderer = TextPaint(
      style: TextStyle(color: Colors.white, fontSize: 24),
    );
  add(scoreText); 

  
  FlameAudio.audioCache.load('background_music.mp3'); 
  FlameAudio.audioCache.load('good_job.mp3'); 
  FlameAudio.audioCache.load('kids_cheering.mp3'); 


  FlameAudio.bgm.play('background_music.mp3', volume: 0.5);
}


  @override
  void update(double dt) {
    super.update(dt);

   
    if (!gameFinished) {
      for (var trash in List.from(trashItems)) { 
        if (player.position.distanceTo(trash.position) < 50) {
         
          if (trash.isMounted) { 
            FlameAudio.play('good_job.mp3'); 
            score++; 
            scoreText.text = 'Basura recogida: $score'; 
            remove(trash); 

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
      for (var trash in trashItems) {
        if (player.position.distanceTo(trash.position) < 50) {
          final textPainter = TextPainter(
            text: TextSpan(text: 'Recogiendo basura...', style: TextStyle(color: Colors.green, fontSize: 24)),
            textDirection: TextDirection.ltr,
          );
          textPainter.layout();
          textPainter.paint(canvas, Offset(size.x / 2 - 100, size.y / 2 - 50));
        }
      }
    }
  }

 void stopBackgroundMusic() {
    FlameAudio.bgm.stop(); 
  }

  @override
  KeyEventResult onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keys) {
    const moveSpeed = 10.0;
    if (event is KeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
        player.position.x -= moveSpeed;
      } else if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
        player.position.x += moveSpeed;
      } else if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
        player.position.y -= moveSpeed;
      } else if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
        player.position.y += moveSpeed;
      }

     
      if (gameFinished && event.logicalKey == LogicalKeyboardKey.keyR) {
        resetGame();
      }

      if (gameFinished && event.logicalKey == LogicalKeyboardKey.keyB) {
        stopBackgroundMusic(); 
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => JuegosPage()));
      }
    }

    return super.onKeyEvent(event, keys);
  }

  Future<void> resetGame() async {
    trashItems.clear(); 
    score = 0; 
    gameFinished = false; 

    for (int i = 0; i < 8; i++) {
      final trash = SpriteComponent()
        ..sprite = await loadSprite('trash.png') 
        ..size = Vector2(50, 50)
        ..position = Vector2(
          (i + 1) * (size.x / 9), 
          100 + (i % 4) * 100, 
        );

      trashItems.add(trash);
      add(trash); 
    }

    scoreText.text = 'Basura recogida: $score';

    
    children.where((component) => component is TextComponent).forEach(remove);
  }
}
