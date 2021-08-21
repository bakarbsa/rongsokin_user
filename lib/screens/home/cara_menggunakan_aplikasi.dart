import 'package:flutter/material.dart';
import 'package:rongsokin_user/constant.dart';

class MyItem {
  MyItem({this.isExpanded: false, required this.header, required this.body});

  bool isExpanded;
  final String header;
  final String body;
}

class CaraMenggunakanAplikasi extends StatefulWidget {
  const CaraMenggunakanAplikasi({Key? key}) : super(key: key);

  @override
  _CaraMenggunakanAplikasiState createState() =>
      _CaraMenggunakanAplikasiState();
}

class _CaraMenggunakanAplikasiState extends State<CaraMenggunakanAplikasi> {
  List<MyItem> _items = <MyItem>[
    MyItem(
        header: 'Apa itu aplikasi Rongsok.in?',
        body:
            '“Rongsokin” merupakan sebuah aplikasi jasa yang menghubungkan masyarakat yang ingin menjual barang bekasnya dengan pihak pengepul rongsok.'),
    MyItem(
        header: 'Mengapa harus Rongsok.in?',
        body:
            'Dengan menggunakan aplikasi Rongsok.in, kita ikut berperan dalam melestarikan lingkungan dan masa depan.'),
    MyItem(
      header: 'Dimana aplikasi Rongsok.in bisa diunduh?',
      body: 'Aplikasi Rongsok.in dapat diunduh melalui Play Store.',
    ),
    MyItem(
      header: 'Sampah apa saja yang bisa dijual dalam aplikasi Rongsok.in?',
      body:
          'Aplikasi Rongsok.in berfokus pada penjualan sampah elektronik. Namun tidak menutup kemungkinan dalam aplikasi kami juga menjual sampah bekas seperti botol plastic, kaca, buku, dan sebagainya.',
    ),
    MyItem(
      header: 'Dimana saja area cakupan aplikasi Rongsok.in?',
      body:
          'Saat ini, aplikasi Rongsok.in masih mencakup area Kota Surabaya dan area sekitarnya.',
    ),
    MyItem(
      header: 'Bagaimana cara menjadi pengepul Rongsok.in?',
      body:
          'Mendaftarkan diri pada laman aplikasi dengan mengisi data yang dibutuhkan, dan menunggu balasan dari email resmi Rongsok.in.',
    ),
    MyItem(
      header: 'Bagaimana cara mendapatkan kode referral aplikasi Rongsok.in?',
      body:
          'Buka aplikasi Rongsok.in, klik tab Akun, dan klik tombol Kode Referral. Kamu akan melihat kode referal kamu yang bisa kamu bagikan ke teman-temanmu secara langsung atau lewat media sosial, email atau pesan Whatsapp.',
    ),
    MyItem(
      header: 'Apakah pemesanan sampah bisa dibatalkan?',
      body:
          'Bisa! tidak hanya membatalkan, waktu penjemputan dan berat timbanganpun dapat diperbaharui, sebelum proses pembayaran terjadi.',
    ),
    MyItem(
      header:
          'Berapa berat minimum timbangan sampah untuk bisa bertransaksi pada aplikasi Rongsok.in?',
      body:
          'Berat minimum adalah 1 kg untuk setiap masing masing jenis sampah selain sampah elektronik.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Frequently Asked Questions (FAQ)',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )),
          SizedBox(height: 3),
          Container(
            height: 8,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Color(0xFFFCA311),
                  Color(0xFFFFBA48),
                  Color(0xFFFFD082),
                  Color(0xFFFFDDA6),
                  Colors.white,
                ],
              ),
            ),
          ),
          SizedBox(height: 15),
          ExpansionPanelList(
            animationDuration: Duration(seconds: 1),
            elevation: 6,
            expandedHeaderPadding: EdgeInsets.all(10),
            expansionCallback: (int index, bool isExpanded) {
              setState(() {
                _items[index].isExpanded = !_items[index].isExpanded;
              });
            },
            children: _items.map((MyItem item) {
              return ExpansionPanel(
                backgroundColor: kPrimaryColor,
                canTapOnHeader: true,
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Text(item.header,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            )),
                      ),
                    ),
                  );
                },
                isExpanded: item.isExpanded,
                body: Container(
                  padding:
                      EdgeInsets.only(left: 20, right: 20, top: 0, bottom: 20),
                  child: Text(
                    item.body,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
