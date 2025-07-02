import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';
import 'user_storage_service.dart';

class ApiService {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com/users';

  Future<List<User>> fetchUsers() async {
    try {
      debugPrint('Attempting to fetch users from: $baseUrl');

      final response = await http.get(
        Uri.parse(baseUrl),
        headers: {
          'Content-Type': 'application/json',
        },
      ).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw Exception(
              'Request timeout - Please check your internet connection');
        },
      );

      debugPrint('Response status code: ${response.statusCode}');

      List<User> apiUsers = [];
      if (response.statusCode == 200) {
        debugPrint('Response body length: ${response.body.length}');
        final List<dynamic> data = json.decode(response.body);
        apiUsers = data.map((json) => User.fromJson(json)).toList();
        debugPrint('Parsed ${apiUsers.length} API users');
      } else {
        debugPrint('Error response body: ${response.body}');
        throw Exception(
            'Failed to load users: ${response.statusCode} - ${response.reasonPhrase}');
      }

      // Load local users and combine with API users
      final localUsers = await UserStorageService.loadLocalUsers();
      debugPrint('Loaded ${localUsers.length} local users');

      // Combine API users and local users
      final allUsers = [...apiUsers, ...localUsers];
      debugPrint('Total combined users: ${allUsers.length}');

      return allUsers;
    } catch (e) {
      debugPrint('Error in fetchUsers: $e');

      // If API fails, try to return only local users
      try {
        final localUsers = await UserStorageService.loadLocalUsers();
        debugPrint(
            'API failed, returning ${localUsers.length} local users only');
        return localUsers;
      } catch (localError) {
        debugPrint('Error loading local users: $localError');
      }

      if (e.toString().contains('SocketException') ||
          e.toString().contains('HandshakeException')) {
        throw Exception(
            'Network error - Please check your internet connection');
      } else if (e.toString().contains('timeout')) {
        throw Exception('Request timeout - Please try again');
      } else {
        throw Exception('Failed to load users: $e');
      }
    }
  }
}
