
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:craftybay/app/app_colors.dart';

import '../../../../app/app_snackbar.dart';
import '../providers/profile_provider.dart';
import '../widgets/custom_update_button.dart';
import '../widgets/personal_details_header.dart';
import '../widgets/text_filed.dart';

class PersonalInfoScreen extends StatefulWidget {
  const PersonalInfoScreen({super.key});

  static const String name = '/personal-info';

  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _firstNameController =
  TextEditingController();
  final TextEditingController _lastNameController =
  TextEditingController();
  final TextEditingController _emailController =
  TextEditingController();
  final TextEditingController _phoneController =
  TextEditingController();
  final TextEditingController _cityController =
  TextEditingController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadProfile();
    });
  }

  // Load Profile Data

  Future<void> _loadProfile() async {
    final provider = context.read<ProfileProvider>();

    final success = await provider.getProfile();

    if (!mounted) return;

    if (success) {
      final data = provider.profileData!;

      _firstNameController.text = data.firstName;
      _lastNameController.text = data.lastName;
      _emailController.text = data.email;
      _phoneController.text = data.phone;
      _cityController.text = data.city;
    }
  }

  // Update Profile

  Future<void> _updateProfile() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final provider = context.read<ProfileProvider>();

    final bool success = await provider.updateProfile(
      body: {
        'first_name': _firstNameController.text.trim(),
        'last_name': _lastNameController.text.trim(),
        'phone': _phoneController.text.trim(),
        'city': _cityController.text.trim(),
      },
    );


    if (!mounted) return;

    if (success) {
      showAppSnackBar(
        context: context,
        message: provider.successMessage ??
            'Profile updated successfully',
        backgroundColor: Colors.green,
      );

      Navigator.pop(context);
    } else {
      showAppSnackBar(
        context: context,
        message: provider.errorMessage ??
            'Profile update failed',
        backgroundColor: Colors.red,
      );
    }
  }

  // Reusable Text Field

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F8),
      appBar: AppBar(
        title: const Text(
          'Personal Information',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: AppColors.themeColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Consumer<ProfileProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading && provider.profileData == null) {
            return Center(
              child: CircularProgressIndicator(
                color: AppColors.themeColor,
              ),
            );
          }

          if (provider.profileData == null) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 50,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      provider.errorMessage ?? 'Unable to load profile',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _loadProfile,
                      child: const Text('Try Again'),
                    ),
                  ],
                ),
              ),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const PersonalDetailsHeader(),

                  const SizedBox(height: 24),

                  const Text(
                    'Basic Information',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 16),

                  AppTextField(
                    label: 'First Name',
                    hint: 'Enter your first name',
                    controller: _firstNameController,
                    icon: Icons.person_outline,
                  ),

                  const SizedBox(height: 10),

                  AppTextField(
                    label: 'Last Name',
                    hint: 'Enter your Last name',
                    controller: _lastNameController,
                    icon: Icons.person_outline,
                  ),

                  const SizedBox(height: 10),

                  AppTextField(
                    label: 'Email',
                    hint: 'Enter your Email',
                    controller: _emailController,
                    icon: Icons.email,
                    readOnly: true,
                    keyboardType: TextInputType.emailAddress,
                  ),

                  AppTextField(
                    label: 'Phone Number',
                    hint: 'Enter phone valid phone number',
                    controller: _phoneController,
                    icon: Icons.phone,
                    keyboardType: TextInputType.phone,
                  ),

                  const SizedBox(height: 10),

                  AppTextField(
                    label: 'City',
                    hint: 'Enter City Name',
                    controller: _cityController,
                    icon: Icons.location_city,
                  ),

                  const SizedBox(height: 20),


                  CustomUpdateButton(
                    isLoading: provider.isUpdating,
                    onPressed: _updateProfile,
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _cityController.dispose();

    super.dispose();
  }
}
