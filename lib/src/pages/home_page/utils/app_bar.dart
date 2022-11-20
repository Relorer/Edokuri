import 'dart:math';

import 'package:flutter/material.dart';

double getAppBarHeight(BuildContext context) =>
    max((MediaQuery.of(context).size.height - 110) * .35, 200);
