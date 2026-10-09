import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'User Registration',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
        ),
        useMaterial3: true,
      ),
      home: const RegistrationScreen(),
    );
  }
}

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() =>
      _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _acceptTerms = false;
  String _selectedRole = 'Student';

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _register() {
    if (_formKey.currentState!.validate()) {
      if (!_acceptTerms) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Please accept the Terms and Conditions.',
            ),
            backgroundColor: Colors.redAccent,
          ),
        );
        return;
      }

      print('Full Name: ${_nameController.text}');
      print('Email: ${_emailController.text}');
      print('Password: ${_passwordController.text}');
      print('Role: $_selectedRole');
      print('Terms accepted: $_acceptTerms');

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Registration successful!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 241, 244, 255),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: Card(
                elevation: 5,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Form(
                    key: _formKey,
                    autovalidateMode:
                        AutovalidateMode.onUserInteraction,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const CircleAvatar(
                          radius: 35,
                          backgroundColor: Color.fromARGB(255, 241, 244, 255),
                          child: Icon(
                            Icons.person_add_alt_1,
                            size: 36,
                            color: Colors.indigo,
                          ),
                        ),

                        const SizedBox(height: 16),

                        const Text(
                          'Create Account',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 32, 44, 82),
                          ),
                        ),

                        const SizedBox(height: 8),

                        const Text(
                          'Fill in your details to get started',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),

                        const SizedBox(height: 28),

                        const Text(
                          'Full Name',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        const SizedBox(height: 8),

                        TextFormField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            hintText: 'Enter your full name',
                            prefixIcon: const Icon(Icons.person_outline),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          validator: (value) {
                            if (value == null ||
                                value.trim().isEmpty) {
                              return 'Please enter your full name';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 18),

                        const Text(
                          'Email',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        const SizedBox(height: 8),

                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: 'name@narxoz.kz',
                            prefixIcon: const Icon(Icons.email_outlined),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          validator: (value) {
                            if (value == null ||
                                value.trim().isEmpty) {
                              return 'Please enter your email';
                            }

                            if (!value.contains('@') ||
                                !value.contains('.')) {
                              return 'Email must contain @ and .';
                            }

                            return null;
                          },
                        ),

                        const SizedBox(height: 18),

                        const Text(
                          'Password',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        const SizedBox(height: 8),

                        TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: 'At least 6 characters',
                            prefixIcon: const Icon(Icons.lock_outline),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a password';
                            }

                            if (value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }

                            return null;
                          },
                        ),

                        const SizedBox(height: 18),

                        const Text(
                          'Confirm Password',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        const SizedBox(height: 8),

                        TextFormField(
                          controller: _confirmPasswordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: 'Repeat your password',
                            prefixIcon: const Icon(Icons.lock_reset),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please confirm your password';
                            }

                            if (value != _passwordController.text) {
                              return 'Passwords do not match';
                            }

                            return null;
                          },
                        ),

                        const SizedBox(height: 18),

                        const Text(
                          'Select Your Role',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        const SizedBox(height: 8),

                        DropdownButtonFormField<String>(
                          value: _selectedRole,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.work_outline),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          items: const [
                            DropdownMenuItem(
                              value: 'Student',
                              child: Text('Student'),
                            ),
                            DropdownMenuItem(
                              value: 'Teacher',
                              child: Text('Teacher'),
                            ),
                            DropdownMenuItem(
                              value: 'Developer',
                              child: Text('Developer'),
                            ),
                          ],
                          onChanged: (value) {
                            if (value != null) {
                              setState(() {
                                _selectedRole = value;
                              });
                            }
                          },
                        ),

                        const SizedBox(height: 12),

                        CheckboxListTile(
                          value: _acceptTerms,
                          onChanged: (value) {
                            setState(() {
                              _acceptTerms = value ?? false;
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                          contentPadding: EdgeInsets.zero,
                          title: const Text(
                            'I accept the Terms and Conditions',
                            style: TextStyle(fontSize: 13),
                          ),
                          activeColor: Colors.indigo,
                        ),

                        const SizedBox(height: 16),

                        ElevatedButton(
                          onPressed: _register,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.indigo,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              vertical: 16,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Create Account',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
