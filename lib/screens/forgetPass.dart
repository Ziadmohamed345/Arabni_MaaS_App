import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _mobileController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Regular expression pattern for Egyptian mobile numbers
  static final RegExp _egyptMobileRegex = RegExp(r'^(01[0-2]|015)[0-9]{8}$');

  // Function to handle sending verification code
  Future<void> _sendVerificationCode(
      BuildContext context, String mobile) async {
    if (!_egyptMobileRegex.hasMatch(mobile)) {
      // Show error message if the mobile number is not valid
      showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            title: const Text("Error"),
            content: const Text("Please enter a valid Egyptian mobile number."),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                },
                child: const Text("OK"),
              ),
            ],
          );
        },
      );
      return;
    }

    try {
      // Simulate sending a verification code via SMS
      // In a real app, you would use a service like Twilio to send SMS
      print('Sending verification code to $mobile');

      // Show a success message or navigate to a confirmation page
      showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            title: const Text("Verification Code Sent"),
            content: const Text(
              "A verification code has been sent to your mobile number.",
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                },
                child: const Text("OK"),
              ),
            ],
          );
        },
      );
    } catch (error) {
      // Handle errors, show error message to user
      showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            title: const Text("Error"),
            content: Text(error.toString()),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                },
                child: const Text("OK"),
              ),
            ],
          );
        },
      );
    }
  }

  // Function to validate and submit the login form
  void _submitForm(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final mobile = _mobileController.text.trim();
      // Call function to handle sending verification code
      _sendVerificationCode(context, mobile);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _mobileController,
                decoration: const InputDecoration(labelText: 'Mobile Number'),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your mobile number.';
                  } else if (!_egyptMobileRegex.hasMatch(value)) {
                    return 'Please enter a valid Egyptian mobile number.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () => _submitForm(context),
                child: const Text('Send Verification Code'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
