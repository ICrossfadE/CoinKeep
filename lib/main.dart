import 'package:firebase_core/firebase_core.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:flutter/material.dart';
import 'package:user_repository/user_repository.dart';

import 'app.dart';

void main() async {
  // Для кешування
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getTemporaryDirectory(),
  );

  runApp(MyApp(FirebaseUserRepo()));
}
