import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rongsokin_user/components/default_alert_dialog.dart';
import 'package:rongsokin_user/constant.dart';
import 'package:rongsokin_user/models/items_model.dart';
import 'package:intl/intl.dart';
import 'package:rongsokin_user/screens/transaction/loading.dart';
import 'package:rongsokin_user/screens/transaction/select_item_screen.dart';
import 'package:rongsokin_user/services/auth.dart';

num total = 0;
typedef TotalCallback = void Function(num tot);
var currency = new NumberFormat.simpleCurrency(locale: 'id_ID');
List<Map<String, dynamic>> listBarang = [];
num? countTotal() {
  total = 0;
  for (var i = 0; i < listBarang.length; i++) {
    if (listBarang[i]["harga"] != null) {
      total += listBarang[i]["harga"];
    }
  }
  return total;
}

class DetailItem extends StatefulWidget {
  final List<String> selectedItems;
  const DetailItem({Key? key, required this.selectedItems}) : super(key: key);

  @override
  _DetailItemState createState() => _DetailItemState();
}

class _DetailItemState extends State<DetailItem> {
  num total = 0;
  bool coba = false;
  String address = '';
  final AuthService _auth = AuthService();

  Future<bool> _onBackPressed() async {
    return await showDialog(
            context: context,
            builder: (BuildContext context) {
              return ShowAlertDialog(
                  context: context,
                  alertMessage:
                      "Yakin untuk kembali ? \nData yang telah anda \nmasukkan akan hilang",
                  press: () async {
                    widget.selectedItems.clear();
                    listBarang.clear();
                    total = 0;
                    Navigator.of(context)
                        .pushReplacement(MaterialPageRoute(builder: (_) {
                      return SelectItemScreen();
                    }));
                  });
            }) ??
        false;
  }

  void initState() {
    setState(() {
      listBarang.clear();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 80,
        backgroundColor: kPrimaryColor,
        title: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Row(
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
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30, bottom: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
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
                Text(
                  '${currency.format(total)}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Center(
              child: InkWell(
                onTap: () async {
                  bool checkNullPrice = false;
                  bool checkNullPhoto = false;
                  bool checkNullDesc = false;
                  for (int i = 0; i < widget.selectedItems.length; i++) {
                    if (listBarang[i]['harga'] == null ||
                        listBarang[i]['harga'] == 0) {
                      checkNullPrice = true;
                    }
                    if (listBarang[i]['fotoBarang'] == null ||
                        listBarang[i]['fotoBarang'] == '') {
                      checkNullPhoto = true;
                    }
                    if (listBarang[i]['deskripsi'] == null ||
                        listBarang[i]['deskripsi'] == '') {
                      checkNullDesc = true;
                    }
                  }
                  if (checkNullPrice == false &&
                      checkNullPhoto == false &&
                      checkNullDesc == false) {
                    print(listBarang);
                    dynamic result =
                        await _auth.createRequest(listBarang, address, total);
                    if (result == null) {
                      print('error');
                    } else {
                      await Future.delayed(Duration(seconds: 1))
                          .then((value) => {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (_) {
                                  return Loading(
                                    documentId: result,
                                  );
                                }))
                              });
                    }
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  height: 60,
                  width: 300,
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
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
          ],
        ),
      ),
      body: WillPopScope(
        onWillPop: _onBackPressed,
        child: Padding(
          padding:
              const EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Text(
                'Alamat Lengkap',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.location_on, color: kPrimaryColor),
                  contentPadding: EdgeInsets.all(10),
                  hintText: 'Masukkan alamat lengkapmu',
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(10)),
                ),
                onChanged: (value) {
                  address = value;
                },
              ),
              SizedBox(height: 5),
              Text('* Jangan lupa upload foto ya!',
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 12,
                      fontStyle: FontStyle.italic)),
              SizedBox(height: 5),
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: widget.selectedItems.length,
                  itemBuilder: (context, index) {
                    return ItemContainer(
                        itemName: widget.selectedItems[index],
                        index: index,
                        total: (num tot) {
                          setState(() {
                            total = tot;
                          });
                        });
                  },
                ),
              ),
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
  final TotalCallback total;
  const ItemContainer(
      {Key? key,
      required this.itemName,
      required this.index,
      required this.total})
      : super(key: key);

  @override
  _ItemContainerState createState() => _ItemContainerState();
}

class _ItemContainerState extends State<ItemContainer>
    with AutomaticKeepAliveClientMixin {
  String category = '';
  String itemName = '';
  String description = '';
  int price = 1;
  int weight = 0;
  File? imageFile;
  String imageText = 'Ambil Foto';
  Color imageColor = kSecondaryColor;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    price = setPrice(widget.itemName);
    listBarang.add({});
    super.initState();
  }

  Future pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    setState(() {
      if (pickedFile != null) {
        imageFile = File(pickedFile.path);
        imageColor = Color(0xFF1CC900);
        imageText = 'Sudah Upload';
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
      unit = ' unit';
    else if (widget.itemName == 'Galon' || widget.itemName == 'Tas')
      unit = ' pcs';
    else if (widget.itemName == 'Radiator')
      unit = ' set';
    else if (widget.itemName == 'Sepatu')
      unit = '';
    else
      unit = ' Kg';

    super.build(context);
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
            Expanded(
              flex: 2,
              child: Container(
                width: 200,
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
                      'hargaPerItem': price,
                      'berat': weight,
                      'fotoBarang': imageFile
                    };
                  },
                ),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Container(
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
                          '${currency.format(price * weight).substring(2)}',
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
                                'hargaPerItem': price,
                                'berat': weight,
                                'fotoBarang': imageFile
                              };
                              widget.total(countTotal()!);
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
                                'hargaPerItem': price,
                                'berat': weight,
                                'fotoBarang': imageFile
                              };
                              widget.total(countTotal()!);
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
                      onTap: () => showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0))),
                          contentPadding: EdgeInsets.only(top: 10.0),
                          content: Container(
                            width: 300.0,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    SizedBox(
                                      height: 80.0,
                                    ),
                                    Text(
                                      'Pilih Media',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Expanded(
                                      child: InkWell(
                                        onTap: () async {
                                          listBarang[widget.index] = {
                                            'kategori':
                                                getCategory(widget.itemName),
                                            'namaBarang': widget.itemName,
                                            'deskripsi': description,
                                            'harga': price * weight,
                                            'hargaPerItem': price,
                                            'berat': weight,
                                            'fotoBarang': await pickImage(
                                                ImageSource.camera)
                                          };
                                          Navigator.pop(context);
                                        },
                                        child: Container(
                                          padding: EdgeInsets.only(
                                              top: 20.0, bottom: 20.0),
                                          decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(15.0),
                                            ),
                                          ),
                                          child: Text(
                                            "Camera",
                                            style:
                                                TextStyle(color: Colors.black),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: InkWell(
                                        onTap: () async {
                                          listBarang[widget.index] = {
                                            'kategori':
                                                getCategory(widget.itemName),
                                            'namaBarang': widget.itemName,
                                            'deskripsi': description,
                                            'harga': price * weight,
                                            'hargaPerItem': price,
                                            'berat': weight,
                                            'fotoBarang': await pickImage(
                                                ImageSource.gallery)
                                          };
                                          Navigator.pop(context);
                                        },
                                        child: Container(
                                          padding: EdgeInsets.only(
                                              top: 20.0, bottom: 20.0),
                                          decoration: BoxDecoration(
                                            color: kPrimaryColor,
                                            borderRadius: BorderRadius.only(
                                                bottomRight:
                                                    Radius.circular(15.0)),
                                          ),
                                          child: Text(
                                            "Gallery",
                                            style:
                                                TextStyle(color: Colors.white),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      child: Container(
                        height: 30,
                        decoration: BoxDecoration(
                          color: imageColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Text(
                            imageText,
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
            ),
          ],
        ),
        SizedBox(height: 15),
      ],
    );
  }
}
