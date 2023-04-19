import 'package:innerverse/app/app.dart';
import 'package:innerverse/bootstrap.dart';
import 'package:innerverse/di/dependency_injection.dart';

Future<void> main() async{
  await setupDependencyInjection();
  await bootstrap(App.new);
}
