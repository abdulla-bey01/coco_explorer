import 'package:flutter/material.dart';

//implement this class if need initialize class data intead of initialize it in constructor
abstract class Initializable {
  @protected
  void initialize([dynamic args]);
}
