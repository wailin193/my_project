// import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:my_project/models/cart_list/cart_list.dart';
import 'package:http/http.dart' as http;


class LocationService {
  Future<List<String>> searchCountries(String text) async {
    final url = Uri.parse('https://restcountries.com/v3.1/name/$text');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map<String>((country) => country['name']['common']).toList();
    }else {
      return [];
    }
  }
}
