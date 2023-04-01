// 🎯 Dart imports:

// 🎯 Dart imports:
import 'dart:async';

// 📦 Package imports:
import 'package:flutter_android_volume_keydown/flutter_android_volume_keydown.dart';

class HandleVolumeController {
  StreamSubscription<HardwareButton>? handleVolumeButton;

  bool isDisabled = true;

  final List<Function(HardwareButton)> handlers = [];

  void addHandler(Function(HardwareButton) handler) {
    handlers.add(handler);
  }

  void removeHandler(Function(HardwareButton) handler) {
    handlers.remove(handler);
  }

  void pause() {
    handleVolumeButton?.cancel();
  }

  void resume() {
    if (isDisabled) {
      return;
    }
    handleVolumeButton?.cancel();
    handleVolumeButton = FlutterAndroidVolumeKeydown.stream.listen((value) {
      for (var element in handlers) {
        element(value);
      }
    });
  }

  void disable() {
    isDisabled = true;
    pause();
  }

  void enable() {
    isDisabled = false;
    resume();
  }

  void dispose() {
    handleVolumeButton?.cancel();
  }
}
