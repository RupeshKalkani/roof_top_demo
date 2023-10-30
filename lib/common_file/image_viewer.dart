import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImgViewer extends StatelessWidget {
  final String? image;
  final bool? isFileImg;

  const ImgViewer({super.key, this.image, this.isFileImg});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: isFileImg == true
          ? PhotoView(imageProvider: FileImage(File(image!)))
          : PhotoView(
              imageProvider: CachedNetworkImageProvider(image!),
            ),
    );
  }
}
