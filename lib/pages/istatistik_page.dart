import 'dart:ffi';
import 'dart:ui';

import 'package:budgapp/hives/hive_process.dart';
import 'package:budgapp/models/ExpenceModel.dart';
import 'package:budgapp/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Istatistik extends ConsumerStatefulWidget {
  List<ExpenceModel> listePer;
  Istatistik({required this.listePer, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _IstatistikState();
}

class _IstatistikState extends ConsumerState<Istatistik> {
  NewHiveProcess _newHiveProcess = NewHiveProcess();
  MaasKiraProcess _maasKiraProcess = MaasKiraProcess();
  List<ExpenceModel> listWatch = [];
  double Toplam = 0;
  int toplamAdet = 0;
  double alisveris = 0.0;
  double akaryakit = 0.0;
  double elektronik = 0.0;
  double faturalar = 0.0;
  int alisverisAdet = 0;
  int akaryakitAdet = 0;
  int elektronikAdet = 0;
  int faturalarAdet = 0;
  double gelir = 0.0;
  double kira = 0.0;
  double kalan = 0.0;
  double kirayardim = 0.0;
  double netMaas = 0.0;
  double alisverisGst = 0.0;
  double akaryakitGst = 0.0;
  double elektronikGst = 0.0;
  double faturalarGst = 0.0;
  double toplamGst = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSaveMaasKira();
    getSaveList();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(children: [
        getGenelToplam(
          'Aylik Gelir',
          gelir,
        ),
        getGenelToplam('Aylik Kira', kira),
        getGenelToplam('Kira Yardimi', kirayardim),
        getGenelToplam('Toplam Harcama', Toplam),
          getGenelToplam('Gst Deposit', toplamGst),
        getGenelToplam('kalan Miktar', kalan),
        bilgiContainer('Son Yapilan Harcamalar', toplamAdet),
        listBuilderMethod(),
        bilgiContainer('Toplam Kategori Harcamlari', 0),
        Container(
          height: 400,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade200
          ),
          child: GridView(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
            ),
            children: [
              toplamCategoty('Alisveris', alisveris, alisverisAdet,alisverisGst,Icons.shop ),
              toplamCategoty('Akaryakit', akaryakit, akaryakitAdet,akaryakitGst,Icons.local_gas_station),
              toplamCategoty('Faturalar', faturalar, faturalarAdet,faturalarGst,Icons.receipt),
              toplamCategoty('Elektronik', elektronik, elektronikAdet,elektronikGst,Icons.cable),
            ],
          ),
        ),
      ]),
    ));
  }

  Widget getGenelToplam(String data, double Toplam) {
    setState(() {
      toplamGst = alisverisGst+akaryakitGst+elektronikGst+faturalarGst;
    });
    return 
    
       Container(
        decoration: BoxDecoration(
          color: Colors.blue.shade100
        ),
        margin: const EdgeInsets.all(4.0),
        height: 32,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              data,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
            ),
            Text(
              Toplam.toInt().toString() + ' ' + 'AUD',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )
          ],
        ),
      );
    
  }

  Container toplamCategoty(String info, double price, int adet,double gst,IconData icon) {
    return Container(
      
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(width: 1.0, style: BorderStyle.solid)),
      width: 120,
      height: 64,
      margin: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          Container(
            margin: EdgeInsets.only(bottom: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(adet.toString() ,style: TextStyle(fontSize: 36,fontWeight: FontWeight.bold),),
                Text(info,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold) ),

              ],
            )
          ),
          Container(
            margin: const EdgeInsets.only(left:8.0),
            child: Text('Harcama      '+ price.toInt().toString() + ' ' + 'AUD'),
          ),
          
           Container(
           margin: const EdgeInsets.only(left:8.0,top: 4),
            child: Text('Gst      '+gst.toInt().toString() + ' ' + 'AUD'),
          ),
            Container(
            margin: const EdgeInsets.only(left:8.0,top: 4),
            child: Icon(icon)
          ),
        ],
      ),
    );
  }

  //context basliklari//

  Container bilgiContainer(String info, int adet) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      alignment: Alignment.bottomLeft,
      child: Text(info + ' ' + '($adet)'),
    );
  }

  //son hacama listesi //

  Container listBuilderMethod() {
    return Container(
      height: listWatch.length > 0 ? 128 : 32,
      child: listWatch.length == 0
          ? Container(
              margin: const EdgeInsets.all(8.0),
              height: 32,
              child: Text('Henuz hicbir alisveris yapmadiniz!'),
            )
          : ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: listWatch.length,
              itemBuilder: (context, index) {
                var data = listWatch[index];
                return Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(width: 1.0, style: BorderStyle.solid)),
                  width: 120,
                  margin: const EdgeInsets.all(12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Text(data.category),
                      ),
                      Container(
                        child: Text(data.price.toString() + ' ' + 'AUD'),
                      ),  Container(
                        child: data.category == 'alisveris' ? Text ('GST'+' '+((data.price/100)*2).toString() + ' ' + 'AUD') : Text('GST'+' '+((data.price/100)*9.09).toString() + ' ' + 'AUD'),
                      ),
                      Container(
                          child: ElevatedButton(
                              onPressed: () {
                                getDeeleteItem(data.id);
                              },
                              child: Text('sil'))),
                    ],
                  ),
                );
              }),
    );
  }

  void getSaveList() async {
    var _expenseReadDocument = await Hive.box('expenceDocument3');
    List listdocument = _expenseReadDocument.values.toList();

    listWatch = [];

    for (var item in listdocument) {
      listWatch.add(item);
    }
    listWatch.sort((a, b) => b.date.compareTo(a.date));

    setState(() {
      for (var i in listWatch) {
        toplamAdet = toplamAdet + 1;
        Toplam = Toplam + i.price;
        if (i.category == 'alisveris') {
          alisverisAdet = alisverisAdet + 1;
          alisveris = alisveris + i.price;
          if(((i.price/100)*2)>18){
            alisverisGst = alisverisGst +((i.price/100)*2);
          }
        } else if (i.category == 'akaryakit') {
          akaryakitAdet = akaryakitAdet + 1;
          akaryakit = akaryakit + i.price;
           
            akaryakitGst = akaryakitGst +((i.price/100)*9.09);
          
        } else if (i.category == 'faturalar') {
          faturalarAdet = faturalarAdet + 1;
          faturalar = faturalar + i.price;
          
        } else if (i.category == 'elektronik') {
          elektronikAdet = elektronikAdet + 1;
          elektronik = elektronik + i.price;
            if(((i.price/100)*9.09)>18){
            elektronikGst= elektronikGst +((i.price/100)*9.09);
          }
        }
      }
    });

    setState(() {
      kirayardim = ((kira - (netMaas / 4)) / 100) * 80;
      kalan = (gelir + kirayardim+toplamGst) - (kira + Toplam);
    });
  }

  void getDeeleteItem(String id) {
    _newHiveProcess.getDelete(id);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomePage()));
  }

  void getSaveMaasKira() {
    _maasKiraProcess.getRead().then((value) {
      if (value.length > 0) {
        setState(() {
          gelir = value[0].maas;
          kira = value[0].kira;
          netMaas = value[0].netMaas;
        });
      } else {
        setState(() {
          gelir = 0.0;
          kira = 0.0;
          netMaas = 0.0;
        });
      }
    });
  }
}
