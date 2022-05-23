import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImagePreview extends StatelessWidget {
  Image image;

  ImagePreview(this.image);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: Image(
          image: image.image,
        ),
      )
    );
  }
}
