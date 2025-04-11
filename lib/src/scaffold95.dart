import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

import 'button95.dart';
import 'globals.dart';
import 'toolbar95.dart';
import 'utils.dart';

class Scaffold95 extends StatelessWidget {
  const Scaffold95({
    super.key,
    required this.title,
    required this.body,
    this.toolbar,
    this.onClosePressed,
    this.onMinimizePressed,
    this.onMaximizePressed,
    this.action,
  });

  final String title;
  final Widget body;
  final bool? action;
  final Toolbar95? toolbar;

  /// Custom behavior of the [CloseButton95]. When [onClosePressed] isn't null,
  /// then the scaffold will include a close button, and clicking it
  /// will call this callback.
  ///
  /// Otherwise, the close button is only shown when the navigator
  /// can be popped, and will automatically call [Navigator.pop] when clicked.
  final void Function(BuildContext)? onClosePressed;

  final void Function(BuildContext)? onMinimizePressed;
  final void Function(BuildContext)? onMaximizePressed;

  @override
  Widget build(BuildContext context) {
    return Elevation95(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          WindowHeader95(
            title: title,
            onClosePressed: onClosePressed,
            onMaximizePressed: onMaximizePressed,
            onMinimizePressed: onMinimizePressed,
            action: action,
          ),
          const SizedBox(height: 4),
          if (toolbar != null) toolbar!,
          if (toolbar != null) const SizedBox(height: 4),
          body,
        ],
      ),
    );
  }
}

class WindowHeader95 extends StatefulWidget {
  const WindowHeader95({
    super.key,
    required this.title,
    this.onClosePressed,
    this.onMinimizePressed,
    this.onMaximizePressed,
    this.action,
  });

  final String? title;
  final bool? action;

  final void Function(BuildContext)? onClosePressed;
  final void Function(BuildContext)? onMinimizePressed;
  final void Function(BuildContext)? onMaximizePressed;

  @override
  State<WindowHeader95> createState() => _WindowHeader95State();
}

class _WindowHeader95State extends State<WindowHeader95> {
  late bool _canPop;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _canPop = widget.action ?? Navigator.of(context).canPop();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.only(top: 2.0, left: 2.0, right: 2.0),
        child: Container(
          height: 33,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Flutter95.headerDark,
                Flutter95.headerLight,
              ],
            ),
          ),
          child: Row(
            children: [
              const SizedBox(width: 8),
              Text(
                widget.title!,
                style: Flutter95.headerTextStyle,
              ),
              const Spacer(),
              if ((widget.action != null && widget.action == true) ||
                  widget.onMaximizePressed != null)
                MinimizeButton95(onPressed: widget.onMaximizePressed),
              const SizedBox(width: 4),
              if ((widget.action != null && widget.action == true) ||
                  widget.onMaximizePressed != null)
                MaximizeButton95(onPressed: widget.onMinimizePressed),
              const SizedBox(width: 8),
              if (widget.onClosePressed != null)
                CloseButton95(onPressed: widget.onClosePressed!)
              else if (_canPop)
                const CloseButton95(),
              const SizedBox(width: 4),
            ],
          ),
        ),
      ),
    );
  }
}

class CloseButton95 extends StatelessWidget {
  final void Function(BuildContext)? onPressed;

  const CloseButton95({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Button95(
      height: 24,
      padding: EdgeInsets.zero,
      onTap: onPressed != null
          ? () => onPressed!(context)
          : () => _defaultOnPressed(context),
      child: const Icon(
        Icons.close,
        size: 20,
      ),
    );
  }

  void _defaultOnPressed(BuildContext context) {
    windowManager.close();
  }
}

class MaximizeButton95 extends StatelessWidget {
  final void Function(BuildContext)? onPressed;

  const MaximizeButton95({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Button95(
      height: 24,
      padding: EdgeInsets.zero,
      onTap: onPressed != null
          ? () => onPressed!(context)
          : () => _defaultOnPressed(context),
      child: const Icon(
        Icons.crop_square_sharp,
        size: 20,
      ),
    );
  }

  void _defaultOnPressed(BuildContext context) {
    windowManager.isMaximizable().then((bool canMax) {
      if (canMax) {
        windowManager.isMaximized().then((bool isMax) {
          if (isMax) {
            windowManager.unmaximize();
          } else {
            windowManager.maximize();
          }
        });
      }
    });
  }
}

class MinimizeButton95 extends StatelessWidget {
  final void Function(BuildContext)? onPressed;

  const MinimizeButton95({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Button95(
      height: 24,
      padding: EdgeInsets.zero,
      onTap: onPressed != null
          ? () => onPressed!(context)
          : () => _defaultOnPressed(context),
      child: const Icon(
        Icons.minimize,
        size: 20,
      ),
    );
  }

  void _defaultOnPressed(BuildContext context) {
    windowManager.isMinimizable().then((bool canMax) {
      if (canMax) {
        windowManager.isMinimized().then((bool isMax) {
          if (!isMax) {
            windowManager.minimize();
          }
        });
      }
    });
  }
}
