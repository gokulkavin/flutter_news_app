import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Sport extends DataProvider {
  Sport(String apiCategory) : super(apiCategory);
}

class Tech extends DataProvider {
  Tech(String apiCategory) : super(apiCategory);
}

class DataProvider with ChangeNotifier {
  Map<String, dynamic> _map = {};
  bool _error = false;
  // String _errorMessage = '';

  Map<String, dynamic> get mmap => _map;
  bool get error => _error;
  // String get errorMessage => _errorMessage;

  late final String _category;
  DataProvider(String apiCategory) : _category = apiCategory;

  Future<void> getData() async {
    final response = await get(Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=in&category=$_category&pagesize=100&apiKey=93de512a1c4a418194353e1e221d8381'));
    if (response.statusCode == 200) {
      try {
        _map = jsonDecode(response.body);
        _error = false;
      } catch (e) {
        _error = true;
        // _errorMessage = e.toString();
      }
    } else {
      _map = {};
      // _errorMessage = 'Something Wrong';
      _error = true;
    }
    notifyListeners();
  }
}
