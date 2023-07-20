import 'package:color_notes/constansts/user.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    super.key,
    required this.name,
    required this.email,
    required this.imageUrl,
  });

  final String imageUrl;
  final String name;
  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(36.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(dummyUser!.photoUrl ?? ''),
              ),
              const SizedBox(height: 20),
              Text(dummyUser!.displayName!),
              const SizedBox(height: 20),
              Text(dummyUser!.email),
              const SizedBox(height: 20, width: double.infinity),
            ],
          ),
        ),
      ),
    );
  }
}
