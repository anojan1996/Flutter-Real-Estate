import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:real_estate/Screens/Add_Post.dart';

import '../Screens/Post.dart';
import '../Screens/Profile_Screen.dart';
import '../Screens/Notification.dart';

showSnackBar(BuildContext context, String text) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );
}

List<Widget> homeScreenItems = [
  const Post(),
  const Text('Search Screen'),
  const AddPost(),
  const Text('Likes'),
  const ProfileScreen(),
];

pickImage(ImageSource source) async {
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _file = await _imagePicker.pickImage(source: source);
  if (_file != null) {
    return await _file.readAsBytes();
  }
  print('No Image Selected');
}