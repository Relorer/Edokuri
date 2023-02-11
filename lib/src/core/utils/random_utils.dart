import 'dart:math';

double doubleInRange(Random source, double start, double end) =>
    source.nextDouble() * (end - start) + start;
