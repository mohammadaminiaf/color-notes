import 'package:flutter/material.dart';

import '/auth/google_auth.dart';
import '/models/user.dart';
import '/widgets/loader.dart';
import '/widgets/user_profile_pic.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    super.key,
    required this.name,
    required this.email,
    required this.imageUrl,
  });

  final String? imageUrl;
  final String? name;
  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: GoogleAuth().getCurrentUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loader();
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
