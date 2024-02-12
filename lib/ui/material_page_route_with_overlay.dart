import 'package:flutter/material.dart';

class MaterialPageRouteWithOverlay extends StatefulWidget {
  final Widget child;

  const MaterialPageRouteWithOverlay({super.key, required this.child});

  @override
  State<MaterialPageRouteWithOverlay> createState() => _MaterialPageRouteWithOverlayState();
}

class _MaterialPageRouteWithOverlayState extends State<MaterialPageRouteWithOverlay> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (_) => MaterialPageRoute(
        builder: (context) => Overlay(
          initialEntries: [
            OverlayEntry(
              builder: (context) => widget.child,
            ),
          ],
        ),
      ),
    );
  }
}
