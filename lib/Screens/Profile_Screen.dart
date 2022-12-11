import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Backend/Auth.dart';
import '../Utils/Utils.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var userData = {};
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      User currentuser = FirebaseAuth.instance.currentUser!;
      var userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentuser.uid)
          .get();

      userData = userSnap.data()!;
    } catch (e) {
      showSnackBar(
        context,
        e.toString(),
      );
    }
    print(userData['username']);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return  isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        :Scaffold(
      appBar: AppBar(
        title: Text('Profile Screen'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 64,
                  backgroundImage:
                      NetworkImage('https://i.stack.imgur.com/l60Hf.png'),
                  backgroundColor: Colors.red,
                ),
                SizedBox(
                  width: 60,
                ),
                Column(
                  children: [
                    Text(userData['username']),
                    SizedBox(
                      height: 20,
                    ),
                    Text(userData['email']),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
