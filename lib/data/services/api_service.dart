import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:starkzapp_project/data/models/user_model.dart';

class ApiService {
  final String end_point = 'https://randomuser.me/api/?results=20';

  Future<List<UserModel>> fetchUsers() async {
    final response = await http.get(Uri.parse(end_point));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> results = data['results'];
      return results.map((json) => UserModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }
}
