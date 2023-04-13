import 'package:hive_flutter/hive_flutter.dart';

part 'InfoModels.g.dart';
/* flutter pub run build_runner build --delete-conflicting-outputs */

@HiveType(typeId: 4)
class InfoModels extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  double maas;

  @HiveField(2)
  double kira;

    @HiveField(3)
  double netMaas;

  InfoModels({
    required this.id,
    required this.maas,
    required this.kira,
    required this.netMaas,
  });
}
