// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:userdemo_app/blocs/add_user/add_user_bloc.dart';
import 'package:userdemo_app/blocs/add_user/add_user_event.dart';
import 'package:userdemo_app/blocs/add_user/add_user_state.dart';
import 'package:userdemo_app/utils/app_styles.dart';
import 'package:userdemo_app/widgets/custom_text_field.dart';

import '../models/user_model.dart';

class AddUserPage extends StatelessWidget {
  const AddUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddUserBloc(),
      child: const _AddUserContent(),
    );
  }
}

class _AddUserContent extends StatefulWidget {
  const _AddUserContent();

  @override
  State<_AddUserContent> createState() => _AddUserContentState();
}

class _AddUserContentState extends State<_AddUserContent> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _usernameController = TextEditingController();
  final _websiteController = TextEditingController();
  final _addressController = TextEditingController();
  final _latController = TextEditingController();
  final _lngController = TextEditingController();
  final _companyController = TextEditingController();
  final _catchPhraseController = TextEditingController();
  final _businessController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _usernameController.dispose();
    _websiteController.dispose();
    _addressController.dispose();
    _latController.dispose();
    _lngController.dispose();
    _companyController.dispose();
    _catchPhraseController.dispose();
    _businessController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final newUser = User(
        id: DateTime.now().millisecondsSinceEpoch,
        name: _nameController.text.trim(),
        username: _usernameController.text.trim(),
        email: _emailController.text.trim(),
        phone: _phoneController.text.trim(),
        website:
            _websiteController.text.trim().isNotEmpty
                ? _websiteController.text.trim()
                : null,
        address:
            _addressController.text.trim().isNotEmpty ||
                    _latController.text.trim().isNotEmpty ||
                    _lngController.text.trim().isNotEmpty
                ? Address(
                  street:
                      _addressController.text.trim().isNotEmpty
                          ? _addressController.text.trim()
                          : null,
                  geo:
                      _latController.text.trim().isNotEmpty &&
                              _lngController.text.trim().isNotEmpty
                          ? Geo(
                            lat: _latController.text.trim(),
                            lng: _lngController.text.trim(),
                          )
                          : null,
                )
                : null,
        company:
            _companyController.text.trim().isNotEmpty ||
                    _catchPhraseController.text.trim().isNotEmpty ||
                    _businessController.text.trim().isNotEmpty
                ? Company(
                  name:
                      _companyController.text.trim().isNotEmpty
                          ? _companyController.text.trim()
                          : null,
                  catchPhrase:
                      _catchPhraseController.text.trim().isNotEmpty
                          ? _catchPhraseController.text.trim()
                          : null,
                  bs:
                      _businessController.text.trim().isNotEmpty
                          ? _businessController.text.trim()
                          : null,
                )
                : null,
      );

      context.read<AddUserBloc>().add(SubmitUser(newUser));
    }
  }

  void _clearForm() {
    _nameController.clear();
    _usernameController.clear();
    _emailController.clear();
    _phoneController.clear();
    _websiteController.clear();
    _addressController.clear();
    _latController.clear();
    _lngController.clear();
    _companyController.clear();
    _catchPhraseController.clear();
    _businessController.clear();
  }

  void _selectLocation() async {
    // For now, show a simple dialog for coordinates input
    // In a real app, you would integrate with location services or maps
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Enter Coordinates'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _latController,
                  decoration: const InputDecoration(
                    labelText: 'Latitude',
                    hintText: 'e.g., 40.7128',
                  ),
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _lngController,
                  decoration: const InputDecoration(
                    labelText: 'Longitude',
                    hintText: 'e.g., -74.0060',
                  ),
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  setState(() {}); // Refresh to show coordinates
                },
                child: const Text('Save'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(160),
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
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 24,
                    ),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  const SizedBox(width: 16),
                  const Text(
                    'Add New User',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Title and description
              const Text(
                'Create User Profile',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Fill in the details to add a new user',
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ],
          ),
        ),
      ),
      body: BlocListener<AddUserBloc, AddUserState>(
        listener: (context, state) {
          debugPrint('AddUserPage: State changed to ${state.runtimeType}');

          if (state is AddUserSuccess) {
            // Clear form
            _clearForm();

            // Show success message
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Row(
                  children: [
                    const Icon(Icons.check_circle, color: Colors.white),
                    const SizedBox(width: 8),
                    Text(state.message),
                  ],
                ),
                backgroundColor: Colors.green,
                duration: const Duration(seconds: 2),
              ),
            );

            // Navigate back - the HomePage will handle the refresh
            Navigator.pop(context, true); // Return true to indicate success
          } else if (state is AddUserError) {
            debugPrint('AddUserPage: Error - ${state.message}');

            // Show error message
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Row(
                  children: [
                    const Icon(Icons.error, color: Colors.white),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        state.message,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
                backgroundColor: Colors.red,
                duration: const Duration(seconds: 3),
              ),
            );
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppStyles.paddingMedium),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Contact Information Section
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                      AppStyles.borderRadiusMedium,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(AppStyles.paddingMedium),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: const Color(0xFF4A6CF7).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(
                                Icons.person,
                                color: Color(0xFF4A6CF7),
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Text(
                              'Contact Information',
                              style: AppStyles.headingMedium,
                            ),
                          ],
                        ),
                        const SizedBox(height: AppStyles.paddingMedium),
                        CustomTextField(
                          controller: _nameController,
                          labelText: 'Full Name',
                          prefixIcon: Icons.person,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a name';
                            }
                            return null;
                          },
                        ),
                        CustomTextField(
                          controller: _usernameController,
                          labelText: 'Username',
                          prefixIcon: Icons.account_circle,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a username';
                            }
                            return null;
                          },
                        ),
                        CustomTextField(
                          controller: _emailController,
                          labelText: 'Email',
                          prefixIcon: Icons.email,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter an email';
                            }
                            if (!RegExp(
                              r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                            ).hasMatch(value)) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                        ),
                        CustomTextField(
                          controller: _phoneController,
                          labelText: 'Phone',
                          prefixIcon: Icons.phone,
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a phone number';
                            }
                            return null;
                          },
                        ),
                        CustomTextField(
                          controller: _websiteController,
                          labelText: 'Website (Optional)',
                          prefixIcon: Icons.web,
                          keyboardType: TextInputType.url,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppStyles.paddingMedium),

                // Address Section
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                      AppStyles.borderRadiusMedium,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(AppStyles.paddingMedium),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: const Color(0xFF4A6CF7).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(
                                Icons.location_on,
                                color: Color(0xFF4A6CF7),
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Text(
                              'Address',
                              style: AppStyles.headingMedium,
                            ),
                          ],
                        ),
                        const SizedBox(height: AppStyles.paddingMedium),
                        CustomTextField(
                          controller: _addressController,
                          labelText: 'Address (Optional)',
                          prefixIcon: Icons.location_on,
                          hintText: 'Street, City, State, ZIP',
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                            vertical: AppStyles.paddingSmall,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      AppStyles.borderRadiusMedium,
                                    ),
                                    border: Border.all(
                                      color: Colors.grey.shade300,
                                    ),
                                  ),
                                  child: InkWell(
                                    onTap: _selectLocation,
                                    borderRadius: BorderRadius.circular(
                                      AppStyles.borderRadiusMedium,
                                    ),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: AppStyles.paddingMedium,
                                        vertical: AppStyles.paddingMedium,
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.gps_fixed,
                                            color: Colors.grey.shade600,
                                            size: 20,
                                          ),
                                          const SizedBox(width: 12),
                                          Expanded(
                                            child: Text(
                                              _latController.text.isEmpty &&
                                                      _lngController
                                                          .text
                                                          .isEmpty
                                                  ? 'Tap to select location'
                                                  : '${_latController.text}, ${_lngController.text}',
                                              style: TextStyle(
                                                color:
                                                    _latController
                                                                .text
                                                                .isEmpty &&
                                                            _lngController
                                                                .text
                                                                .isEmpty
                                                        ? Colors.grey.shade500
                                                        : Colors.black87,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFF4A6CF7),
                                      Color(0xFF7B68EE),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: IconButton(
                                  onPressed: _selectLocation,
                                  icon: const Icon(
                                    Icons.location_searching,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppStyles.paddingMedium),

                // Company Section
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                      AppStyles.borderRadiusMedium,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(AppStyles.paddingMedium),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: const Color(0xFF4A6CF7).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(
                                Icons.business,
                                color: Color(0xFF4A6CF7),
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Text(
                              'Company',
                              style: AppStyles.headingMedium,
                            ),
                          ],
                        ),
                        const SizedBox(height: AppStyles.paddingMedium),
                        CustomTextField(
                          controller: _companyController,
                          labelText: 'Company Name (Optional)',
                          prefixIcon: Icons.business,
                        ),
                        CustomTextField(
                          controller: _catchPhraseController,
                          labelText: 'Catch Phrase (Optional)',
                          prefixIcon: Icons.campaign,
                          hintText: 'Company motto or slogan',
                        ),
                        CustomTextField(
                          controller: _businessController,
                          labelText: 'Business (Optional)',
                          prefixIcon: Icons.work,
                          hintText: 'Type of business',
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppStyles.paddingLarge),

                // Submit Button
                Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF4A6CF7), Color(0xFF7B68EE)],
                    ),
                    borderRadius: BorderRadius.circular(
                      AppStyles.borderRadiusMedium,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF4A6CF7).withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: BlocBuilder<AddUserBloc, AddUserState>(
                    builder: (context, state) {
                      final isLoading = state is AddUserLoading;

                      return ElevatedButton(
                        onPressed: isLoading ? null : _submitForm,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          foregroundColor: Colors.white,
                          shadowColor: Colors.transparent,
                          padding: const EdgeInsets.symmetric(
                            vertical: AppStyles.paddingMedium,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              AppStyles.borderRadiusMedium,
                            ),
                          ),
                        ),
                        child:
                            isLoading
                                ? const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                              Colors.white,
                                            ),
                                      ),
                                    ),
                                    SizedBox(width: 12),
                                    Text(
                                      'Adding User...',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                )
                                : const Text(
                                  'Add User',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
