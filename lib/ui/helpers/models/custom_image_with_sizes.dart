import 'package:flutter/material.dart';

//helper model to ui for keeping size adn provider of image we got as a result
class SizedImage {
  final Size originalSize;
  final ImageProvider image;

  SizedImage({required this.originalSize, required this.image});
}
