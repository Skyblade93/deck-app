import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/card_model.dart';

class StorageService {
  static const key = "deck_data";

  static Future<void> save(List<CardModel> cards) async {
    final prefs = await SharedPreferences.getInstance();
    final data = cards.map((c) => c.toJson()).toList();
    prefs.setString(key, jsonEncode(data));
  }

  static Future<List<CardModel>> load() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(key);

    if (data == null) return [];

    final List decoded = jsonDecode(data);
    return decoded.map((e) => CardModel.fromJson(e)).toList();
  }
}