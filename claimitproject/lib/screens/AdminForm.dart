import 'package:claimitproject/screens/AdminHomePage.dart';
import 'package:claimitproject/ui_helper/genTextFormField.dart';
import 'package:flutter/material.dart';

class AdminForm extends StatefulWidget {
  const AdminForm({super.key});

  @override
  State<AdminForm> createState() => _AdminFormState();
}

class _AdminFormState extends State<AdminForm> {
  final TextEditingController _conVerify = TextEditingController();

  // Define the correct verification code
  final String _correctCode = "admin1234"; // Replace with actual logic if needed

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 35.0),
            Image.asset(
              'assets/images/staff.png',
              height: 150,
            ),
            const SizedBox(height: 35.0),
            GetTextFormField(
              controller: _conVerify,
              hintName: 'Verification Code',
              icon: Icons.description,
              isObscureText: true,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _validateCode();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange, // Set button background color
              ),
              child: const Text('Log in'),
            ),
          ],
        ),
      ),
    );
  }

  // Function to validate the verification code
  void _validateCode() {
    String enteredCode = _conVerify.text.trim();

    if (enteredCode.isEmpty) {
      _showErrorDialog('Verification Code is required.');
    } else if (enteredCode == _correctCode) {
      // Navigate to AdminHome if the code is correct
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const AdminHome()),
        (Route<dynamic> route) => false,
      );
    } else {
      _showErrorDialog('Incorrect Verification Code. Please try again.');
    }
  }

  // Function to show error dialog
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
