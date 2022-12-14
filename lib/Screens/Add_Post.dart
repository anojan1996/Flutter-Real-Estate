import 'dart:typed_data';

import 'package:flutter/material.dart';

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
  // bool _isLoading = false;

  

  @override
  Widget build(BuildContext context) {
     final inputBorder = OutlineInputBorder(
      borderSide: Divider.createBorderSide(context),
    );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
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
                height: 64,
              ),
              Stack(
                children: [
                  // CircleAvatar(
                  //         radius: 64,
                  //         backgroundImage: MemoryImage(_image!),
                  //         backgroundColor: Colors.red,
                  //       ),
                  Container(
                    height: 200,
                    width: double.infinity,
                    // color: Colors.blueAccent,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      fit: BoxFit.fill,
                      // alignment: FractionalOffset.topCenter,
                      image: NetworkImage(
                          'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
                    )),
                  ),
                  Positioned(
                    bottom: 50,
                    left: 100,
                    child: IconButton(
                      iconSize: 80,
                      onPressed: (() {}),
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
              InkWell(
                  child: Container(
                    child: const Text('Post'),
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: const ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                      ),
                      color: Colors.lightBlue,
                    ),
                  ),
                  onTap: (() {})),
              const SizedBox(
                height: 12,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
