// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:userdemo_app/blocs/user/user_bloc.dart';
import 'package:userdemo_app/blocs/user/user_event.dart';
import 'package:userdemo_app/blocs/user/user_state.dart';
import 'package:userdemo_app/models/user_model.dart';
import 'package:userdemo_app/screens/user_details_page.dart';
import 'package:userdemo_app/utils/app_styles.dart';
import 'package:userdemo_app/widgets/user_tile.dart';

import 'add_user_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_filterUsers);
    // Remove any manual FetchUsers() call since it's now automatic in UserBloc
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterUsers() {
    final query = _searchController.text.toLowerCase();
    if (query.isEmpty) {
    } else {}
    // Only call setState if we're not in the build phase
    if (mounted) {
      setState(() {});
    }
  }

  void _updateFilteredUsers(List<User> users) {
    _filterUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(240),
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF4A6CF7), Color(0xFF7B68EE)],
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top navigation bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Users',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      showMenu(
                        context: context,
                        position: const RelativeRect.fromLTRB(100, 100, 0, 0),
                        items: [
                          const PopupMenuItem(
                            enabled: false,
                            child: Text(
                              'Nothing here!!',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                    icon: const Icon(
                      Icons.more_vert,
                      color: Colors.white,
                      size: 24,
                    ),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Dashboard title and description
              const Text(
                'User Management',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              BlocBuilder<UserBloc, UserState>(
                builder: (context, state) {
                  int userCount = 0;
                  if (state is UserLoaded) {
                    userCount = state.users.length;
                  }
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Users Count',
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                      Text(
                        '$userCount users',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 10),

              // Progress bar
              BlocBuilder<UserBloc, UserState>(
                builder: (context, state) {
                  double progress = 0.0;
                  if (state is UserLoaded && state.users.isNotEmpty) {
                    progress = (state.users.length / 20).clamp(0.0, 1.0);
                  }
                  return Container(
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(2),
                    ),
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: progress,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 15),

              // Search Bar integrated in header
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search users...',
                    hintStyle: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 14,
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.grey.shade400,
                      size: 20,
                    ),
                    suffixIcon:
                        _searchController.text.isNotEmpty
                            ? IconButton(
                              icon: Icon(
                                Icons.clear,
                                color: Colors.grey.shade400,
                                size: 20,
                              ),
                              onPressed: () {
                                _searchController.clear();
                                FocusScope.of(context).unfocus();
                              },
                            )
                            : null,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                  onChanged: (value) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (mounted) {
                        setState(() {});
                      }
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Users List/Grid
            Expanded(
              child: BlocConsumer<UserBloc, UserState>(
                listener: (context, state) {
                  if (state is UserLoaded) {
                    // Update the users list immediately
                    setState(() {
                      _updateFilteredUsers(state.users);
                    });
                  }
                },
                builder: (context, state) {
                  if (state is UserLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is UserLoaded) {
                    // Always use the latest data from the state
                    final displayUsers =
                        _searchController.text.isEmpty
                            ? state.users
                            : state.users.where((user) {
                              final query =
                                  _searchController.text.toLowerCase();
                              return (user.name?.toLowerCase().contains(
                                        query,
                                      ) ??
                                      false) ||
                                  (user.email?.toLowerCase().contains(query) ??
                                      false) ||
                                  (user.phone?.toLowerCase().contains(query) ??
                                      false) ||
                                  (user.username?.toLowerCase().contains(
                                        query,
                                      ) ??
                                      false);
                            }).toList();

                    if (displayUsers.isEmpty &&
                        _searchController.text.isNotEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.search_off,
                              size: 64,
                              color: Colors.grey.shade400,
                            ),
                            const SizedBox(height: AppStyles.paddingMedium),
                            Text(
                              'No users found for "${_searchController.text}"',
                              style: AppStyles.bodyLarge,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: AppStyles.paddingSmall),
                            Text(
                              'Try searching with different keywords',
                              style: AppStyles.bodyMedium.copyWith(
                                color: AppStyles.textSecondary,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      );
                    } else if (displayUsers.isEmpty) {
                      return const Center(
                        child: Text(
                          'No users available',
                          style: AppStyles.bodyLarge,
                        ),
                      );
                    }

                    return Padding(
                      padding: const EdgeInsets.all(AppStyles.paddingMedium),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (_searchController.text.isNotEmpty) ...[
                            Padding(
                              padding: const EdgeInsets.only(
                                bottom: AppStyles.paddingMedium,
                              ),
                              child: Text(
                                'Found ${displayUsers.length} user${displayUsers.length == 1 ? '' : 's'}',
                                style: AppStyles.bodyMedium.copyWith(
                                  color: AppStyles.textSecondary,
                                ),
                              ),
                            ),
                          ],
                          Expanded(
                            child: RefreshIndicator(
                              onRefresh: () async {
                                context.read<UserBloc>().add(RefreshUsers());
                                // Wait a bit for the refresh to complete
                                await Future.delayed(
                                  const Duration(milliseconds: 500),
                                );
                              },
                              child:
                                  AppStyles.isMobile(context)
                                      ? _buildListView(displayUsers)
                                      : _buildGridView(displayUsers),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else if (state is UserError) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(AppStyles.paddingLarge),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.error_outline,
                              size: 64,
                              color: Colors.red.shade300,
                            ),
                            const SizedBox(height: AppStyles.paddingMedium),
                            const Text(
                              'Oops! Something went wrong',
                              style: AppStyles.headingMedium,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: AppStyles.paddingSmall),
                            Text(
                              state.message,
                              style: AppStyles.bodyMedium,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: AppStyles.paddingLarge),
                            ElevatedButton.icon(
                              onPressed: () {
                                context.read<UserBloc>().add(FetchUsers());
                              },
                              icon: const Icon(Icons.refresh),
                              label: const Text('Retry'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppStyles.primaryColor,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: AppStyles.paddingLarge,
                                  vertical: AppStyles.paddingMedium,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF4A6CF7), Color(0xFF7B68EE)],
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF4A6CF7).withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: FloatingActionButton(
          onPressed: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AddUserPage()),
            );
            // If user was added successfully, refresh the list
            if (result == true && mounted) {
              // ignore: use_build_context_synchronously
              context.read<UserBloc>().add(RefreshUsers());
            }
          },
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: const Icon(Icons.add, color: Colors.white, size: 28),
        ),
      ),
    );
  }

  Widget _buildListView(List<User> users) {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];
        return UserTile(
          user: user,
          onTap:
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => UserDetailPage(user: user)),
              ),
        );
      },
    );
  }

  Widget _buildGridView(List<User> users) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: AppStyles.getCrossAxisCount(context),
        crossAxisSpacing: AppStyles.paddingMedium,
        mainAxisSpacing: AppStyles.paddingMedium,
        childAspectRatio: 0.8,
      ),
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];
        return UserTile(
          user: user,
          onTap:
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => UserDetailPage(user: user)),
              ),
        );
      },
    );
  }
}
