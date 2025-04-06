import 'package:flutter/material.dart';

import '../../modules/exit_handler/view/exit_handler.dart';

class LoadingOverlay {
  static OverlayEntry? _overlayEntry;

  static void showLoading(BuildContext context) {
    if (_overlayEntry != null) return;

    _overlayEntry = OverlayEntry(
      builder: (context) => const TransparentLoadingScreen(),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  static void hideLoading() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}

class TransparentLoadingScreen extends StatelessWidget {
  const TransparentLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ExitHandler(
      onExit: (p0) => false,
      child: Material(
        color: Color.fromRGBO(102, 0, 0, 0.4), // Semi-transparent background
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Color.fromARGB(230, 255, 255, 255),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black, width: 0.5),
            ),
            child: const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
          ),
        ),
      ),
    );
  }
}
