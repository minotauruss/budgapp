import 'package:hive_flutter/hive_flutter.dart';

part 'TumModel.g.dart';
/* flutter pub run build_runner build --delete-conflicting-outputs */

@HiveType(typeId: 1)
class TumModel extends HiveObject{
  @HiveField(0)
  String id;


  @HiveField(1)
  String date;

  @HiveField(2)
  String category;

   @HiveField(3)
  double price;







  TumModel({
    required this.id,
    required this.date,
    required this.category,
    required this.price
    
  
  });
}