import 'package:flutter/material.dart';



class Gif extends StatelessWidget {
  Gif({super.key, this.url});
  Map? url;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(url!.keys.toList()[0]),
      ),
      backgroundColor: Colors.black,
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(url!.values.toList()[0])
          ],
        ),
      ),
    );
  }
}