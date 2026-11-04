
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:craftybay/app/app_colors.dart';

import '../providers/profile_provider.dart';

class PersonalInfoScreen extends StatefulWidget {
  const PersonalInfoScreen({super.key});

  static const String name = '/personal-info';

  @override
  State<PersonalInfoScreen> createState() =>
      _PersonalInfoScreenState();
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

      setState(() {
        _firstNameController.text = data['first_name'] ?? '';
        _lastNameController.text = data['last_name'] ?? '';
        _emailController.text = data['email'] ?? '';
        _phoneController.text = data['phone'] ?? '';
        _cityController.text = data['city'] ?? '';
      });
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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            provider.successMessage ?? 'Profile updated successfully',
          ),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            provider.errorMessage ?? 'Profile update failed',
          ),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }


  // Reusable Text Field

  Widget _buildTextField({
    required String label,
    required String hint,
    required TextEditingController controller,
    required IconData icon,
    bool readOnly = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF333333),
          ),
        ),

        const SizedBox(height: 8),

        TextFormField(
          controller: controller,
          readOnly: readOnly,
          keyboardType: keyboardType,
          validator: (value) {
            if (readOnly) return null;

            if (value == null || value.trim().isEmpty) {
              return '$label is required';
            }

            if (label == 'Phone Number' &&
                value.trim().length < 10) {
              return 'Enter a valid phone number';
            }

            return null;
          },
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(
              icon,
              size: 20,
              color: Colors.grey.shade600,
            ),
            filled: true,
            fillColor: readOnly
                ? const Color(0xFFEEEEEE)
                : Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color(0xFFE0E0E0),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color(0xFFE0E0E0),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: AppColors.themeColor,
                width: 1.5,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Colors.red,
              ),
            ),
          ),
        ),
      ],
    );
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F8),

      appBar: AppBar(
        title: const Text(
          'Personal Information',
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.themeColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),

      body: Consumer<ProfileProvider>(
        builder: (context, provider, child) {

          // Initial Loading

          if (provider.isLoading &&
              provider.profileData == null) {
            return Center(
              child: CircularProgressIndicator(
                color: AppColors.themeColor,
              ),
            );
          }

          // Error State

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
                      provider.errorMessage ??
                          'Unable to load profile',
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

                  // Header

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [

                        CircleAvatar(
                          radius: 35,
                          backgroundColor:
                          AppColors.themeColor.withValues(alpha: 0.1),
                          child: Icon(
                            Icons.person_outline,
                            size: 38,
                            color: AppColors.themeColor,
                          ),
                        ),

                        const SizedBox(height: 12),

                        const Text(
                          'Personal Details',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        const SizedBox(height: 4),

                        Text(
                          'Update your personal information',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Form Title

                  const Text(
                    'Basic Information',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 16),

                  // First Name

                  _buildTextField(
                    label: 'First Name',
                    hint: 'Enter your first name',
                    controller: _firstNameController,
                    icon: Icons.person_outline,
                  ),

                  const SizedBox(height: 16),

                  // Last Name

                  _buildTextField(
                    label: 'Last Name',
                    hint: 'Enter your last name',
                    controller: _lastNameController,
                    icon: Icons.person_outline,
                  ),

                  const SizedBox(height: 16),

                  // Email

                  _buildTextField(
                    label: 'Email Address',
                    hint: 'Your email address',
                    controller: _emailController,
                    icon: Icons.email_outlined,
                    readOnly: true,
                    keyboardType: TextInputType.emailAddress,
                  ),

                  const SizedBox(height: 16),

                  // Phone

                  _buildTextField(
                    label: 'Phone Number',
                    hint: 'Enter your phone number',
                    controller: _phoneController,
                    icon: Icons.phone_outlined,
                    keyboardType: TextInputType.phone,
                  ),

                  const SizedBox(height: 16),

                  // City

                  _buildTextField(
                    label: 'City',
                    hint: 'Enter your city',
                    controller: _cityController,
                    icon: Icons.location_city_outlined,
                  ),

                  const SizedBox(height: 28),

                  // Update Button

                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: provider.isUpdating
                          ? null
                          : _updateProfile,

                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.themeColor,
                        foregroundColor: Colors.white,
                        disabledBackgroundColor:
                        AppColors.themeColor.withValues(alpha: 0.6),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),

                      child: provider.isUpdating
                          ? const SizedBox(
                        height: 22,
                        width: 22,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.5,
                          color: Colors.white,
                        ),
                      )
                          : const Text(
                        'Update Profile',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
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
