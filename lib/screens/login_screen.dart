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
          const Text(
            'Sign In With Google',
            style: TextStyle(
              fontSize: 50,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            width: double.infinity,
            height: 100,
          ),
          Card(
            elevation: 10,
            child: SizedBox(
              height: 60,
              width: 300,
              child: TextButton(
                onPressed: () async {
                  await GoogleAuth().signInWithGoogle();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image.asset(
                      'assets/logos/googlelogo.png',
                      fit: BoxFit.contain,
                    ),
                    const Text(
                      'Login with Google',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                      ),
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
}
