import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:inspireme/auth/widgets/textformfield_screen.dart';
import 'package:inspireme/utils/approutes.dart';
import 'auth_services_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _auth = AuthService();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _isLoading = false;
  bool showPassword = false; // State to toggle password visibility

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Color.fromARGB(255, 135, 206, 250)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // App Logo or Title
                  const Text(
                    'InspireMe',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.2,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Create Your Account',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Colors.white70,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  // Form Container
                  Container(
                    padding: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Form(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Name Field
                          const Text(
                            'Name',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextformfieldScreen(
                            hintText: 'Enter your name',
                            hintFontSize: 14,
                            hintFontWeight: FontWeight.w400,
                            color: Colors.grey.shade200,
                            hintTextColor: Colors.grey.shade600,
                            controller: _name,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Name is required';
                              }
                              return null;
                            },
                            borderRadius: 12,
                          ),
                          const SizedBox(height: 16),
                          // Email Field
                          const Text(
                            'Email',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextformfieldScreen(
                            hintText: 'Enter your email',
                            hintFontSize: 14,
                            hintFontWeight: FontWeight.w400,
                            color: Colors.grey.shade200,
                            hintTextColor: Colors.grey.shade600,
                            controller: _email,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Email is required';
                              } else if (!value.contains('@')) {
                                return 'Enter a valid email';
                              }
                              return null;
                            },
                            borderRadius: 12,
                          ),
                          const SizedBox(height: 16),
                          // Password Field
                          const Text(
                            'Password',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextformfieldScreen(
                            hintText: 'Enter your password',
                            hintFontSize: 14,
                            hintFontWeight: FontWeight.w400,
                            color: Colors.grey.shade200,
                            hintTextColor: Colors.grey.shade600,
                            controller: _password,
                            obscureText: !showPassword,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Password is required';
                              } else if (value.length < 6) {
                                return 'Password must be at least 6 characters';
                              }
                              return null;
                            },
                            borderRadius: 12,
                            suffixIconWidget: IconButton(
                              icon: Icon(
                                showPassword ? Icons.visibility : Icons.visibility_off,
                                color: Colors.grey.shade600,
                              ),
                              onPressed: () {
                                setState(() {
                                  showPassword = !showPassword;
                                });
                              },
                            ),
                          ),
                          const SizedBox(height: 24),
                          // Signup Button
                          _isLoading
                              ? const Center(child: CircularProgressIndicator(color: Colors.blue))
                              : ElevatedButton(
                            onPressed: () async {
                              try{
                                await signup();
                              } catch (e, stackTrace) {
                                await FirebaseCrashlytics.instance.recordError(
                                  e,
                                  stackTrace,
                                  reason: 'Logout button failed',
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 5,
                            ),
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          // Login Link
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Already have an account? ',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black87,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, AppRoutes.login);
                                },
                                child: const Text(
                                  'Login',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> signup() async {
    if (_isLoading) return;

    setState(() => _isLoading = true);

    final name = _name.text.trim();
    final email = _email.text.trim();
    final password = _password.text.trim();

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      log('❌ Empty input detected');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
      setState(() => _isLoading = false);
      return;
    }

    try {
      log('🚀 Creating user...');
      final user = await _auth.createUserWithEmailAndPassword(email, password);
      log('✅ User created: ${user?.uid}');

      if (user != null) {
        // Update display name
        await user.updateDisplayName(name);
        await user.reload();

        log('📨 Sending email verification...');
        try {
          await user.sendEmailVerification();
          log('📩 Email verification sent to ${user.email}');
        } on FirebaseAuthException catch (e) {
          if (e.code == 'too-many-requests') {
            log('⛔ Too many requests - Firebase blocked email verification');
            await _auth.signout();
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Too many requests. Please verify your email to continue.'),
                ),
              );
              Navigator.pushReplacementNamed(context, AppRoutes.emailVerification);
            }
            setState(() => _isLoading = false);
            return;
          }
          rethrow;
        }

        await _auth.signout();
        log('✅ Signed out successfully');

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Verification email sent. Please check your inbox.')),
          );
          Navigator.pushReplacementNamed(context, AppRoutes.emailVerification);
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Signup failed. Try again.')),
        );
      }
    } on FirebaseAuthException catch (e) {
      log('⚠️ FirebaseAuthException: ${e.code} - ${e.message}');
      String message = 'Signup failed. Please try again.';
      switch (e.code) {
        case 'email-already-in-use':
          message = 'This email is already registered.';
          break;
        case 'invalid-email':
          message = 'Invalid email format.';
          break;
        case 'weak-password':
          message = 'Password must be at least 6 characters.';
          break;
        case 'too-many-requests':
          message = 'Too many requests. Try again later.';
          break;
        default:
          message = 'Signup error: ${e.message}';
      }
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
      }
    } catch (e) {
      log('❌ Unexpected Error: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Something went wrong. Please try again.')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }
}