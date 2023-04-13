import 'package:hive_flutter/hive_flutter.dart';

part 'MountModel.g.dart';
/* flutter pub run build_runner build --delete-conflicting-outputs */

@HiveType(typeId: 2)
class MountModel extends HiveObject{
  @HiveField(0)
  String id;


  @HiveField(1)
  String date;

  @HiveField(2)
  String alisveris;
    @HiveField(3)
  String fatura;
    @HiveField(4)
  String elektronik;
    @HiveField(5)
  String akaryakit;
      @HiveField(6)
  String kira;

   @HiveField(7)
  double kalan;







  MountModel({
    required this.id,
    required this.date,
    required this.akaryakit,
    required this.alisveris,
    required this.elektronik,
    required this.kalan,
    required this.kira,
    required this.fatura

    
  
  });
}