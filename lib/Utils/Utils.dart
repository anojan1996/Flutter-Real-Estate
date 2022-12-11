import 'package:flutter/material.dart';

import '../Screens/Profile_Screen.dart';

showSnackBar(BuildContext context, String text) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );
}

List<Widget> homeScreenItems = [
  const Text('Feed Screen'),
  const Text('Search Screen'),
  const Text('Add Post'),
  const Text('notifications'),
  ProfileScreen(),
];