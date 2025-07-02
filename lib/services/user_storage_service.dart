import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import '../models/user_model.dart';

class UserStorageService {
  static const String _localUsersKey = 'local_users';

  // Save local users to shared preferences
  static Future<void> saveLocalUsers(List<User> users) async {
    try {
      debugPrint(
          'UserStorageService: Attempting to save ${users.length} users');
      final prefs = await SharedPreferences.getInstance();
      final usersJson = users.map((user) => user.toJson()).toList();
      final usersString = json.encode(usersJson);
      final success = await prefs.setString(_localUsersKey, usersString);
      debugPrint('UserStorageService: Save success: $success');
      debugPrint('UserStorageService: Saved ${users.length} local users');
    } catch (e) {
      debugPrint('UserStorageService: Error saving users: $e');
      rethrow;
    }
  }

  // Load local users from shared preferences
  static Future<List<User>> loadLocalUsers() async {
    try {
      debugPrint('UserStorageService: Attempting to load users');
      final prefs = await SharedPreferences.getInstance();
      final usersString = prefs.getString(_localUsersKey);

      if (usersString == null || usersString.isEmpty) {
        debugPrint('UserStorageService: No local users found');
        return [];
      }

      final List<dynamic> usersJson = json.decode(usersString);
      final users = usersJson.map((json) => User.fromJson(json)).toList();
      debugPrint('UserStorageService: Loaded ${users.length} local users');
      return users;
    } catch (e) {
      debugPrint('UserStorageService: Error loading users: $e');
      return [];
    }
  }

  // Add a new user to local storage
  static Future<void> addLocalUser(User user) async {
    try {
      debugPrint('UserStorageService: Adding user ${user.name}');
      final localUsers = await loadLocalUsers();
      localUsers.add(user);
      await saveLocalUsers(localUsers);
      debugPrint(
          'UserStorageService: Added user ${user.name} to local storage');
    } catch (e) {
      debugPrint('UserStorageService: Error adding user: $e');
      rethrow;
    }
  }

  // Clear all local users
  static Future<void> clearLocalUsers() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_localUsersKey);
      debugPrint('UserStorageService: Cleared all local users');
    } catch (e) {
      debugPrint('UserStorageService: Error clearing users: $e');
      rethrow;
    }
  }

  // Test SharedPreferences functionality
  static Future<bool> testSharedPreferences() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('test_key', 'test_value');
      final testValue = prefs.getString('test_key');
      await prefs.remove('test_key');
      return testValue == 'test_value';
    } catch (e) {
      debugPrint('SharedPreferences test failed: $e');
      return false;
    }
  }
}
