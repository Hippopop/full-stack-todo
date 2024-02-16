import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import '../animations/build_text_animation.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
    required this.size,
    required this.text,
    this.backgroundColor,
  });

  final Size size;
  final String text;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: BoxConstraints(
          maxWidth: size.width * 0.8,
          minWidth: size.width * 0.5,
          maxHeight: size.height * 0.8,
        ),
        decoration: BoxDecoration(
          color: backgroundColor ?? Colors.white,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 10,
                ),
                const CircularProgressIndicator(),
                const SizedBox(
                  height: 20,
                ),
                AnimatedBuildText(text),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

typedef CloseLoadingScreen = bool Function();
typedef UpdateLoadingScreen = bool Function(String text);
typedef LoadingWidgetBuilder = Widget Function(Size? size, String text);

@immutable
class LoadingScreenController {
  final CloseLoadingScreen close;
  final UpdateLoadingScreen update;
  const LoadingScreenController({
    required this.close,
    required this.update,
  });
}

class OverlayLoader {
  // Singleton pattern!
  OverlayLoader._sharedInstance();
  static OverlayLoader get instance => _shared;
  static final OverlayLoader _shared = OverlayLoader._sharedInstance();

  LoadingScreenController? _controller;

  void show({
    BuildContext? context,
    required String text,
  }) {
    if (_controller?.update(text) ?? false) {
      return;
    } else {
      if (context == null) {
        if (kDebugMode) {
          assert(
            false,
            "Provide a [BuildContext] to show the overlay!",
          );
        }
        return;
      }
      _controller = _showOverlay(
        context: context,
        text: text,
      );
    }
  }

  void hide() {
    _controller?.close();
    _controller = null;
  }

  LoadingScreenController _showOverlay({
    required String text,
    required BuildContext context,
    LoadingWidgetBuilder? builder,
  }) {
    final textStream = StreamController<String>()..add(text);

    // get the size
    final state = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    final overlay = OverlayEntry(
      builder: (context) {
        return Material(
          color: Colors.black.withAlpha(150),
          child: StreamBuilder<String>(
            initialData: text,
            stream: textStream.stream,
            builder: (context, snapshot) {
              final widget = builder?.call(size, snapshot.data!);
              return widget ?? LoadingWidget(size: size, text: snapshot.data!);
            },
          ),
        );
      },
    );

    state.insert(overlay);
    return LoadingScreenController(
      close: () {
        textStream.close();
        overlay.remove();
        return true;
      },
      update: (text) {
        textStream.add(text);
        return true;
      },
    );
  }
}
