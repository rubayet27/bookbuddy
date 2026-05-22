import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app initializer/my_app.dart';
import 'core/api base/api_helper/api_helper.dart';
import 'screens/favorites/model/favorite_book_model.dart';
import 'flavor_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlavorConfig.appFlavor = Flavor.dev;
  ApiHelper.setup();
  await Hive.initFlutter();
  Hive.registerAdapter(FavoriteBookAdapter());
  await Hive.openBox<FavoriteBookModel>('favorites');

  runApp(const MyApp());
}
