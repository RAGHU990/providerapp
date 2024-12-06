import 'dart:io'; // Import this for SocketException
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controllers/auth_controller.dart';
import 'home_screen.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void showSnackBar(String message, {Color backgroundColor = Colors.red}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
        duration: Duration(seconds: 3),
      ),
    );
  }

  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email.';
      
    }
    // Regular expression for validating email format
    String pattern =
        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Please enter a valid email address.';
    }
    return null;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password.';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long.';
    }
    return null;
  }

  void signIn() async {
    if (_formKey.currentState!.validate()) {
      try {
        await Provider.of<AuthController>(context, listen: false)
            .signIn(emailController.text, passwordController.text);
        
        showSnackBar('Sign-in successful!', backgroundColor: Colors.green);
        
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } catch (e) {
        if (e is SocketException) {
          showSnackBar('No internet connection. Please try again.');
        } else {
          showSnackBar(e.toString());
        }
      }
    }
  }

  void signUp() async {
    if (_formKey.currentState!.validate()) {
      try {
        await Provider.of<AuthController>(context, listen: false)
            .signUp(emailController.text, passwordController.text);
        
        showSnackBar('Sign-up successful!', backgroundColor: Colors.green);
        
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } catch (e) {
        if (e is SocketException) {
          showSnackBar('No internet connection. Please try again.');
        } else {
          showSnackBar(e.toString());
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Supabase Authentication')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: emailValidator,
              ),
              TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: passwordValidator,
              ),
              const SizedBox(height: 20),
              ElevatedButton(onPressed: signUp, child: const Text('Sign Up')),
              ElevatedButton(onPressed: signIn, child: const Text('Sign In')),
            ],
          ),
        ),
      ),
    );
  }
}