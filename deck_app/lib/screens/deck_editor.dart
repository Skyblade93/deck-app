import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:uuid/uuid.dart';

import '../models/card_model.dart';

class DeckEditor extends StatefulWidget {
  final Function(List<CardModel>) onSave;

  const DeckEditor({super.key, required this.onSave});

  @override
  State<DeckEditor> createState() => _DeckEditorState();
}

class _DeckEditorState extends State<DeckEditor> {
  List<CardModel> cards = [];
  final uuid = Uuid();

  Future<void> addCard() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result == null) return;

    final file = result.files.first;

    setState(() {
      cards.add(CardModel(
        id: uuid.v4(),
        name: file.name,
        imagePath: file.path!,
        quantity: 1,
      ));
    });
  }

  void save() {
    widget.onSave(cards);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Deck Editor")),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: addCard,
            child: const Text("Aggiungi carta"),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cards.length,
              itemBuilder: (context, i) {
                final c = cards[i];
                return ListTile(
                  title: Text(c.name),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      setState(() => cards.removeAt(i));
                    },
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: save,
            child: const Text("Salva Deck"),
          ),
        ],
      ),
    );
  }
}