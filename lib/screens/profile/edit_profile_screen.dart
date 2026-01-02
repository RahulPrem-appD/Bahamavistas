import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../theme/colors.dart';
import '../../widgets/bahama_button.dart';
import '../../widgets/bahama_text_field.dart';
import '../../utils/constants.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController(text: 'Sarah');
  final _lastNameController = TextEditingController(text: 'Mitchell');
  final _emailController = TextEditingController(text: 'sarah.mitchell@email.com');
  final _phoneController = TextEditingController(text: '+1 (242) 555-0123');
  final _dobController = TextEditingController(text: 'May 15, 1990');
  String _gender = 'Female';

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BahamaColors.offWhiteMist,
      appBar: AppBar(
        backgroundColor: BahamaColors.whiteSand,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_rounded, color: BahamaColors.deepTeal),
        ),
        title: const Text(
          'Edit Profile',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: BahamaColors.deepTeal),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Profile photo
              Stack(
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: BahamaColors.islandBlue, width: 3),
                      boxShadow: [
                        BoxShadow(
                          color: BahamaColors.deepTeal.withOpacity(0.15),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(60),
                      child: CachedNetworkImage(
                        imageUrl: AppImages.avatar1,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          color: BahamaColors.greyLight,
                          child: const Icon(Icons.person, size: 60, color: BahamaColors.islandBlue),
                        ),
                        errorWidget: (context, url, error) => Container(
                          color: BahamaColors.whiteSand,
                          child: const Icon(Icons.person_rounded, size: 60, color: BahamaColors.islandBlue),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: GestureDetector(
                      onTap: () => _showPhotoOptions(context),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          gradient: BahamaColors.ctaGradient,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 3),
                        ),
                        child: const Icon(Icons.camera_alt_rounded, size: 18, color: BahamaColors.deepTeal),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // Form fields
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: BahamaColors.whiteSand,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: BahamaColors.deepTeal.withOpacity(0.06),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: BahamaTextField(
                            controller: _firstNameController,
                            labelText: 'First Name',
                            hintText: 'Enter first name',
                            prefixIcon: Icons.person_outline,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: BahamaTextField(
                            controller: _lastNameController,
                            labelText: 'Last Name',
                            hintText: 'Enter last name',
                            prefixIcon: Icons.person_outline,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    BahamaTextField(
                      controller: _emailController,
                      labelText: 'Email',
                      hintText: 'Enter your email',
                      prefixIcon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 20),
                    BahamaTextField(
                      controller: _phoneController,
                      labelText: 'Phone Number',
                      hintText: 'Enter phone number',
                      prefixIcon: Icons.phone_outlined,
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () => _selectDate(context),
                      child: AbsorbPointer(
                        child: BahamaTextField(
                          controller: _dobController,
                          labelText: 'Date of Birth',
                          hintText: 'Select date',
                          prefixIcon: Icons.cake_outlined,
                          suffixIcon: Icons.calendar_today_outlined,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Gender',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: BahamaColors.deepTeal,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            _GenderOption(
                              label: 'Male',
                              isSelected: _gender == 'Male',
                              onTap: () => setState(() => _gender = 'Male'),
                            ),
                            const SizedBox(width: 12),
                            _GenderOption(
                              label: 'Female',
                              isSelected: _gender == 'Female',
                              onTap: () => setState(() => _gender = 'Female'),
                            ),
                            const SizedBox(width: 12),
                            _GenderOption(
                              label: 'Other',
                              isSelected: _gender == 'Other',
                              onTap: () => setState(() => _gender = 'Other'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Save button
              BahamaButton(
                text: 'Save Changes',
                onPressed: () {
                  _showSuccessSnackbar(context);
                  Navigator.pop(context);
                },
              ),

              const SizedBox(height: 16),

              // Delete account
              TextButton(
                onPressed: () => _showDeleteConfirmation(context),
                child: const Text(
                  'Delete Account',
                  style: TextStyle(color: Colors.red, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showPhotoOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: BahamaColors.whiteSand,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 12),
          Container(width: 40, height: 4, decoration: BoxDecoration(color: BahamaColors.greyLight, borderRadius: BorderRadius.circular(2))),
          const SizedBox(height: 24),
          const Text('Change Profile Photo', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: BahamaColors.deepTeal)),
          const SizedBox(height: 24),
          ListTile(
            leading: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(color: BahamaColors.islandBlue.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
              child: const Icon(Icons.camera_alt_rounded, color: BahamaColors.islandBlue),
            ),
            title: const Text('Take Photo'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(color: BahamaColors.islandBlue.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
              child: const Icon(Icons.photo_library_rounded, color: BahamaColors.islandBlue),
            ),
            title: const Text('Choose from Gallery'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(color: Colors.red.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
              child: const Icon(Icons.delete_outline_rounded, color: Colors.red),
            ),
            title: const Text('Remove Photo', style: TextStyle(color: Colors.red)),
            onTap: () => Navigator.pop(context),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(1990, 5, 15),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: BahamaColors.islandBlue,
              onPrimary: Colors.white,
              surface: BahamaColors.whiteSand,
              onSurface: BahamaColors.deepTeal,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
      setState(() {
        _dobController.text = '${months[picked.month - 1]} ${picked.day}, ${picked.year}';
      });
    }
  }

  void _showSuccessSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.check_circle_rounded, color: Colors.white),
            SizedBox(width: 12),
            Text('Profile updated successfully'),
          ],
        ),
        backgroundColor: BahamaColors.islandBlue,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Delete Account?'),
        content: const Text('This action cannot be undone. All your data will be permanently deleted.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

class _GenderOption extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _GenderOption({required this.label, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            gradient: isSelected ? BahamaColors.ctaGradient : null,
            color: isSelected ? null : BahamaColors.offWhiteMist,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: isSelected ? Colors.transparent : BahamaColors.greyLight),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: BahamaColors.deepTeal,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

