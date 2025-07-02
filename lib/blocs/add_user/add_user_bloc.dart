import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../services/user_storage_service.dart';
import 'add_user_event.dart';
import 'add_user_state.dart';

class AddUserBloc extends Bloc<AddUserEvent, AddUserState> {
  AddUserBloc() : super(AddUserInitial()) {
    on<SubmitUser>((event, emit) async {
      emit(AddUserLoading());

      try {
        debugPrint('AddUserBloc: Adding new user: ${event.user.name}');

        // Validate user data
        if (event.user.name == null || event.user.name!.isEmpty) {
          emit(AddUserError('User name is required'));
          return;
        }

        if (event.user.email == null || event.user.email!.isEmpty) {
          emit(AddUserError('User email is required'));
          return;
        }

        // Validate email format
        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
            .hasMatch(event.user.email!)) {
          emit(AddUserError('Please enter a valid email address'));
          return;
        }

        if (event.user.phone == null || event.user.phone!.isEmpty) {
          emit(AddUserError('User phone is required'));
          return;
        }

        if (event.user.username == null || event.user.username!.isEmpty) {
          emit(AddUserError('Username is required'));
          return;
        }

        // Try to save user directly to avoid service issues
        try {
          final prefs = await SharedPreferences.getInstance();

          // Load existing users
          final usersString = prefs.getString('local_users') ?? '[]';
          final List<dynamic> existingUsers = json.decode(usersString);

          // Add new user
          existingUsers.add(event.user.toJson());

          // Save back to SharedPreferences
          final updatedUsersString = json.encode(existingUsers);
          await prefs.setString('local_users', updatedUsersString);

          debugPrint('AddUserBloc: User saved directly to SharedPreferences');
        } catch (storageError) {
          debugPrint('AddUserBloc: Direct storage error: $storageError');
          // Fallback to UserStorageService
          await UserStorageService.addLocalUser(event.user);
        }

        debugPrint(
            'AddUserBloc: User ${event.user.name} added successfully to local storage');

        emit(AddUserSuccess('User "${event.user.name}" added successfully!'));
      } catch (e) {
        debugPrint('AddUserBloc: Error adding user: $e');
        emit(AddUserError('Failed to add user: ${e.toString()}'));
      }
    });

    on<ResetAddUserState>((event, emit) {
      emit(AddUserInitial());
    });
  }
}
