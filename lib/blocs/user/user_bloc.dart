import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:userdemo_app/models/user_model.dart';
import 'package:userdemo_app/services/api_services.dart';
import 'package:userdemo_app/services/user_storage_service.dart';

import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final ApiService apiService;
  final List<User> _users = [];

  UserBloc(this.apiService) : super(UserInitial()) {
    // Register event handlers first
    on<FetchUsers>((event, emit) async {
      emit(UserLoading());
      try {
        debugPrint('UserBloc: Starting to fetch users...');
        final users = await apiService.fetchUsers();
        debugPrint('UserBloc: Successfully fetched ${users.length} users');
        _users.clear();
        _users.addAll(users);
        emit(UserLoaded(List.from(_users)));
      } catch (e) {
        debugPrint('UserBloc: Error fetching users: $e');
        String errorMessage = 'Failed to load users';

        if (e.toString().contains('Network error')) {
          errorMessage =
              'No internet connection. Please check your network and try again.';
        } else if (e.toString().contains('timeout')) {
          errorMessage = 'Request timed out. Please try again.';
        } else if (e.toString().contains('SocketException')) {
          errorMessage =
              'Unable to connect to server. Please check your internet connection.';
        }

        emit(UserError(errorMessage));
      }
    });

    on<AddUser>((event, emit) async {
      try {
        debugPrint('UserBloc: Adding new user: ${event.user.name}');

        // Validate user data
        if (event.user.name == null || event.user.name!.isEmpty) {
          debugPrint('UserBloc: User name is empty');
          return;
        }

        if (event.user.email == null || event.user.email!.isEmpty) {
          debugPrint('UserBloc: User email is empty');
          return;
        }

        // Save user to shared preferences
        await UserStorageService.addLocalUser(event.user);

        // Add user to current list
        _users.add(event.user);

        debugPrint(
          'UserBloc: User added successfully. Total users: ${_users.length}',
        );

        // Emit the updated state with a new list
        emit(UserLoaded(List<User>.from(_users)));
      } catch (e) {
        debugPrint('UserBloc: Error adding user: $e');
        // Don't emit error state, just log the error
      }
    });

    on<RefreshUsers>((event, emit) async {
      try {
        debugPrint('UserBloc: Refreshing users...');
        final users = await apiService.fetchUsers();
        debugPrint('UserBloc: Successfully refreshed ${users.length} users');
        _users.clear();
        _users.addAll(users);
        emit(UserLoaded(List.from(_users)));
      } catch (e) {
        debugPrint('UserBloc: Error refreshing users: $e');
        // Don't emit error state on refresh, keep current state
      }
    });

    // Now automatically fetch users after handlers are registered
    add(FetchUsers());
  }
}
