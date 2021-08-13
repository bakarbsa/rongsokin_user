import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rongsokin_user/components/default_appBar.dart';
import 'package:rongsokin_user/constant.dart';
import 'package:rongsokin_user/models/items_model.dart';
import 'package:intl/intl.dart';

// List<ItemsModel> itemList = [];
int total = 0;
List<Map<String, dynamic>> listBarang = [];
class DetailItem extends StatefulWidget {
  final List<String> selectedItems;
  const DetailItem({Key? key, required this.selectedItems}) : super(key: key);

  @override
  _DetailItemState createState() => _DetailItemState();
}

class _DetailItemState extends State<DetailItem> {  
  
  int itemIteration = 0;

  void addData(String category, String itemName) {
    listBarang.add(
      {
        'kategori': category, 
        'namaBarang': itemName,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(backgroundColor: kPrimaryColor),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 35, right: 35, top: 35),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Tentukan detail barang',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 20),
              Container(
                height: 200,
                child: ListView.builder(
                  itemCount: widget.selectedItems.length,
                  itemBuilder: (context, index) {
                    return ItemContainer(
                      itemName: widget.selectedItems[index],
                      index: index,
                    );
                  },
                ),
              ),
              ElevatedButton(
                child: Text('upload'),
                onPressed: () {
                  print(listBarang.length);
                  // addData(category, itemName)
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ItemContainer extends StatefulWidget {
  final String itemName;
  final int index;
  const ItemContainer({Key? key, required this.itemName, required this.index}) : super(key: key);

  @override
  _ItemContainerState createState() => _ItemContainerState();
}

class _ItemContainerState extends State<ItemContainer> {
  String category = '';
  String itemName = '';
  String description = '';
  int price = 10000;
  int weight = 1;
  File? imageFile;
  var currency = new NumberFormat.simpleCurrency(locale: 'id_ID');

  @override
  void initState() {
    listBarang.add({});
    super.initState();
  }

  Future pickImage() async {
    final pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);

    setState(() {
      if(pickedFile != null) {
        imageFile = File(pickedFile.path);
      } 
    });
    return imageFile;
  }

  @override
  Widget build(BuildContext context) {
    price = setPrice(widget.itemName);
    return Column(
      children: [
        Row(children: [
          Text(
            widget.itemName,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          SizedBox(width: 5),
          Text('(' + getCategory(widget.itemName) + ')'),
        ]),
        Row(
          children: [
            Container(
              width: 100,
              child: TextFormField(
                onChanged: (value) {
                  description = value;
                  listBarang[widget.index] = {
                    'kategori' : getCategory(widget.itemName),
                    'namaBarang' : widget.itemName,
                    'deskripsi' : description,
                    'harga' : price*weight,
                    'berat' : weight,
                    'fotoBarang' : imageFile
                  };
                },
              ),
            ),
            Container(
              width: 140,
              child: Column(
                children: [
                  Text(
                    '${currency.format(price * weight)}',
                    style: TextStyle(                   
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            weight <= 1 ? 1 : weight--;
                            listBarang[widget.index] = {
                              'kategori' : getCategory(widget.itemName),
                              'namaBarang' : widget.itemName,
                              'deskripsi' : description,
                              'harga' : price*weight,
                              'berat' : weight,
                              'fotoBarang' : imageFile
                            };
                            total -= price*weight;
                          });
                        },
                        child: Container(
                          height: 25,
                          width: 25,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Center(child: Icon(Icons.remove)),
                        ),
                      ),
                      Text(
                        weight.toString() + ' Kg',
                        style: TextStyle(
                          
                          fontSize: 15,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            weight++;
                            listBarang[widget.index] = {
                              'kategori' : getCategory(widget.itemName),
                              'namaBarang' : widget.itemName,
                              'deskripsi' : description,
                              'harga' : price*weight,
                              'berat' : weight,
                              'fotoBarang' : imageFile
                            };
                            total += price*weight;
                          });
                        },
                        child: Container(
                          height: 25,
                          width: 25,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Center(child: Icon(Icons.add)),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            InkWell(
              onTap: () async{
                listBarang[widget.index] = {
                  'kategori' : getCategory(widget.itemName),
                  'namaBarang' : widget.itemName,
                  'deskripsi' : description,
                  'harga' : price*weight,
                  'berat' : weight,
                  'fotoBarang' : await pickImage()
                };
              },
              child: Container(
                width: 60,
                height: 30,
                color: Colors.red,
                child: Text('upload gambar'),
              ),
            )
          ],
        )
      ],
    );
  }
}
