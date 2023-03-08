// Dart imports:
import 'dart:math';

// Flutter imports:
import 'package:flutter/material.dart';

double getAppBarHeight(BuildContext context) =>
    max((MediaQuery.of(context).size.height - 110) * .35, 250);
