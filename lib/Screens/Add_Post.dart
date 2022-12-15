import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// import '../Models/User.dart';
import '../Backend/FireStore.dart';
import '../Utils/Utils.dart';
import '../Widgets/Text_Field_Input.dart';

class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _placeController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  Uint8List? _image;
  bool isLoading = false;
  var userData = {};
  bool isLoad = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      isLoad = true;
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
      isLoad = false;
    });
  }

  selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    // set state because we need to display the image we selected on the circle avatar
    setState(() {
      _image = im;
    });
  }

  void post(String uid, String username, String profImage) async {
    setState(() {
      isLoading = true;
    });
    // start the loading
    try {
      // upload to storage and db
      String res = await FireStoreMethods().uploadPost(
        _descriptionController.text,
        _image!,
        uid,
        username,
        profImage,
        _priceController.text,
        _placeController.text,
        _phoneNumberController.text,
      );
      if (res == "success") {
        setState(() {
          isLoading = false;
        });
        showSnackBar(
          context,
          'Posted!',
        );
        clearImage();
        _descriptionController.clear();
        _phoneNumberController.clear();
        _placeController.clear();
        _priceController.clear();
      } else {
        showSnackBar(context, res);
      }
    } catch (err) {
      setState(() {
        isLoading = false;
      });
      showSnackBar(
        context,
        err.toString(),
      );
      print(_priceController.text);
    }
  }

  void clearImage() {
    setState(() {
      _image = null;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _descriptionController.dispose();
    _phoneNumberController.dispose();
    _placeController.dispose();
    _priceController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderSide: Divider.createBorderSide(context),
    );

    return isLoad
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: const Text('Add Post'),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  isLoading
                      ? const LinearProgressIndicator()
                      : Container(
                          padding: const EdgeInsets.symmetric(horizontal: 32),
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Flexible(
                              //   child: Container(),
                              //   flex: 1,
                              // ),
                              const SizedBox(
                                height: 10,
                              ),
                              Stack(
                                children: [
                                  // CircleAvatar(
                                  //         radius: 64,
                                  //         backgroundImage: MemoryImage(_image!),
                                  //         backgroundColor: Colors.red,
                                  //       ),
                                  _image != null
                                      ? Container(
                                          height: 150,
                                          width: double.infinity,
                                          // color: Colors.blueAccent,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                            fit: BoxFit.fill,
                                            // alignment: FractionalOffset.topCenter,
                                            image: MemoryImage(_image!),
                                          )),
                                        )
                                      : Container(
                                          height: 200,
                                          width: double.infinity,
                                          // color: Colors.blueAccent,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                            fit: BoxFit.fill,
                                            // alignment: FractionalOffset.topCenter,
                                            image: NetworkImage(
                                                'https://images.greetingsisland.com/images/cards/upload%20your%20own/previews/upload-your-own-design_1.png?auto=format,compress&w=440'),
                                          )),
                                        ),
                                  Positioned(
                                    bottom: 50,
                                    left: 30,
                                    child: IconButton(
                                      iconSize: 80,
                                      onPressed: selectImage,
                                      icon: const Icon(Icons.add_a_photo),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextFieldInput(
                                hintText: 'Price',
                                textInputType: TextInputType.emailAddress,
                                textEditingController: _priceController,
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              TextFieldInput(
                                hintText: 'Place',
                                textInputType: TextInputType.text,
                                textEditingController: _placeController,
                                // isPass: true,
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              TextFieldInput(
                                hintText: 'Phone Number',
                                textInputType: TextInputType.text,
                                textEditingController: _phoneNumberController,
                                // isPass: true,
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              // TextField(
                              //   controller: _descriptionController,
                              //   decoration: const InputDecoration(
                              //       hintText: "Description", border: InputBorder.none),
                              //   maxLines: 8,
                              // ),
                              Container(
                                decoration: BoxDecoration(border: Border.all()),
                                child: TextField(
                                  controller: _descriptionController,
                                  maxLines: 8,
                                  // expands: true,
                                  decoration: InputDecoration(
                                    hintText: 'Description',
                                    border: inputBorder,
                                    focusedBorder: inputBorder,
                                    enabledBorder: inputBorder,
                                    filled: true,
                                    contentPadding: const EdgeInsets.all(8),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              TextButton(
                                onPressed: () => post(
                                  userData['uid'],
                                  userData['username'],
                                  userData['photoUrl'],
                                ),
                                child: const Text(
                                  "Post",
                                  style: TextStyle(
                                      color: Colors.blueAccent,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0),
                                ),
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                            ],
                          ),
                        ),
                ],
              ),
            ),
          );
  }
}
