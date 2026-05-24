import 'dart:math';
import '../models/card_model.dart';

class DeckEngine {
  List<CardModel> deck = [];
  List<CardModel> discard = [];

  void build(List<CardModel> cards) {
    deck.clear();
    discard.clear();

    for (var c in cards) {
      for (int i = 0; i < c.quantity; i++) {
        deck.add(CardModel(
          id: c.id,
          name: c.name,
          imagePath: c.imagePath,
          quantity: 1,
        ));
      }
    }

    deck.shuffle(Random());
  }

  CardModel? draw() {
    if (deck.isEmpty) {
      reshuffle();
    }

    if (deck.isEmpty) return null;

    final card = deck.removeLast();
    discard.add(card);
    return card;
  }

  void reshuffle() {
    deck = [...discard];
    discard.clear();
    deck.shuffle();
  }
}