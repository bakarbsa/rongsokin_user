import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rongsokin_user/components/default_appBar.dart';
import 'package:rongsokin_user/constant.dart';
import 'package:rongsokin_user/models/items_model.dart';
import 'package:intl/intl.dart';

int total = 0;
List<Map<String, dynamic>> listBarang = [];

class DetailItem extends StatefulWidget {
  final List<String> selectedItems;
  const DetailItem({Key? key, required this.selectedItems}) : super(key: key);

  @override
  _DetailItemState createState() => _DetailItemState();
}

class _DetailItemState extends State<DetailItem> {
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: InkWell(
          onTap: () {},
          child: Container(
            height: 60,
            width: 300,
            decoration: BoxDecoration(
              color: Color(0xFFFCA311),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Cari Pengepul',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 35, right: 35, top: 35),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                    onPressed: () {
                      widget.selectedItems.clear();
                      listBarang.clear();
                      total = 0;
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back),
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Tentukan detail barang',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.only(top: 20),
                height: 500,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total :',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
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
  const ItemContainer({Key? key, required this.itemName, required this.index})
      : super(key: key);

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
    price = setPrice(widget.itemName);
    listBarang.add({
      'kategori': getCategory(widget.itemName),
      'namaBarang': widget.itemName,
      'deskripsi': description,
      'harga': price,
      'berat': weight,
      'fotoBarang': imageFile
    });
    super.initState();
  }

  Future pickImage() async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        imageFile = File(pickedFile.path);
      }
    });
    return imageFile;
  }

  String unit = '';

  @override
  Widget build(BuildContext context) {
    price = setPrice(widget.itemName);
    unit = '';
    //Set Satuan
    if (getCategory(widget.itemName) == 'Elektronik')
      unit = '';
    else
      unit = ' Kg';

    return Column(
      children: [
        Row(
          children: [
            Text(
              widget.itemName,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SizedBox(width: 5),
            Text('(' + getCategory(widget.itemName) + ')'),
          ],
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Container(
              width: 250,
              child: TextFormField(
                maxLines: 4,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10),
                  hintText: 'Deskripsi barang',
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(10)),
                ),
                onChanged: (value) {
                  description = value;
                  listBarang[widget.index] = {
                    'kategori': getCategory(widget.itemName),
                    'namaBarang': widget.itemName,
                    'deskripsi': description,
                    'harga': price * weight,
                    'berat': weight,
                    'fotoBarang': imageFile
                  };
                },
              ),
            ),
            SizedBox(width: 10),
            Container(
              height: 95,
              width: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Rp',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      Text(
                        currency.format(price * weight).substring(2),
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            weight <= 1 ? 1 : weight--;
                            listBarang[widget.index] = {
                              'kategori': getCategory(widget.itemName),
                              'namaBarang': widget.itemName,
                              'deskripsi': description,
                              'harga': price * weight,
                              'berat': weight,
                              'fotoBarang': imageFile
                            };
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
                        weight.toString() + unit,
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            weight++;
                            listBarang[widget.index] = {
                              'kategori': getCategory(widget.itemName),
                              'namaBarang': widget.itemName,
                              'deskripsi': description,
                              'harga': price * weight,
                              'berat': weight,
                              'fotoBarang': imageFile
                            };
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
                  ),
                  InkWell(
                    onTap: () async {
                      listBarang[widget.index] = {
                        'kategori': getCategory(widget.itemName),
                        'namaBarang': widget.itemName,
                        'deskripsi': description,
                        'harga': price * weight,
                        'berat': weight,
                        'fotoBarang': await pickImage()
                      };
                    },
                    child: Container(
                      height: 30,
                      decoration: BoxDecoration(
                        color: Color(0xFFFCA311),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          'Upload Gambar',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 15),
      ],
    );
  }
}
