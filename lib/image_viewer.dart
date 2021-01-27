import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ImageViewPage extends StatefulWidget {
  ImageViewPage(
      {this.imageData, this.byteData, this.dataGridHeight, this.dataGridWidth});
  final Uint8List imageData;
  final ByteData byteData;
  final double dataGridHeight;
  final double dataGridWidth;

  @override
  _ImageViewPageState createState() => _ImageViewPageState();
}

class _ImageViewPageState extends State<ImageViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('DataGrid Image'),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
              height: widget.dataGridHeight,
              width: widget.dataGridWidth,
              child: Image.memory(
                widget.imageData,
              )),
        ),
      ),
    );
  }
}
