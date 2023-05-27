import 'package:auto_route/auto_route.dart';
import 'package:innerverse/data/repository/firebase_authentication_repository.dart';
import 'package:innerverse/di/dependency_injection.dart';

class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final hasToken =
        getIt<FirebaseAuthenticationRepository>().getUser() != null;
    if (hasToken) {
      resolver.next();
    } else {
      router.pushNamed('/onBoarding');
    }
  }
}
