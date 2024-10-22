import 'dart:convert';
import 'package:claimitproject/backend/auth_service.dart';
import 'package:claimitproject/screens/AdminForm.dart';
import 'package:claimitproject/screens/HomePage.dart'; // Import HomePage
import 'package:claimitproject/screens/SignUpForm.dart';
import 'package:claimitproject/ui_helper/genLoginSignupHeader.dart';
import 'package:claimitproject/ui_helper/genTextFormField.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  Future<void> login(String email, String password) async {
    setState(() {
      _isLoading = true;
    });

    try {
      var url = Uri.parse('http://10.0.2.2:8000/api/login/');
      var response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email, "password": password}),
      );

      setState(() {
        _isLoading = false;
      });

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        String token = data['access'];
        await saveToken(token);
        String username = data['username']; // Extract username

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => HomePage(username: username)),
          (Route<dynamic> route) => false,
        );
      } else {
        var errorData = jsonDecode(response.body);
        String errorMessage = errorData['detail'] ?? "Login failed.";
        _showErrorDialog(errorMessage);
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      _showErrorDialog("An error occurred. Please try again.");
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('ClaimIt KMITL: Lost and Found App'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _formKey, // Ensure form is correctly linked
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                genLoginSignUpHeader(),
                GetTextFormField(
                  controller: _emailController,
                  icon: Icons.email,
                  hintName: 'Email',
                ),
                SizedBox(height: 5.0),
                GetTextFormField(
                  controller: _passwordController,
                  icon: Icons.lock,
                  hintName: 'Password',
                  isObscureText: true,
                ),
                _isLoading
                    ? CircularProgressIndicator()
                    : Container(
                        margin: EdgeInsets.all(30.0),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: TextButton(
                          onPressed: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              login(
                                _emailController.text,
                                _passwordController.text,
                              );
                            }
                          },
                          child: Text(
                            'Login',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Does not have an account yet?'),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => SignUpForm()));
                      },
                      child: Text('Sign up'),
                    )
                  ],
                ),
                TextButton(
                  child: Text(
                    'I am admin',
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (_) => AdminForm()));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
