import 'package:flutter/material.dart';

class Final extends StatefulWidget {
  final bool botolKaca;
  final bool karton;

  const Final({ 
    Key? key,
    required this.botolKaca,
    required this.karton
  }) : super(key: key);

  @override
  _FinalState createState() => _FinalState();
}

class _FinalState extends State<Final> {
  List<Map<String, String>> listBarang = [];
  String? botolKacaDescription;
  String? KartonDescription;

  void addData(String jenisBarang) {
    listBarang.add(
      {
        'kategori': 'elektronik', 
        'namaBarang': jenisBarang,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: [
            widget.botolKaca == false ? Container() : item('Botol Kaca'),
            widget.karton == false ? Container() : item('Karton'),
            ElevatedButton(
              child: Text('simpan'),
              onPressed: () {
                widget.botolKaca ? addData('Botol Kaca') : null;
                widget.karton ? addData('Karton') : null;
                print(listBarang);
              },
            ) 
          ],
        ),
      ),
    );
  }

  ListTile item (String title) {
    return ListTile(
      title: Text(title),
      subtitle: TextFormField(
        keyboardType: TextInputType.multiline,
        maxLines: null,
        style: TextStyle(color: Colors.black),
        onChanged: (value) {
          setState(() {
            title == 'Botol Kaca' ? botolKacaDescription = value : null;
            title == 'Karton' ? KartonDescription = value : null;
          });
        },
        decoration: InputDecoration(
          hintStyle: TextStyle(color: Colors.grey),
          hintText: 'Write your note here...',
          border: InputBorder.none
        ),
      ),
    );
  }
}