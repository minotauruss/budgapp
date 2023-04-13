import 'package:hive_flutter/hive_flutter.dart';

part 'ExpenceModel.g.dart';
/* flutter pub run build_runner build --delete-conflicting-outputs */

@HiveType(typeId: 0)
class ExpenceModel extends HiveObject{
  @HiveField(0)
  String id;


  @HiveField(1)
  String date;

  @HiveField(2)
  String category;

   @HiveField(3)
  double price;







  ExpenceModel({
    required this.id,
    required this.date,
    required this.category,
    required this.price
    
  
  });
}