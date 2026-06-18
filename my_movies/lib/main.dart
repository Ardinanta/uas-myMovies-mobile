import 'package:flutter/material.dart';

import 'app.dart';
import 'injection.dart';

void main() {
  configureDependencies();
  runApp(const MyMoviesApp());
}
