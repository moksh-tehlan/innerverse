import 'package:auto_route/auto_route.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingGuard extends AutoRouteGuard {
  @override
  Future<void> onNavigation(
      NavigationResolver resolver, StackRouter router,) async{
    final sharePref = await SharedPreferences.getInstance();
    final isVisited = sharePref.getBool('onBoardingVisited') ?? false;
    if (isVisited) {
      resolver.next();
    } else {
      router.pushNamed('/onBoarding');
    }
  }
}
