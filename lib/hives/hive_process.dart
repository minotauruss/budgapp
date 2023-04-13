import 'package:budgapp/models/ExpenceModel.dart';
import 'package:budgapp/models/InfoModels.dart';
import 'package:budgapp/models/MountModel.dart';
import 'package:budgapp/models/TumModel.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class HiveProcess {
  void getDelete(
    String id,
  );

  getRead();
}




class MaasKiraProcess extends HiveProcess {
  @override
  void getDelete(String id) {
    var maasKira = Hive.box("InfoModelDocument");
    maasKira.delete(id);
  }

  @override
  Future<List<InfoModels>> getRead() async {
     List<InfoModels> InfoModel_listem = [];
    var maasKira = Hive.box("InfoModelDocument");
    var box = await maasKira.values.toList();

    for(var i in box){
InfoModel_listem.add(i);
    }




    return InfoModel_listem;
  }


    @override
  void getSave( double maas, double kira,double netMaas) {
    InfoModels _infoModel = InfoModels(id: 'maas', maas: maas, kira: kira, netMaas: netMaas);

    var maasKira = Hive.box('InfoModelDocument');

    maasKira.put(_infoModel.id, _infoModel);
  }
}

class MountProcess extends HiveProcess {
  @override
  void getDelete(String id) {
    var expenceDocDeleteTum = Hive.box("MountModelDocument");
    expenceDocDeleteTum.delete(id);
  }

  @override
  Future<List<MountModel>> getRead() async {
    List<MountModel> TumModel_listem = [];

    var expenceDocRead = Hive.box("MountModelDocument");
    var listbox = await expenceDocRead.values.toList();

    for (MountModel item in listbox) {
      TumModel_listem.add(item);
    }
    return TumModel_listem;
  }

  @override
  void getSave(String id, String date, String alisveris, String akaryakit,
      String fatura, String elektronik, String kira, double kalan) {
    MountModel expenceModel = MountModel(
        id: id,
        date: date,
        akaryakit: akaryakit,
        alisveris: alisveris,
        elektronik: elektronik,
        kalan: kalan,
        kira: kira,
        fatura: fatura);

    var mountDocumentSave = Hive.box('MountModelDocument');

    mountDocumentSave.put(expenceModel.id, expenceModel);
  }
}

class NewHiveProcessTum extends HiveProcess {
  @override
  void getDelete(String id) {
    var expenceDocDeleteTum = Hive.box("TumModelDocument");
    expenceDocDeleteTum.delete(id);
  }

  @override
  Future<List<TumModel>> getRead() async {
    List<TumModel> TumModel_listem = [];

    var expenceDocRead = Hive.box('TumModelDocument');
    var listbox = await expenceDocRead.values.toList();

    for (TumModel item in listbox) {
      TumModel_listem.add(item);
    }
    return TumModel_listem;
  }

  @override
  void getSave(String id, String category, String date, double price) {
    TumModel expenceModel =
        TumModel(id: id, date: date, category: category, price: price);

    var expenceDocumentSaveTum = Hive.box("TumModelDocument");

    expenceDocumentSaveTum.put(expenceModel.id, expenceModel);
  }
}

class NewHiveProcess extends HiveProcess {
  @override
  void getDelete(
    String id,
  ) {
    var expenceDocDelete = Hive.box('expenceDocument3');
    expenceDocDelete.delete(id);
  }

  @override
  Future<List<ExpenceModel>> getRead() async {
    List<ExpenceModel> Model_listem = [];

    var expenceDocRead = Hive.box('expenceDocument3');
    var listbox = await expenceDocRead.values.toList();

    for (ExpenceModel item in listbox) {
      Model_listem.add(item);
    }
    return Model_listem;
  }

  @override
  void getSave(String id, String category, String date, double price) {
    ExpenceModel expenceModel =
        ExpenceModel(id: id, date: date, category: category, price: price);

    var expenceDocumentSave = Hive.box('expenceDocument3');

    expenceDocumentSave.put(expenceModel.id, expenceModel);
  }
}
