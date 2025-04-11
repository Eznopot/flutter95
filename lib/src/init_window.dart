import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_acrylic/window.dart' as Acrylic;
import 'package:window_manager/window_manager.dart';

class Flutter95Window {
  static Future<void> init() async {
    await windowManager.ensureInitialized();

    WindowOptions windowOptions = const WindowOptions(
      center: true,
      backgroundColor: Colors.transparent,
      skipTaskbar: false,
      titleBarStyle: TitleBarStyle.hidden,
      windowButtonVisibility: false,
    );

    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.setAsFrameless();
      await windowManager.show();
      await windowManager.focus();
    });

    await Acrylic.Window.initialize();
    await Acrylic.Window.hideWindowControls();
    if (Platform.isMacOS) {
      await Acrylic.Window.hideTitle();
      await Acrylic.Window.disableShadow();
      await Acrylic.Window.invalidateShadows();
      await Acrylic.Window.removeToolbar();
    }
    Acrylic.Window.makeWindowFullyTransparent();
  }
}
