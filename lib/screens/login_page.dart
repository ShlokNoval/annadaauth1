import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'register_page.dart';
import 'auth_service.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthService _authService = AuthService();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // ✅ Login with Email & Password
  void _loginWithEmail() async {
    UserCredential? user = await _authService.signInWithEmail(
      emailController.text.trim(),
      passwordController.text.trim(),
    );

    if (user != null) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
    } else {
      _showError("Invalid email or password.");
    }
  }

  // ✅ Login with Google
  void _loginWithGoogle() async {
    UserCredential? user = await _authService.signInWithGoogle();
    if (user != null) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
    } else {
      _showError("Google Sign-In failed.");
    }
  }

  // ✅ Error Alert
  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5DC), // Farming Theme
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 🌾 Logo with Shadow + Rounded Corners
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    'assets/annadalogo.png',
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Email Field
              TextField(controller: emailController, decoration: InputDecoration(labelText: "Email")),

              // Password Field
              TextField(controller: passwordController, decoration: InputDecoration(labelText: "Password"), obscureText: true),

              SizedBox(height: 20),

              // Login Button
              ElevatedButton(onPressed: _loginWithEmail, child: Text("Login")),

              // Sign-Up Button
              TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterUserScreen()));
                },
                child: Text("Don't have an account? Sign up"),
              ),

              // OR Divider
              Text("OR"),

              // Google Sign-In
              ElevatedButton(onPressed: _loginWithGoogle, child: Text("Sign in with Google")),
            ],
          ),
        ),
      ),
    );
  }
}
