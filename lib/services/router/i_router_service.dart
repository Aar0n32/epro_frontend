import 'package:flutter/material.dart';

abstract class IRouterService implements ChangeNotifier {
  RouterConfig<Object>? get routerConfig;

  String? get location;

  void goNamed(
      String name, {
        Map<String, String> params = const <String, String>{},
        Map<String, String> queryParams = const <String, String>{},
        Object? extra,
      });

  Future<void> pushNamed(
      String name, {
        Map<String, String> params = const <String, String>{},
        Map<String, String> queryParams = const <String, String>{},
        Object? extra,
      });

  void pop();

  void init();
}