import 'dart:ffi';

import 'package:budgapp/hives/hive_process.dart';
import 'package:budgapp/models/ExpenceModel.dart';
import 'package:budgapp/models/MountModel.dart';
import 'package:budgapp/pages/add_page.dart';
import 'package:budgapp/pages/dashbord.dart';
import 'package:budgapp/pages/istatistik_page.dart';
import 'package:budgapp/pages/tumData.dart';
import 'package:budgapp/riverpod/river_save.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  NewHiveProcess _newHiveProcess = NewHiveProcess();
  MountProcess _mountProcess = MountProcess();
  MaasKiraProcess _maasKiraProcess = MaasKiraProcess();
  TextEditingController _maasEdit = TextEditingController();
  TextEditingController _kiraEdit = TextEditingController();
  TextEditingController _netMaasEdit = TextEditingController();
  List<ExpenceModel> listExpence = [];
  String category = '';
  double price = 0.0;
  List<String> itemlist = ['Alisveris', 'Akaryakit', 'elektronik'];

  double maas = 0.0;
  double kira = 0.0;
  double netMaas = 0.0;

  double Toplam = 0.0;
  int toplamAdet = 0;
  double alisveris = 0.0;
  double akaryakit = 0.0;
  double elektronik = 0.0;
  double faturalar = 0.0;

  int alisverisAdet = 0;
  int akaryakitAdet = 0;
  int elektronikAdet = 0;
  int faturalarAdet = 0;
  double kalan = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ref.read(riverSaveListProvide.notifier).getSaveList();
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => addPage()));
            },
            child: Icon(Icons.add),
          ),
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(
                  text: 'Dashboard',
                ),
                Tab(
                  text: 'Istatistik',
                ),
              ],
            ),
            title: const Text('Butce Planlama'),
            actions: [
              IconButton(
                  onPressed: () {
                    getEdit();
                  },
                  icon: Icon(Icons.edit)),
              IconButton(
                  onPressed: () {
                    getDeleteEverything();
                  },
                  icon: Icon(Icons.delete)),
              IconButton(
                  onPressed: () {
                    getTumData();
                  },
                  icon: Icon(Icons.gif_box))
            ],
          ),
          body: TabBarView(
            children: [
              Istatistik(
                listePer: listExpence,
              ),
              Dasboard(),
            ],
          ),
        ),
      ),
    );
  }

  void getDeleteEverything() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Container(
          alignment: Alignment.center,
          height: 200,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Aylik bilgilerin sifirlanmasini istiyormusunuz!',
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 32,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        getSaveMount();
                      },
                      child: Text('kaydet')),
                  ElevatedButton(
                      onPressed: () {
                        getSil();
                      },
                      child: Text('sil')),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void getTumData() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => TumData()));
  }

  void getSaveMount() {
    _newHiveProcess.getRead().then((listWatch) {
      setState(() {
        Toplam = 0;
        alisveris = 0;
        faturalar = 0;
        akaryakit = 0;
        elektronik = 0;

        for (var i in listWatch) {
          toplamAdet = toplamAdet + 1;
          Toplam = Toplam + i.price;

          if (i.category == 'alisveris') {
            alisverisAdet = alisverisAdet + 1;
            alisveris = alisveris + i.price;
          } else if (i.category == 'akaryakit') {
            akaryakitAdet = akaryakitAdet + 1;
            akaryakit = akaryakit + i.price;
          } else if (i.category == 'faturalar') {
            faturalarAdet = faturalarAdet + 1;
            faturalar = faturalar + i.price;
          } else if (i.category == 'elektronik') {
            elektronikAdet = elektronikAdet + 1;
            elektronik = elektronik + i.price;
          }
        }
      });
      DateTime _timeNow = DateTime.now();
    var uuid = Uuid();

    setState(() {
      kalan = 7390 - Toplam;
      print(Toplam);
    });

    MountModel _mountModel = MountModel(
        id: uuid.v1(),
        date: _timeNow.toString(),
        akaryakit: akaryakit.toString(),
        alisveris: alisveris.toString(),
        elektronik: elektronik.toString(),
        kalan: kalan,
        kira: '3450',
        fatura: faturalar.toString());

    var mountdocument = Hive.box('MountModelDocument');
    mountdocument.put(_mountModel.id, _mountModel);
    });
Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomePage()));
    
  }

  void getSil() {
    _newHiveProcess.getRead().then((value) {
      for (var i in value) {
        _newHiveProcess.getDelete(i.id);
      }
    });

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomePage()));
  }

  void getEdit() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Container(
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(16),
                      child:
                          Text('lutfen maas ve kira giderlerinizi belirtiniz'),
                    ),
                    TextField(
                      controller: _maasEdit,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          label: Container(
                              margin: const EdgeInsets.only(top: 20),
                              child: Text("Maas giriniz")),
                          border: OutlineInputBorder(borderSide: BorderSide()),
                          hintText: 'Maas giriniz',
                          hintStyle: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.normal)),
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    TextField(
                      controller: _netMaasEdit,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          label: Container(
                              margin: const EdgeInsets.only(top: 20),
                              child: Text("Net Maas giriniz")),
                          border: OutlineInputBorder(borderSide: BorderSide()),
                          hintText: 'Net Maas giriniz',
                          hintStyle: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.normal)),
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    TextField(
                      controller: _kiraEdit,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          label: Container(
                              margin: const EdgeInsets.only(top: 20),
                              child: Text("Kira giriniz")),
                          border: OutlineInputBorder(borderSide: BorderSide()),
                          hintText: 'Kira giriniz',
                          hintStyle: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.normal)),
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          getMaasKiraKaydet();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()));
                        },
                        child: Text('kaydet'))
                  ],
                ),
              ),
            ));
  }

  void getMaasKiraKaydet() {
    setState(() {
      maas = double.parse(_maasEdit.text);
      kira = double.parse(_kiraEdit.text);
      netMaas = double.parse(_netMaasEdit.text);
    });

    _maasKiraProcess.getSave(maas, kira, netMaas);
  }
}
