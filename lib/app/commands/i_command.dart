import 'dart:async';
import 'package:flutter/foundation.dart';

//this is base class for command classes, every command need to extend from this class
abstract class ICommand {
  //this method check if we can execute the code
  //user params to pass data to command
  @protected
  FutureOr<bool> canExecute(Map? params);
  @protected
  void execute(Map? params);

  void doExecute(Map params) async {
    final canExec = await canExecute(params);
    if (canExec) execute(params);
  }
}
