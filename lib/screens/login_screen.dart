import 'package:flutter/material.dart';

import '/auth/google_auth.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(width: double.infinity),
          ElevatedButton(
            onPressed: () async {
              await GoogleAuth().signInWithGoogle();
            },
            child: const Text('Login with Google'),
          ),
        ],
      ),
    );
  }
}
