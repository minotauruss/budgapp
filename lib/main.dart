import 'package:budgapp/models/ExpenceModel.dart';
import 'package:budgapp/models/InfoModels.dart';
import 'package:budgapp/models/MountModel.dart';
import 'package:budgapp/models/TumModel.dart';
import 'package:budgapp/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ExpenceModelAdapter());
  Hive.registerAdapter(TumModelAdapter());
  Hive.registerAdapter(MountModelAdapter());
  Hive.registerAdapter(InfoModelsAdapter());
  await Hive.openBox("expenceDocument3");
  await Hive.openBox("TumModelDocument");
  await Hive.openBox("MountModelDocument");
  await Hive.openBox("InfoModelDocument");
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Planlama',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}
