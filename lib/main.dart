
import 'package:flutter/material.dart';

import 'app/app.dart';
import 'features/auth/presentation/providers/auth_controllers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AuthController.getUserData();

  runApp(CraftyBayApp());
}
