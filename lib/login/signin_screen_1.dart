import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Hello Again!",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Welcome back, you've been missed!",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 30),
            CustomTextField(hint: "Enter username"),
            SizedBox(height: 10),
            CustomTextField(hint: "Password", obscureText: true),
            SizedBox(height: 10),
            Text(
              "Recovery Password",
              style: TextStyle(
                color: Colors.blue,
                decoration: TextDecoration.underline,
              ),
            ),
            SizedBox(height: 20),
            AuthButton(text: "Sign In", isPrimary: true),
            SizedBox(height: 20),
            SocialLogins(),
            SizedBox(height: 20),
            Text.rich(
              TextSpan(
                text: "Not a member? ",
                style: TextStyle(color: Colors.grey),
                children: [
                  TextSpan(
                    text: "Register now",
                    style: TextStyle(color: Colors.blue),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String hint;
  final bool obscureText;

  const CustomTextField(
      {Key? key, required this.hint, this.obscureText = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        filled: true,
        fillColor: Colors.grey[200],
      ),
    );
  }
}

class AuthButton extends StatelessWidget {
  final String text;
  final bool isPrimary;

  const AuthButton({Key? key, required this.text, this.isPrimary = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isPrimary ? Colors.red : Colors.white,
          foregroundColor: isPrimary ? Colors.white : Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () {},
        child: Text(text),
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
        SocialLoginButton(icon: Icons.apple, color: Colors.black),
        SizedBox(width: 10),
        SocialLoginButton(icon: FontAwesomeIcons.google, color: Colors.black),
        SizedBox(width: 10),
        SocialLoginButton(icon: Icons.facebook, color: Colors.blue),
      ],
    );
  }
}

class SocialLoginButton extends StatelessWidget {
  final IconData icon;
  final Color? color;

  const SocialLoginButton({super.key, required this.icon, this.color});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 25,
      backgroundColor: Colors.grey[200],
      child: Icon(
        icon,
        color: color,
      ),
    );
  }
}
