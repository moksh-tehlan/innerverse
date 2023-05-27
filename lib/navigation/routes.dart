import 'package:auto_route/auto_route.dart';
import 'package:innerverse/navigation/auth_guard.dart';
import 'package:innerverse/navigation/on_boarding_guard.dart';
import 'package:innerverse/navigation/routes.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends $AppRouter{

  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: OnBoardingRoute.page,path: '/onBoarding'),
    AutoRoute(page: SignupRoute.page,path: '/signUp'),
    AutoRoute(page: SigninRoute.page,path: '/signin'),
    AutoRoute(page: TabRoute.page,path: '/',guards: [AuthGuard()]),
    AutoRoute(page: HomeRoute.page,path: '/home'),
  ];
}
