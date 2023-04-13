import 'package:budgapp/hives/hive_process.dart';
import 'package:budgapp/models/ExpenceModel.dart';
import 'package:budgapp/models/TumModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TumData extends ConsumerStatefulWidget {
  const TumData({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TumDataState();
}

class _TumDataState extends ConsumerState<TumData> {
  NewHiveProcessTum _newHiveProcessTum = NewHiveProcessTum();
  List<TumModel> listeTumData = [];
  double toplam = 0.0 ;

  @override
  getData(){
       _newHiveProcessTum.getRead().then((value){
      setState(() {
        listeTumData = value;
double ax=0.0; 
        for(var item in listeTumData){
         
         ax = ax + item.price;
         toplam = ax;
        }
        
      });
    });
  }

  void initState() {
   
    super.initState();
    getData();

  
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tum Data'+'   '+ toplam.toInt().toString() + ' AUD'),
      ),
      body: Container(
       height: MediaQuery.of(context).size.height,
        child: ListView.builder(
      itemCount: listeTumData.length,
      itemBuilder: (context,index){
       var data =  listeTumData[index];
      return Card(
        child: ListTile(
          leading: CircleAvatar(backgroundColor: Colors.blue,child: Text((index+1).toString(),style: TextStyle(fontWeight: FontWeight.bold),),),
          title: Text(data.category),
          subtitle: Text(data.price.toInt().toString()+' AUD'+'  ' + data.date.substring(0,16)),
          trailing:  ElevatedButton(onPressed: (){
                _newHiveProcessTum.getDelete(data.id);
         getData();
              },child: Text('sil'),
          )
        ),
      );
    }),),
    );
  }
}