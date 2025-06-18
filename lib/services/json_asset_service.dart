import 'dart:convert';
import 'package:flutter/services.dart';

class JsonAssetsService {
  static final JsonAssetsService _instance = JsonAssetsService._internal();
  factory JsonAssetsService() => _instance;
  JsonAssetsService._internal();

  /// Load JSON data from assets folder
  /// [assetPath] - Path to the JSON file in assets folder (e.g., 'assets/data/users.json')
  Future<Map<String, dynamic>> loadJsonFromAssets(String assetPath) async {
    try {
      final String jsonString = await rootBundle.loadString(assetPath);
      return json.decode(jsonString) as Map<String, dynamic>;
    } catch (e) {
      throw Exception('Failed to load JSON from assets: $e');
    }
  }

  /// Load JSON array from assets folder
  /// [assetPath] - Path to the JSON file in assets folder
  Future<List<dynamic>> loadJsonArrayFromAssets(String assetPath) async {
    try {
      final String jsonString = await rootBundle.loadString(assetPath);
      return json.decode(jsonString) as List<dynamic>;
    } catch (e) {
      throw Exception('Failed to load JSON array from assets: $e');
    }
  }

  /// Load and parse JSON data into a specific model type
  /// [assetPath] - Path to the JSON file in assets folder
  /// [fromJson]
  Future<T> loadJsonModel<T>(
    String assetPath,
    T Function(Map<String, dynamic>) fromJson,
  ) async {
    try {
      final Map<String, dynamic> jsonData = await loadJsonFromAssets(assetPath);
      return fromJson(jsonData);
    } catch (e) {
      throw Exception('Failed to load JSON model from assets: $e');
    }
  }

  /// Load and parse JSON array into a list of specific model type
  /// [assetPath]
  /// [fromJson]
  Future<List<T>> loadJsonModelList<T>(
    String assetPath,
    T Function(Map<String, dynamic>) fromJson,
  ) async {
    try {
      final List<dynamic> jsonArray = await loadJsonArrayFromAssets(assetPath);
      return jsonArray
          .map((item) => fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to load JSON model list from assets: $e');
    }
  }

  /// Check if asset file exists
  /// [assetPath] - Path to check
  Future<bool> assetExists(String assetPath) async {
    try {
      await rootBundle.loadString(assetPath);
      return true;
    } catch (e) {
      return false;
    }
  }
}
