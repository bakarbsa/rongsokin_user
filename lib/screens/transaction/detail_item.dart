import 'package:flutter/material.dart';
import 'package:rongsokin_user/components/default_appBar.dart';
import 'package:rongsokin_user/constant.dart';
import 'package:rongsokin_user/models/items_model.dart';

List<ItemsModel> itemList = [];
int itemIteration = 0;

class DetailItem extends StatefulWidget {
  final List<String> selectedItems;
  const DetailItem({Key? key, required this.selectedItems}) : super(key: key);

  @override
  _DetailItemState createState() => _DetailItemState();
}

class _DetailItemState extends State<DetailItem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(backgroundColor: kPrimaryColor),
      body: Padding(
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
            ItemContainer(itemName: 'Handphone')
          ],
        ),
      ),
    );
  }
}

class ItemContainer extends StatefulWidget {
  final String itemName;
  const ItemContainer({Key? key, required this.itemName}) : super(key: key);

  @override
  _ItemContainerState createState() => _ItemContainerState();
}

class _ItemContainerState extends State<ItemContainer> {
  int price = 0;
  int weight = 1;

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
      ],
    );
  }
}
