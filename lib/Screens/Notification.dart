import 'package:flutter/material.dart';

class Demo extends StatefulWidget {
  final docToEdit;
  const Demo({super.key, required this.docToEdit});

  @override
  State<Demo> createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Details'),
      ),
      body: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              height: 200,
              width: double.infinity,
              child: Image.network(
                 widget.docToEdit['postUrl'].toString(),
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              color: const Color.fromARGB(255, 206, 217, 226),
              height: 50,
              alignment: Alignment.center,
              child: Text(
               'Place : ${widget.docToEdit['place'].toString()}',
              style: TextStyle(
                fontSize: 20,
                // fontWeight: FontWeight.bold,
              ),
            )
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              color: const Color.fromARGB(255, 206, 217, 226),
              height: 50,
              alignment: Alignment.center,
              child: Text(
              'Price : Rs. ${widget.docToEdit['price'].toString()}.00',
              style: TextStyle(
                fontSize: 20,
                // fontWeight: FontWeight.bold,
              ),
            )
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
             color: const Color.fromARGB(255, 206, 217, 226),
              height: 50,
              alignment: Alignment.center,
              child: Text(
               "Seller's Phone Number : ${widget.docToEdit['phoneNumber'].toString()}",
              style: TextStyle(
                fontSize: 20,
                // fontWeight: FontWeight.bold,
              ),
            )
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              color: const Color.fromARGB(255, 206, 217, 226),
              height: 200,
              alignment: Alignment.center,
              child: Text(
               'Description : ${widget.docToEdit['description'].toString()}',
              style: TextStyle(
                fontSize: 20,
                // fontWeight: FontWeight.bold,
              ),
            )
            ),
          ],
        ),
      ),
    );
  }
}
