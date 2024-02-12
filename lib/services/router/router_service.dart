import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

import 'i_router_service.dart';

@Singleton(as: IRouterService)
class RouterService with ChangeNotifier implements IRouterService {
  // final IAuthService _authService;

  late GoRouter _goRouter;

  // RouterService(this._authService);

  GoRouter get instance => _goRouter;


  // @factoryMethod
  // static IRouterService create(
  //     IAuthService authService) {
  //   IRouterService routerService = RouterService(authService);
  //   routerService.init();
  //   return routerService;
  // }

  @override
  void init() {
    _goRouter = GoRouter(
      debugLogDiagnostics: true,
      redirect: (context, state) {
        // const loginLocation = "/${RouteNames.login}";
        //
        // if (!_authService.isCurrentPersonUserAuthenticated) {
        //   if (state.uri.toString() == loginLocation) return null;
        //   return _goRouter.namedLocation(
        //     RouteNames.login,
        //     pathParameters: state.pathParameters,
        //     queryParameters: state.uri.queryParameters,
        //   );
        // }
        return null;
      },
      initialLocation: '/',
      routes: <GoRoute>[
      ],
      // errorPageBuilder: (context, state) => MaterialPage(
      //   key: state.pageKey,
      //   child: ErrorPage(
      //     status: UiState.error,
      //     descriptionText: context.lang().errorStandardNachricht,
      //     actions: [
      //       ElevatedButton(
      //         onPressed: () => context.read<IRouterService>().goNamed(RouteNames.dashboard),
      //         child: Text(context.lang().schliessen),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }

  @override
  void goNamed(
      String name, {
        Map<String, String> params = const <String, String>{},
        Map<String, String> queryParams = const <String, String>{},
        Object? extra,
      }) =>
      _goRouter.goNamed(name, queryParameters: queryParams, extra: extra, pathParameters: params);

  @override
  RouterConfig<Object>? get routerConfig => _goRouter;

  @override
  Future<void> pushNamed(
      String name, {
        Map<String, String> params = const <String, String>{},
        Map<String, String> queryParams = const <String, String>{},
        Object? extra,
      }) async =>
      _goRouter.pushNamed(name, pathParameters: params, extra: extra, queryParameters: queryParams);

  @override
  void pop() => _goRouter.pop();

  @override
  String? get location => _goRouter.routeInformationProvider.value.uri.toString();
}