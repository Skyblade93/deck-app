import 'dart:io';
import 'package:flutter/material.dart';

import '../engine/deck_engine.dart';
import '../models/card_model.dart';
import '../services/storage_service.dart';
import 'deck_editor.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DeckEngine engine = DeckEngine();
  List<CardModel> cards = [];
  CardModel? current;

  @override
  void initState() {
    super.initState();
    load();
  }

  Future<void> load() async {
    cards = await StorageService.load();
    engine.build(cards);
    setState(() {});
  }

  void draw() {
    setState(() {
      current = engine.draw();
    });
  }

  void openEditor() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DeckEditor(
          onSave: (newCards) {
            cards = newCards;
            engine.build(cards);
            StorageService.save(cards);
            setState(() {});
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Deck App")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Carte rimaste: ${engine.deck.length}"),

          const SizedBox(height: 20),

          if (current != null)
            Image.file(File(current!.imagePath), height: 250)
          else
            const Text("Premi PESCA"),

          const SizedBox(height: 20),

          ElevatedButton(
            onPressed: draw,
            child: const Text("PESCA CARTA"),
          ),

          ElevatedButton(
            onPressed: openEditor,
            child: const Text("DECK EDITOR"),
          ),
        ],
      ),
    );
  }
}