import 'package:flutter/material.dart';
import 'package:rongsokin_user/components/default_appBar.dart';
import 'package:rongsokin_user/constant.dart';
import 'package:rongsokin_user/screens/transaction/detail_item.dart';

// index : [0] = elektrik, [1] = plastik, [2] = kertas,
//         [3] = kaca,     [4] = logam,   [5] = kain
List<bool> _isExpanded = [false, false, false, false, false, false];
Map<String, bool> _isChecked = {
  'Handphone': false,
  'Monitor LED': false,
  'Kulkas': false,
  'Televisi Tabung': false,
  'Televisi LED': false,
  'Baterai': false,
  'Botol Mineral': false,
  'Jerigen': false,
  'Wadah Parfum': false,
  'Galon': false,
  'Karton': false,
  'Kardus': false,
  'Buku': false,
  'Kanvas': false,
  'Cermin': false,
  'Kaca Bening': false,
  'Botol Kaca': false,
  'Kaleng': false,
  'Peralatan Masak': false,
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(backgroundColor: kPrimaryColor),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: InkWell(
          onTap: () {
            _isChecked.forEach((key, value) {
              if (value) selectedItems.add(key);
            });
            if (selectedItems.length != 0) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailItem(
                            selectedItems: this.selectedItems,
                          )));
            }
          },
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
      body: Padding(
        padding:
            const EdgeInsets.only(left: 35, right: 35, top: 35, bottom: 100),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(),
                  onPressed: () {
                    for (String key in _isChecked.keys) {
                      _isChecked[key] = false;
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
            SizedBox(height: 20),
            Container(
              height: MediaQuery.of(context).size.height - 300,
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
                    _isExpanded[0]
                        ? CheckBoxCategory(categoryKey: 'Handphone')
                        : SizedBox.shrink(),
                    _isExpanded[0]
                        ? CheckBoxCategory(categoryKey: 'Monitor LED')
                        : SizedBox.shrink(),
                    _isExpanded[0]
                        ? CheckBoxCategory(categoryKey: 'Kulkas')
                        : SizedBox.shrink(),
                    _isExpanded[0]
                        ? CheckBoxCategory(categoryKey: 'Televisi Tabung')
                        : SizedBox.shrink(),
                    _isExpanded[0]
                        ? CheckBoxCategory(categoryKey: 'Televisi LED')
                        : SizedBox.shrink(),
                    _isExpanded[0]
                        ? CheckBoxCategory(categoryKey: 'Baterai')
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
                    _isExpanded[1]
                        ? CheckBoxCategory(categoryKey: 'Botol Mineral')
                        : SizedBox.shrink(),
                    _isExpanded[1]
                        ? CheckBoxCategory(categoryKey: 'Jerigen')
                        : SizedBox.shrink(),
                    _isExpanded[1]
                        ? CheckBoxCategory(categoryKey: 'Wadah Parfum')
                        : SizedBox.shrink(),
                    _isExpanded[1]
                        ? CheckBoxCategory(categoryKey: 'Galon')
                        : SizedBox.shrink(),
                    SizedBox(height: 20),

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
                    _isExpanded[2]
                        ? CheckBoxCategory(categoryKey: 'Karton')
                        : SizedBox.shrink(),
                    _isExpanded[2]
                        ? CheckBoxCategory(categoryKey: 'Kardus')
                        : SizedBox.shrink(),
                    _isExpanded[2]
                        ? CheckBoxCategory(categoryKey: 'Buku')
                        : SizedBox.shrink(),
                    _isExpanded[2]
                        ? CheckBoxCategory(categoryKey: 'Kanvas')
                        : SizedBox.shrink(),
                    SizedBox(height: 20),

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
                    _isExpanded[3]
                        ? CheckBoxCategory(categoryKey: 'Cermin')
                        : SizedBox.shrink(),
                    _isExpanded[3]
                        ? CheckBoxCategory(categoryKey: 'Kaca Bening')
                        : SizedBox.shrink(),
                    _isExpanded[3]
                        ? CheckBoxCategory(categoryKey: 'Botol Kaca')
                        : SizedBox.shrink(),
                    SizedBox(height: 20),

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
                    _isExpanded[4]
                        ? CheckBoxCategory(categoryKey: 'Kaleng')
                        : SizedBox.shrink(),
                    _isExpanded[4]
                        ? CheckBoxCategory(categoryKey: 'Peralatan Masak')
                        : SizedBox.shrink(),
                    SizedBox(height: 20),

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
                    _isExpanded[5]
                        ? CheckBoxCategory(categoryKey: 'Kain Perca')
                        : SizedBox.shrink(),
                    _isExpanded[5]
                        ? CheckBoxCategory(categoryKey: 'Sepatu')
                        : SizedBox.shrink(),
                    _isExpanded[5]
                        ? CheckBoxCategory(categoryKey: 'Tas')
                        : SizedBox.shrink(),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
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
