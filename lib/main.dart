import 'package:CoinKeep/firebase/lib/user_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:flutter/material.dart';

import 'presentation/pages/app.dart';

void main() async {
  // Для кешування
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getTemporaryDirectory(),
  );

  await Firebase.initializeApp();
  runApp(MyApp(FirebaseUserRepo()));
}
