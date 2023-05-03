import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:innerverse/data/network/firebase_authentication.dart';
import 'package:innerverse/data/repository/firebase_authentication_repository.dart';
import 'package:innerverse/di/firebase_options.dart';

final getIt = GetIt.instance;
final firebaseAuth = FirebaseAuth.instance;

Future<void> setupDependencyInjection() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  getIt
    ..registerSingleton(FirebaseAuthentication(firebaseAuth: firebaseAuth))
    ..registerSingleton(
      FirebaseAuthenticationRepository(
        firebaseAuthentication: getIt<FirebaseAuthentication>(),
      ),
    );
}
