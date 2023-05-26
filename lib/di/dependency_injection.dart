import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:innerverse/data/network/dio_client.dart';
import 'package:innerverse/data/network/firebase_authentication.dart';
import 'package:innerverse/data/network/gpt_call.dart';
import 'package:innerverse/data/network/user_calls.dart';
import 'package:innerverse/data/repository/firebase_authentication_repository.dart';
import 'package:innerverse/data/repository/gpt_repository.dart';
import 'package:innerverse/data/repository/user_repository.dart';
import 'package:innerverse/di/firebase_options.dart';

final getIt = GetIt.instance;
final firebaseAuth = FirebaseAuth.instance;
final firestoreInstance = FirebaseFirestore.instance;

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
    )
    ..registerSingleton(UserCalls(firebaseFirestore: firestoreInstance))
    ..registerSingleton(UserRepository(userCalls: getIt<UserCalls>()))
    ..registerSingleton(Dio())
    ..registerSingleton(DioClient(getIt<Dio>()))
    ..registerSingleton(GptCall(dioClient: getIt<DioClient>()))
    ..registerSingleton(GptRepository(gptCall: getIt<GptCall>()));
}
