import 'package:flutter/material.dart';

import '/auth/firestore_auth.dart';
import '/auth/google_auth.dart';
import '/models/user.dart';
import '/screens/login_screen.dart';
import '/widgets/loader.dart';
import '/widgets/user_profile_pic.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: FirestoreAuth().getCurrentUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loader();
          }

          if (!snapshot.hasData) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (_) => const LoginScreen(),
              ),
            );
          }

          final userData = snapshot.data;
          final user = User.fromMap(userData!.data()!);

          return Column(
            children: [
              Expanded(
                flex: 1,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        height: 200,
                        color: Colors.blueAccent,
                      ),
                    ),
                    Positioned(
                      top: 150,
                      left: 100,
                      right: 100,
                      child: UserProfilePic(user: user),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      user.displayName!,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      user.email,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 20, width: double.infinity),
                    ElevatedButton(
                      onPressed: () {
                        GoogleAuth().signOut();
                      },
                      child: const Text('Sign out'),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
