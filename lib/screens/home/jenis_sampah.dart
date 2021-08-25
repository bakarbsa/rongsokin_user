import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rongsokin_user/components/default_navBar.dart';
import 'package:rongsokin_user/constant.dart';
import 'package:rongsokin_user/enums.dart';
import 'package:rongsokin_user/models/items_model.dart';

class JenisSampah extends StatelessWidget {
  const JenisSampah({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          title: Text('Jenis Sampah'),
          bottom: TabBar(
            isScrollable: true,
            indicatorColor: Colors.white,
            tabs: [
              Tab(
                text: 'Elektronik',
              ),
              Tab(
                text: 'Plastik',
              ),
              Tab(
                text: 'Kertas',
              ),
              Tab(
                text: 'Kaca',
              ),
              Tab(
                text: 'Logam',
              ),
              Tab(
                text: 'Kain',
              ),
            ],
          ),
        ),
        bottomNavigationBar: DefaultNavBar(selectedMenu: MenuState.home),
        body: TabBarView(
          children: [
            ListView.builder(
              itemCount: elektronikList.length,
              itemBuilder: (context, index) {
                return ItemList(
                    title: elektronikList[index],
                    price: setPrice(elektronikList[index]));
              },
            ),
            ListView.builder(
              itemCount: plastikList.length,
              itemBuilder: (context, index) {
                return ItemList(
                    title: plastikList[index],
                    price: setPrice(plastikList[index]));
              },
            ),
            ListView.builder(
              itemCount: kertasList.length,
              itemBuilder: (context, index) {
                return ItemList(
                    title: kertasList[index],
                    price: setPrice(kertasList[index]));
              },
            ),
            ListView.builder(
              itemCount: kacaList.length,
              itemBuilder: (context, index) {
                return ItemList(
                    title: kacaList[index], price: setPrice(kacaList[index]));
              },
            ),
            ListView.builder(
              itemCount: logamList.length,
              itemBuilder: (context, index) {
                return ItemList(
                    title: logamList[index], price: setPrice(logamList[index]));
              },
            ),
            ListView.builder(
              itemCount: kainList.length,
              itemBuilder: (context, index) {
                return ItemList(
                    title: kainList[index], price: setPrice(kainList[index]));
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ItemList extends StatelessWidget {
  final String title;
  final int price;
  const ItemList({
    Key? key,
    required this.title,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var currency = new NumberFormat.simpleCurrency(locale: 'id_ID');
    String unit = '';
    //Set Satuan
    if (getCategory(title) == 'Elektronik')
      unit = 'unit';
    else if (title == 'Galon' || title == 'Tas')
      unit = 'pcs';
    else if (title == 'Radiator')
      unit = 'set';
    else if (title == 'Sepatu')
      unit = 'pasang';
    else
      unit = 'Kg';
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Card(
        elevation: 6,
        child: ListTile(
          title: Text(this.title),
          subtitle: Text(
            currency.format(price) + '/' + unit,
            style: TextStyle(
              color: kPrimaryColor,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
