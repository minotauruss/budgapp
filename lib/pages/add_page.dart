import 'package:budgapp/hives/hive_process.dart';
import 'package:budgapp/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

class addPage extends ConsumerStatefulWidget {
  const addPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _addPageState();
}

class _addPageState extends ConsumerState<addPage> {
  TextEditingController _controller = TextEditingController();
  NewHiveProcess _newHiveProcess = NewHiveProcess();
  NewHiveProcessTum _newHiveProcessTum = NewHiveProcessTum();
  String price = '';
  String category = '';
  List<String> _product =['alisveris','akaryakit','faturalar','elektronik'];
  String _selectedValue = 'alisveris';
  
   

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('yeni urun ekle'),
      ),
      body: Column(
        children: [
          Container(
               margin: const EdgeInsets.fromLTRB(16.0,128.0,16.0,16.0),
            child: Text('urunlerinizin kategorisini seciniz'),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(16.0,16.0,16.0,16.0),
           
            
            child: getDropdownButton()),

            
          
            Container(
               margin: const EdgeInsets.fromLTRB(16.0,16.0,16.0,16.0),
                child: noteTexttitleFormField(1,"fiyat giriniz",20,FontWeight.bold,
            )),
          
          getElevatonButton()


        ],
      ),
    );
  }






  Container noteTexttitleFormField(
      int maxline, String text, double fontsize, FontWeight? fontweight) {
    return Container(
        margin: const EdgeInsets.only(top: 10),
        child: TextFormField(
          controller: _controller,
          keyboardType: TextInputType.number,
          maxLines: maxline,
          decoration: InputDecoration(
              label: Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: Text("fiyat giriniz")),
              border: OutlineInputBorder(borderSide: BorderSide()),
              hintText: text,
              hintStyle: TextStyle(
                  fontSize: fontsize,
                  fontWeight: fontweight ?? FontWeight.normal)),
        ));
  }
  
 Widget getDropdownButton() {
    return DropdownButton(
    value: _selectedValue,
    isExpanded: true,
      items: _product.map((e) {
        return DropdownMenuItem(child: Text(e),value: e);}).toList(),

        onChanged: (value){
          setState(() {
            _selectedValue =value!;
          });
        },
      );
  }
  
  getElevatonButton() {
    return ElevatedButton(onPressed: () async{
      DateTime _timeNow = DateTime.now();
       var uuid = Uuid();

      setState(() {
        category = _selectedValue;
        price  = _controller.text;
      });

_newHiveProcess.getSave(uuid.v1(), category, _timeNow.toString(), double.parse(price));
_newHiveProcessTum.getSave(uuid.v1(), category, _timeNow.toString(), double.parse(price));
    
     Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePage() ));
    }, 
    
    child: Text('kaydet'));
    
  }
  
 
}
