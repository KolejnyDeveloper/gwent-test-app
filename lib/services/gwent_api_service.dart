import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/card_model.dart';

class GwentApiService {
  static const baseUrl = 'https://api.gwent.one/?key=data&language=pl';

  Future<List<GameCard>> fetchCards() async {
    final res = await http.get(Uri.parse('$baseUrl'));

    if (res.statusCode != 200) {
      throw Exception('API error ${res.statusCode}');
    }

    final data = jsonDecode(res.body);

    final response = data['response'] as Map<String, dynamic>;

    return response.values
        .map((e) => GameCard.fromJson(e as Map<String, dynamic>))
        .toList();
  }
  Future<List<GameCard>> fetchCard(int cardid) async {
    final res = await http.get(Uri.parse('$baseUrl&id=$cardid'));

    if (res.statusCode != 200) {
      throw Exception('API error ${res.statusCode}');
    }

    final data = jsonDecode(res.body);

    final response = data['response'] as Map<String, dynamic>;

    return response.values
        .map((e) => GameCard.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}