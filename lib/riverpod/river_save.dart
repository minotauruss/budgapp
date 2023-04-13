import 'package:budgapp/models/ExpenceModel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

class riverSaveList  extends StateNotifier<List<ExpenceModel>> {
  riverSaveList(): super([]);


  void getSaveList (){

    var _expenseReadDocument = Hive.box('expenceDocument3');
   List listdocument =_expenseReadDocument.values.toList();
   
   List<ExpenceModel> newListem =[];

   for(var item in listdocument){
    newListem.add(item);
   }

  
   for (var i in newListem){
    state.add(i);
   }
   
   
  }
  
  
}

final riverSaveListProvide = StateNotifierProvider<riverSaveList,List<ExpenceModel>>((ref) {
  return riverSaveList();
});