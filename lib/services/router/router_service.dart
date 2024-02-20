import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

import '../auth/i_auth_service.dart';
import '../../../constants/route_names.dart';
import '../../../ui/pages/dashboard/dashboard_page.dart';
import '../../../ui/pages/login/login_page.dart';

import 'i_router_service.dart';

@Singleton(as: IRouterService)
class RouterService with ChangeNotifier implements IRouterService {
  final IAuthService _authService;

  RouterService(this._authService);

  @factoryMethod
  static IRouterService create(
      IAuthService authService) {
    IRouterService routerService = RouterService(authService);
    routerService.init();
    return routerService;
  }

  late GoRouter _goRouter;

  GoRouter get instance => _goRouter;

  @override
  void init() {
    _goRouter = GoRouter(
      debugLogDiagnostics: true,
      initialLocation: '/',
      redirect: (context, state) {
        const loginLocation = '/${RouteNames.login}';
        if(!_authService.isAuthenticated){
          if(state.uri.toString() == loginLocation) return null;
          return _goRouter.namedLocation(
            RouteNames.login,
            pathParameters: state.pathParameters,
            queryParameters: state.uri.queryParameters,
          );
        }
        return null;
      },
      routes: <GoRoute>[
        GoRoute(
          name: RouteNames.dashboard,
          path: RouteNames.dashboard,
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            child: const DashboardPage(),
          ),
        ),
        GoRoute(
          name: RouteNames.login,
          path: '/${RouteNames.login}',
          redirect: (context, state) {
            if(_authService.isAuthenticated && state.matchedLocation == '/${RouteNames.login}'){
              return _goRouter.namedLocation(RouteNames.dashboard);
            }
            return null;
          },
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            child: const LoginPage(),
          ),
        ),
      ],
    );
  }

  @override
  void goNamed(
    String name, {
    Map<String, String> params = const <String, String>{},
    Map<String, String> queryParams = const <String, String>{},
    Object? extra,
  }) =>
      _goRouter.goNamed(name,
          queryParameters: queryParams, extra: extra, pathParameters: params);

  @override
  RouterConfig<Object>? get routerConfig => _goRouter;

  @override
  Future<void> pushNamed(
    String name, {
    Map<String, String> params = const <String, String>{},
    Map<String, String> queryParams = const <String, String>{},
    Object? extra,
  }) async =>
      _goRouter.pushNamed(name,
          pathParameters: params, extra: extra, queryParameters: queryParams);

  @override
  void pop() => _goRouter.pop();

  @override
  String? get location =>
      _goRouter.routeInformationProvider.value.uri.toString();
}
