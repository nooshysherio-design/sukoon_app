import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'Signin.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  final TextEditingController _firstname = TextEditingController();
  final TextEditingController _lastname = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _location = TextEditingController();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _age = TextEditingController();

  String? _selectedGender;
  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirm = true;

  @override
  void dispose() {
    _firstname.dispose();
    _lastname.dispose();
    _email.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    _phone.dispose();
    _location.dispose();
    _username.dispose();
    _age.dispose();
    super.dispose();
  }

  Future<void> _signup() async {
    if (!_form.currentState!.validate()) return;

    if (_selectedGender == null) {
      _showSnackbar("Please select a gender.", isError: true);
      return;
    }

    setState(() => _isLoading = true);

    try {
      final response = await http
          .post(
            Uri.parse(
              "http://169.254.23.133/16/sukoon_website/user/signup.php",
            ), // ✅ CHANGE THIS
            headers: {
              "Content-Type": "application/x-www-form-urlencoded", // ✅ ADDED
            },
            body: {
              "firstname": _firstname.text.trim(),
              "lastname": _lastname.text.trim(),
              "username": _username.text.trim(),
              "age": _age.text.trim(),
              "phone_number": _phone.text.trim(),
              "gender": _selectedGender ?? "",
              "location": _location.text.trim(),
              "email": _email.text.trim(),
              "password": _password.text,
            },
          )
          .timeout(const Duration(seconds: 10)); // ✅ ADDED

      print("RESPONSE: ${response.body}"); // ✅ DEBUG

      final data = jsonDecode(response.body);

      if (!mounted) return;

      if (response.statusCode == 200 && data["status"] == "success") {
        _showSnackbar("Account created! Please sign in.", isError: false);

        await Future.delayed(const Duration(seconds: 1));

        if (!mounted) return;

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const Signin()),
        );
      } else {
        _showSnackbar(data["message"] ?? "Signup failed", isError: true);
      }
    } catch (e) {
      print("ERROR: $e"); // ✅ DEBUG
      _showSnackbar("Connection error. Please try again.", isError: true);
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showSnackbar(String message, {required bool isError}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError
            ? Colors.red.shade700
            : const Color(0xFF0D5C63),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFA),
      body: Column(
        children: [
          // ── TOP: Gradient header with logo (matches Figma Rectangle 22) ──
          Container(
            width: double.infinity,
            height: 260,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF0D5C63), // top
                  Color(0xFF247B7B), // middle
                  Color(0xFF44A1A0), // bottom
                ],
                stops: [0.02, 0.47, 0.92],
              ),
            ),
            child: SafeArea(
              child: Center(
                child: Image.asset(
                  "images/logo_white.png",
                  errorBuilder: (context, error, stackTrace) {
                    return Text(
                      "Error: $error",
                    ); // this will show you the exact problem
                  },
                  width: 187,
                  height: 187,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),

          // ── BOTTOM: Scrollable form ──
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 30),
              child: Form(
                key: _form,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // "Sign Up" title
                    const Text(
                      "Sign Up",
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF0D5C63),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Email — full width
                    _buildField(
                      controller: _email,
                      label: "Email",
                      keyboardType: TextInputType.emailAddress,
                      validator: (v) {
                        if (v!.isEmpty) return "Required";
                        if (!v.contains("@")) return "Enter a valid email";
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),

                    // First Name | Last Name
                    Row(
                      children: [
                        Expanded(
                          child: _buildField(
                            controller: _firstname,
                            label: "First Name",
                            validator: (v) => v!.isEmpty ? "Required" : null,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildField(
                            controller: _lastname,
                            label: "Last Name",
                            validator: (v) => v!.isEmpty ? "Required" : null,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Username | Age
                    Row(
                      children: [
                        Expanded(
                          child: _buildField(
                            controller: _username,
                            label: "Username",
                            validator: (v) => v!.isEmpty ? "Required" : null,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildField(
                            controller: _age,
                            label: "Age",
                            keyboardType: TextInputType.number,
                            validator: (v) => v!.isEmpty ? "Required" : null,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Password — full width
                    _buildPasswordField(
                      controller: _password,
                      label: "Password",
                      obscure: _obscurePassword,
                      toggleObscure: () =>
                          setState(() => _obscurePassword = !_obscurePassword),
                      validator: (v) {
                        if (v!.isEmpty) return "Required";
                        if (v.length < 6) return "Minimum 6 characters";
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),

                    // Confirm Password — full width
                    _buildPasswordField(
                      controller: _confirmPassword,
                      label: "Confirm Password",
                      obscure: _obscureConfirm,
                      toggleObscure: () =>
                          setState(() => _obscureConfirm = !_obscureConfirm),
                      validator: (v) {
                        if (v!.isEmpty) return "Required";
                        if (v != _password.text)
                          return "Passwords do not match";
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),

                    // Phone Number | Upload Image
                    Row(
                      children: [
                        Expanded(
                          child: _buildField(
                            controller: _phone,
                            label: "Phone Number",
                            keyboardType: TextInputType.phone,
                            validator: (v) => v!.isEmpty ? "Required" : null,
                          ),
                        ),
                        const SizedBox(width: 12),
                        // "+ Upload Image" button (Figma Frame 17)
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              // TODO: plug in image_picker package here
                            },
                            child: Container(
                              height: 54,
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFFFFA),
                                border: Border.all(
                                  color: const Color(0xFF247B7B),
                                ),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.only(left: 16),
                              child: const Text(
                                "+ Upload Image",
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 14,
                                  color: Color(0xFF0D5C63),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Location | Gender radio buttons
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: _buildField(
                            controller: _location,
                            label: "Location",
                            validator: null, // optional
                          ),
                        ),
                        const SizedBox(width: 12),

                        // Gender section (matches Figma Ellipse 45 & 46)
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Gender:",
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF0D5C63),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  // Female
                                  Radio<String>(
                                    value: "Female",
                                    groupValue: _selectedGender,
                                    activeColor: const Color(0xFF0D5C63),
                                    materialTapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    onChanged: (v) =>
                                        setState(() => _selectedGender = v),
                                  ),
                                  const Text(
                                    "Female",
                                    style: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontSize: 13,
                                      color: Color(0xFF0D5C63),
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  // Male
                                  Radio<String>(
                                    value: "Male",
                                    groupValue: _selectedGender,
                                    activeColor: const Color(0xFF0D5C63),
                                    materialTapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    onChanged: (v) =>
                                        setState(() => _selectedGender = v),
                                  ),
                                  const Text(
                                    "Male",
                                    style: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontSize: 13,
                                      color: Color(0xFF0D5C63),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Create Account button (matches Figma Frame 7)
                    SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF247B7B),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        onPressed: _isLoading ? null : _signup,
                        child: _isLoading
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2.5,
                                ),
                              )
                            : const Text(
                                "Create Account",
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFFFFFFFA),
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // "Already Have An Account? Sign In"
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already Have An Account? ",
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 14,
                            color: Color(0xFF0D5C63),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (_) => const Signin()),
                            );
                          },
                          child: const Text(
                            "Sign In",
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF0D5C63),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Text field styled to match Figma borders ──
  Widget _buildField({
    required TextEditingController controller,
    required String label,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      style: const TextStyle(
        fontFamily: 'Inter',
        fontSize: 14,
        color: Color(0xFF0D5C63),
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(
          fontFamily: 'Inter',
          fontSize: 14,
          color: Color(0xFF0D5C63),
        ),
        filled: true,
        fillColor: const Color(0xFFFFFFFA),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 16,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFF247B7B)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFF0D5C63), width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.red),
        ),
      ),
    );
  }

  // ── Password field with show/hide toggle ──
  Widget _buildPasswordField({
    required TextEditingController controller,
    required String label,
    required bool obscure,
    required VoidCallback toggleObscure,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      validator: validator,
      style: const TextStyle(
        fontFamily: 'Inter',
        fontSize: 14,
        color: Color(0xFF0D5C63),
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(
          fontFamily: 'Inter',
          fontSize: 14,
          color: Color(0xFF0D5C63),
        ),
        filled: true,
        fillColor: const Color(0xFFFFFFFA),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 16,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
            color: const Color(0xFF247B7B),
            size: 20,
          ),
          onPressed: toggleObscure,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFF247B7B)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFF0D5C63), width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.red),
        ),
      ),
    );
  }
}
