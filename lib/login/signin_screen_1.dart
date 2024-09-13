import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEBE8F0),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              const Text(
                "Hello Again!",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Welcome back you've been missed!",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 32),
              const CustomTextField(hint: "Enter username"),
              const SizedBox(height: 15),
              const CustomTextField(hint: "Password", obscureText: true),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "Recovery Password",
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              const AuthButton(text: "Sign In"),
              const SizedBox(height: 64),
              const Center(child: Text("Or continue with")),
              const SizedBox(height: 32),
              const SocialLogins(),
              const Spacer(),
              Center(
                child: Text.rich(
                  TextSpan(
                    text: "Not a member? ",
                    style: TextStyle(color: Colors.grey[600]),
                    children: const [
                      TextSpan(
                        text: "Register now",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String hint;
  final bool obscureText;

  const CustomTextField({
    super.key,
    required this.hint,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey[400]),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        suffixIcon: obscureText
            ? Icon(Icons.visibility_off, color: Colors.grey[400])
            : null,
      ),
    );
  }
}

class AuthButton extends StatelessWidget {
  final String text;

  const AuthButton({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xffEC746D),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        onPressed: () {},
        child: Text(text, style: const TextStyle(fontSize: 16)),
      ),
    );
  }
}

class SocialLogins extends StatelessWidget {
  const SocialLogins({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // import 'package:font_awesome_flutter/font_awesome_flutter.dart';
        // Add FontAwesomeIcons to pubspec.yaml
        SocialLoginButton(icon: FontAwesomeIcons.google, color: Colors.red),
        SizedBox(width: 20),
        SocialLoginButton(icon: FontAwesomeIcons.apple, color: Colors.black),
        SizedBox(width: 20),
        SocialLoginButton(icon: FontAwesomeIcons.facebookF, color: Colors.blue),
      ],
    );
  }
}

class SocialLoginButton extends StatelessWidget {
  final IconData icon;
  final Color color;

  const SocialLoginButton({super.key, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Icon(
        icon,
        color: color,
      ),
    );
  }
}
