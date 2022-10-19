import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import '/ui/helpers/models/custom_image_with_sizes.dart';
import 'package:flutter/material.dart';

//if classed or widget need to calculate original size of image and return it with image provider, they can-should use this mixin
mixin ImageSizeCalculator {
  Future<SizedImage> getImageAndSize(String imageUrl) {
    Completer<SizedImage> completer = Completer();
    final networkImage = CachedNetworkImageProvider(imageUrl);

    networkImage.resolve(const ImageConfiguration()).addListener(
      ImageStreamListener(
        (ImageInfo image, bool synchronousCall) {
          var myImage = image.image;
          Size size = Size(myImage.width.toDouble(), myImage.height.toDouble());
          completer.complete(
            SizedImage(image: networkImage, originalSize: size),
          );
        },
      ),
    );

    return completer.future;
  }
}
