import 'package:budgapp/hives/hive_process.dart';
import 'package:budgapp/models/MountModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Dasboard extends ConsumerStatefulWidget {
  const Dasboard({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DasboardState();
}

class _DasboardState extends ConsumerState<Dasboard> {
  MountProcess _mountProcess = MountProcess();
  List<MountModel> listeMount = [];
  String ay = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _mountProcess.getRead().then((value) {
      setState(() {
        listeMount = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: ListView.builder(
          itemCount: listeMount.length,
          itemBuilder: (context, index) {
            var data = listeMount[index];

      

            return Card(
                child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(data.date.substring(5,7)+'.'+ ' ay yapilan harcama ve gelirlerin toplam miktarlaridir'),
                  Text(
                    'alisveris' + '   ' + data.alisveris,
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    'fatura' + '   ' + data.fatura,
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    'akaryakit' + '   ' + data.akaryakit,
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    'elektronik' + '   ' + data.elektronik,
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    'kira' + '    ' + data.kira,
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    'kalan' + '    ' + data.kalan.toString(),
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        getDelete(data.id);
                      },
                      child: Text('sil'))
                ],
              ),
            ));
          }),
    ));
  }

  void getDelete(String id) {
    MountProcess _mountProcess = MountProcess();
    _mountProcess.getDelete(id);
    _mountProcess.getRead().then((value) {
      setState(() {
        listeMount = value;
      });
    });
  }
  
  void getDateSet(String date) {

         setState(() {
              if (date == '01') {
                ay = 'ocak';
              } else if (date== '02') {
                ay = 'subat';
              }else if (date== '03') {
                ay = 'mart';
              }else if (date== '04') {
                ay = 'nisan';
              }else if (date== '05') {
                ay = 'mayis';
              }else if (date== '06') {
                ay = 'haziran';
              }else if (date== '07') {
                ay = 'temmuz';
              }else if (date== '08') {
                ay = 'agustos';
              }else if (date== '09') {
                ay = 'eylul';
              }else if (date== '10') {
                ay = 'ekim';
              }else if (date== '11') {
                ay = 'kasim';
              }else if (date== '12') {
                ay = 'aralik';
              }
            });
  }
}
