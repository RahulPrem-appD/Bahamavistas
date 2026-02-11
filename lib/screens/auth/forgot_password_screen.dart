import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../theme/colors.dart';
import '../../widgets/bahama_button.dart';
import '../../widgets/bahama_text_field.dart';
import '../../providers/auth_provider.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  final _codeController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  int _step = 0; // 0: email, 1: code, 2: new password
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _codeController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleSendCode() async {
    final email = _emailController.text.trim();
    if (email.isEmpty || !email.contains('@')) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid email address')),
      );
      return;
    }

    final auth = context.read<AuthProvider>();
    final success = await auth.forgotPassword(email);

    if (!mounted) return;

    if (success) {
      setState(() => _step = 1);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Reset code sent to your email')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(auth.error ?? 'Failed to send reset code')),
      );
      auth.clearError();
    }
  }

  Future<void> _handleVerifyCode() async {
    final code = _codeController.text.trim();
    if (code.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter the reset code')),
      );
      return;
    }

    final auth = context.read<AuthProvider>();
    final success = await auth.verifyResetCode(_emailController.text.trim(), code);

    if (!mounted) return;

    if (success) {
      setState(() => _step = 2);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(auth.error ?? 'Invalid code')),
      );
      auth.clearError();
    }
  }

  Future<void> _handleResetPassword() async {
    final password = _newPasswordController.text;
    final confirm = _confirmPasswordController.text;

    if (password.length < 8) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password must be at least 8 characters')),
      );
      return;
    }

    if (password != confirm) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match')),
      );
      return;
    }

    final auth = context.read<AuthProvider>();
    final success = await auth.resetPassword(
      _emailController.text.trim(),
      _codeController.text.trim(),
      password,
    );

    if (!mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password reset successfully. Please log in.')),
      );
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(auth.error ?? 'Failed to reset password')),
      );
      auth.clearError();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: BahamaColors.seaGradient,
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.arrow_back_ios_rounded,
                        color: BahamaColors.deepTeal,
                      ),
                    ),
                    const Expanded(
                      child: Text(
                        'Reset Password',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: BahamaColors.deepTeal,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(width: 48),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      const SizedBox(height: 40),
                      Icon(
                        _step == 0
                            ? Icons.email_outlined
                            : _step == 1
                                ? Icons.pin_outlined
                                : Icons.lock_reset_rounded,
                        size: 64,
                        color: BahamaColors.islandBlue,
                      ),
                      const SizedBox(height: 24),
                      Text(
                        _step == 0
                            ? 'Enter your email'
                            : _step == 1
                                ? 'Enter reset code'
                                : 'Create new password',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: BahamaColors.deepTeal,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _step == 0
                            ? 'We\'ll send a reset code to your email'
                            : _step == 1
                                ? 'Check your email for the 6-digit code'
                                : 'Enter your new password below',
                        style: const TextStyle(
                          fontSize: 15,
                          color: BahamaColors.greyPrimary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 40),
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: BahamaColors.whiteSand,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: BahamaColors.deepTeal.withOpacity(0.08),
                              blurRadius: 24,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            if (_step == 0) ...[
                              BahamaTextField(
                                controller: _emailController,
                                labelText: 'Email',
                                hintText: 'Enter your email',
                                prefixIcon: Icons.email_outlined,
                                keyboardType: TextInputType.emailAddress,
                              ),
                              const SizedBox(height: 24),
                              Consumer<AuthProvider>(
                                builder: (context, auth, _) {
                                  return BahamaButton(
                                    text: 'Send Reset Code',
                                    isLoading: auth.isLoading,
                                    onPressed: _handleSendCode,
                                  );
                                },
                              ),
                            ] else if (_step == 1) ...[
                              BahamaTextField(
                                controller: _codeController,
                                labelText: 'Reset Code',
                                hintText: 'Enter 6-digit code',
                                prefixIcon: Icons.pin_outlined,
                                keyboardType: TextInputType.number,
                              ),
                              const SizedBox(height: 24),
                              Consumer<AuthProvider>(
                                builder: (context, auth, _) {
                                  return BahamaButton(
                                    text: 'Verify Code',
                                    isLoading: auth.isLoading,
                                    onPressed: _handleVerifyCode,
                                  );
                                },
                              ),
                            ] else ...[
                              BahamaTextField(
                                controller: _newPasswordController,
                                labelText: 'New Password',
                                hintText: 'Enter new password',
                                prefixIcon: Icons.lock_outline,
                                obscureText: _obscurePassword,
                                suffixIcon: _obscurePassword
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                onSuffixTap: () {
                                  setState(() => _obscurePassword = !_obscurePassword);
                                },
                              ),
                              const SizedBox(height: 20),
                              BahamaTextField(
                                controller: _confirmPasswordController,
                                labelText: 'Confirm Password',
                                hintText: 'Confirm new password',
                                prefixIcon: Icons.lock_outline,
                                obscureText: _obscureConfirmPassword,
                                suffixIcon: _obscureConfirmPassword
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                onSuffixTap: () {
                                  setState(() => _obscureConfirmPassword = !_obscureConfirmPassword);
                                },
                              ),
                              const SizedBox(height: 24),
                              Consumer<AuthProvider>(
                                builder: (context, auth, _) {
                                  return BahamaButton(
                                    text: 'Reset Password',
                                    isLoading: auth.isLoading,
                                    onPressed: _handleResetPassword,
                                  );
                                },
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
