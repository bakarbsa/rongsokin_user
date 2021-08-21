import 'package:flutter/material.dart';
import 'package:rongsokin_user/components/default_alert_dialog.dart';
import 'package:rongsokin_user/constant.dart';
import 'package:rongsokin_user/models/items_model.dart';
import 'package:rongsokin_user/screens/home/home.dart';
import 'package:rongsokin_user/screens/transaction/detail_item.dart';

// index : [0] = elektrik, [1] = plastik, [2] = kertas,
//         [3] = kaca,     [4] = logam,   [5] = kain
List<bool> _isExpanded = [false, false, false, false, false, false];
Map<String, bool> _isChecked = {
  'Handphone': false,
  'Monitor LED': false,
  'CPU': false,
  'Printer': false,
  'Kulkas': false,
  'Televisi Tabung': false,
  'Televisi LED': false,
  'Aki': false,
  'AC': false,
  'Motherboard': false,
  'Laptop': false,
  'Mesin Cuci': false,
  'Setrika': false,
  'Kipas Angin': false,
  'Pompa Air': false,
  'Botol Mineral 600 ml': false,
  'Botol Mineral 1.5 L': false,
  'Botol Plastik Berwarna': false,
  'Gelas Plastik': false,
  'Jerigen': false,
  'Wadah Parfum': false,
  'Galon': false,
  'Pipa Paralon': false,
  'Karton': false,
  'Kardus': false,
  'Buku': false,
  'Kanvas': false,
  'Cermin': false,
  'Kaca Bening': false,
  'Botol Kaca': false,
  'Kaleng': false,
  'Peralatan Masak': false,
  'Tembaga': false,
  'Kuningan': false,
  'Aluminium': false,
  'Radiator': false,
  'Kain Perca': false,
  'Sepatu': false,
  'Tas': false,
};

class SelectItemScreen extends StatefulWidget {
  const SelectItemScreen({Key? key}) : super(key: key);

  @override
  _SelectItemScreenState createState() => _SelectItemScreenState();
}

class _SelectItemScreenState extends State<SelectItemScreen> {
  var expandedIcon;
  List<String> selectedItems = [];
  Future<bool> _onBackPressed() async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return ShowAlertDialog(
            context: context,
            alertMessage:
                "Yakin untuk kembali ? \nData yang telah anda \nmasukkan akan hilang",
            press: () async {
              for (String key in _isChecked.keys) {
                _isChecked[key] = false;
              }
              Navigator.of(context)
                  .pushReplacement(MaterialPageRoute(builder: (_) {
                return Home();
              }));
            });
      }) ??
    false;
  }

  @override
  void initState() {
    for (String key in _isChecked.keys) {
      _isChecked[key] = false;
    }
    selectedItems.clear();
    print(selectedItems);
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
                  for (String key in _isChecked.keys) {
                    _isChecked[key] = false;
                  }
                  for (int i = 0; i < _isExpanded.length; i++) {
                    _isExpanded[i] = false;
                  }
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back),
              ),
              SizedBox(width: 10),
              Text(
                'Pilih barang yang akan dijual',
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
        padding: const EdgeInsets.only(left: 65, right: 65, bottom: 20),
        child: InkWell(
          onTap: () {
            _isChecked.forEach((key, value) {
              if (value) selectedItems.add(key);
            });
            if (selectedItems.length != 0) {
              print(selectedItems);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailItem(
                    selectedItems: this.selectedItems,
                  )
                )
              );
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            height: 60,
            decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Lanjut',
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
      body: WillPopScope(
        onWillPop: _onBackPressed,
        child: Padding(
          padding:
              const EdgeInsets.only(left: 35, right: 35, top: 25, bottom: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // DROPDOWN ELEKTRONIK
                Card(
                  elevation: 6,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _isExpanded[0] = !_isExpanded[0];
                      });
                    },
                    child: Container(
                      height: 40,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Elektronik',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Icon(_isExpanded[0]
                                ? Icons.expand_more
                                : Icons.navigate_next),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                // List Elektrik Category
                SizedBox(height: 10),
                for (int i = 0; i < elektronikList.length; i++)
                  _isExpanded[0]
                      ? CheckBoxCategory(categoryKey: elektronikList[i])
                      : SizedBox.shrink(),
                SizedBox(height: 10),

                // DROPDOWN PLASTIK
                Card(
                  elevation: 6,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _isExpanded[1] = !_isExpanded[1];
                      });
                    },
                    child: Container(
                      height: 40,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Plastik',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Icon(_isExpanded[1]
                                ? Icons.expand_more
                                : Icons.navigate_next),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                for (int i = 0; i < plastikList.length; i++)
                  _isExpanded[1]
                      ? CheckBoxCategory(categoryKey: plastikList[i])
                      : SizedBox.shrink(),
                SizedBox(height: 10),

                // DROPDOWN KERTAS
                Card(
                  elevation: 6,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _isExpanded[2] = !_isExpanded[2];
                      });
                    },
                    child: Container(
                      height: 40,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Kertas',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Icon(_isExpanded[2]
                                ? Icons.expand_more
                                : Icons.navigate_next),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                for (int i = 0; i < kertasList.length; i++)
                  _isExpanded[2]
                      ? CheckBoxCategory(categoryKey: kertasList[i])
                      : SizedBox.shrink(),
                SizedBox(height: 10),

                // DROPDOWN KACA
                Card(
                  elevation: 6,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _isExpanded[3] = !_isExpanded[3];
                      });
                    },
                    child: Container(
                      height: 40,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Kaca',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Icon(_isExpanded[3]
                                ? Icons.expand_more
                                : Icons.navigate_next),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                for (int i = 0; i < kacaList.length; i++)
                  _isExpanded[3]
                      ? CheckBoxCategory(categoryKey: kacaList[i])
                      : SizedBox.shrink(),
                SizedBox(height: 10),

                // DROPDOWN LOGAM
                Card(
                  elevation: 6,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _isExpanded[4] = !_isExpanded[4];
                      });
                    },
                    child: Container(
                      height: 40,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Logam',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Icon(_isExpanded[4]
                                ? Icons.expand_more
                                : Icons.navigate_next),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                for (int i = 0; i < logamList.length; i++)
                  _isExpanded[4]
                      ? CheckBoxCategory(categoryKey: logamList[i])
                      : SizedBox.shrink(),
                SizedBox(height: 10),

                // DROPDOWN KAIN
                Card(
                  elevation: 6,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _isExpanded[5] = !_isExpanded[5];
                      });
                    },
                    child: Container(
                      height: 40,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Kain',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Icon(_isExpanded[5]
                                ? Icons.expand_more
                                : Icons.navigate_next),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                for (int i = 0; i < kainList.length; i++)
                  _isExpanded[5]
                      ? CheckBoxCategory(categoryKey: kainList[i])
                      : SizedBox.shrink(),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CheckBoxCategory extends StatefulWidget {
  final String categoryKey;
  const CheckBoxCategory({Key? key, required this.categoryKey})
      : super(key: key);

  @override
  _CheckBoxCategoryState createState() => _CheckBoxCategoryState();
}

class _CheckBoxCategoryState extends State<CheckBoxCategory> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.categoryKey, style: TextStyle(fontSize: 15)),
              SizedBox(
                height: 22,
                width: 22,
                child: Checkbox(
                  checkColor: Colors.white,
                  activeColor: Color(0xFFFFC233),
                  value: _isChecked[widget.categoryKey],
                  onChanged: (bool? value) {
                    setState(() {
                      _isChecked[widget.categoryKey] = value!;
                    });
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
        ],
      ),
    );
  }
}
