import 'package:flutter/material.dart';

import '/models/user.dart';

class UserProfilePic extends StatelessWidget {
  const UserProfilePic({
    super.key,
    required this.user,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    String letter = user.displayName?.substring(0, 1) ?? '';
    return CircleAvatar(
      radius: 50,
      backgroundImage:
          user.profilePicUrl == '' ? null : NetworkImage(user.profilePicUrl!),
      child: user.profilePicUrl == ''
          ? Text(
              letter,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            )
          : null,
    );
  }
}
