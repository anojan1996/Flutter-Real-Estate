import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:real_estate/Screens/Notification.dart';

import '../Backend/FireStore.dart';
import '../Utils/Utils.dart';

class PostCard extends StatefulWidget {
  final snap;
  const PostCard({
    Key? key,
    required this.snap,
  }) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isLikeAnimating = false;

   deletePost(String postId) async {
    try {
      await FireStoreMethods().deletePost(postId);
    } catch (err) {
      showSnackBar(
        context,
        err.toString(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() {
        Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Demo(docToEdit: widget.snap,),));
      }),
      child: Container(
        // boundary needed for web
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.lightBlueAccent,
          ),
          color: const Color.fromARGB(255, 177, 209, 236),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 10,
        ),
        child: Column(
          children: [
            // HEADER SECTION OF THE POST
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 4,
                horizontal: 16,
              ).copyWith(right: 0),
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    radius: 16,
                    backgroundImage: NetworkImage(
                      widget.snap['profImage'].toString(),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 8,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            widget.snap['username'].toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  widget.snap['uid'].toString() == FirebaseAuth.instance.currentUser!.uid
                    ? IconButton(
                        onPressed: () {
                          showDialog(
                            useRootNavigator: false,
                            context: context,
                            builder: (context) {
                              return Dialog(
                                child: ListView(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16),
                                    shrinkWrap: true,
                                    children: [
                                      'Delete',
                                    ]
                                        .map(
                                          (e) => InkWell(
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 12,
                                                        horizontal: 16),
                                                child: Text(e),
                                              ),
                                              onTap: () {
                                                deletePost(
                                                  widget.snap['postId']
                                                      .toString(),
                                                );
                                                // remove the dialog box
                                                Navigator.of(context).pop();
                                              }),
                                        )
                                        .toList()),
                              );
                            },
                          );
                        },
                        icon: const Icon(Icons.more_vert),
                      )
                    : Container(),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.35,
              width: double.infinity,
              child: Image.network(
                widget.snap['postUrl'].toString(),
                fit: BoxFit.cover,
              ),
            ),
            // LIKE, COMMENT SECTION OF THE POST
            // Row(
            //   children: <Widget>[
            //     Expanded(
            //       child: Align(
            //         alignment: Alignment.center,
            //         child: IconButton(
            //             icon: const Icon(
            //               Icons.favorite,
            //             ),
            //             color: Colors.white70,
            //             onPressed: (() {})),
            //       ),
            //     ),
            //   ],
            // ),
            const SizedBox(height: 10,),
            Text(
              'Place : ${widget.snap['place'].toString()}',
               style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10,),
            Text(
              // '${widget.snap['likes'].length} likes',
              'Price : Rs. ${widget.snap['price'].toString()}.00',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10,),
            Text(
              DateFormat.yMMMd().format(widget.snap['datePublished'].toDate()),
               style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            // Container(
            //   padding: const EdgeInsets.symmetric(
            //     vertical: 4,
            //     horizontal: 16,
            //   ).copyWith(right: 0),
            //   child: Row(
            //     children: <Widget>[
            //       Text(
            //         widget.snap['place'].toString(),
            //       ),
            //       Expanded(
            //         child: Padding(
            //           padding: const EdgeInsets.only(
            //             left: 8,
            //           ),
            //           child: Column(
            //             mainAxisSize: MainAxisSize.min,
            //             crossAxisAlignment: CrossAxisAlignment.end,
            //             children: <Widget>[
            //               Text(
            //                 // '${widget.snap['likes'].length} likes',
            //                 widget.snap['price'].toString(),
            //                 style: const TextStyle(
            //                   fontWeight: FontWeight.bold,
            //                 ),
            //               ),
            //             ],
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
    
            // Row(
            //   children: <Widget>[
            //     Expanded(
            //       child: Align(
            //         alignment: Alignment.topLeft,
            //          child: Text(
            //           DateFormat.yMMMd()
            //               .format(widget.snap['datePublished'].toDate()),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
