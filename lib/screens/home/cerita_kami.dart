import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:rongsokin_user/constant.dart';

final List<int> index = [0, 1, 2, 3, 4];

final List<String> imgList = [
  'assets/images/m_adi_profile.png',
  'assets/images/cellerina_profile.png',
  'assets/images/annisyah_profile.png',
  'assets/images/shafira_profile.png',
  'assets/images/farid_profile.png'
];

final List<String> nameList = [
  'Muhammad Adib Afkari',
  'Cellerina Yolanda E.',
  'Annisyah Amelia F.',
  'Shafira Cahyasakti',
  'Farid Cenreng'
];

final List<String> chiefList = [
  'Chief Executive Officer',
  'Marketing and Finance Director',
  'Art and Design Director',
  'Research and Development Director',
  'Technical and Maintenance Director'
];

final List<String> descriptionList = [
  'Hai Rongsokers! Aku Adib, CEO dari Rongsokin. Disini aku bertanggung jawab atas keputusan yang akan diambil demi keberlangsungan perusahaan.',
  'Halo! Aku Yolla bertanggung jawab terhadap pemasaran produk dan keuangan perusahaan',
  'Halo! Aku Nisyah, disini aku bertanggung jawab atas tampilan visual secara keseluruhan di berbagai media.',
  'Kenalin Aku Shafira bertanggung jawab dalam bidang penelitian dan pengembangan jangka panjang guna keberlanjutan aplikasi.',
  'Halo! Aku Farid bertanggung jawab dalam bidang teknis Rongsokin dan menjaga keberlangsungan teknis Aplikasi.'
];

class CeritaKami extends StatefulWidget {
  const CeritaKami({Key? key}) : super(key: key);

  @override
  _CeritaKamiState createState() => _CeritaKamiState();
}

class _CeritaKamiState extends State<CeritaKami> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text('Yuk kenalan dengan tim Rongsokin',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            SizedBox(height: 3),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Container(
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
            ),
            SizedBox(height: 15),
            CarouselSlider(
              options: CarouselOptions(
                viewportFraction: 0.95,
                height: 200,
                autoPlayInterval: Duration(seconds: 6),
                autoPlay: true,
                enlargeCenterPage: true,
              ),
              items: imageSliders,
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Container(
                padding: EdgeInsets.fromLTRB(25, 0, 25, 40),
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 50, top: 20),
                          child: Text(
                            'Jual Beli Sampah sebagai Media Digitalisasi dan Society 5.0',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                              image: AssetImage(
                                  'assets/images/rongsokin_digitalisasi.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Kehadiran “Rongsokin” sebagai penyedia layanan jasa yang menghubungkan masyarakat yang ingin menjual barang bekasnya dengan pihak pengepul rongsok dengan beberapa fitur berupa penjemputan, penjualan, live location, fitur rating, dan riwayat transaksi barang bekas ke pengepul.',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        color: Colors.white,
                        height: 1.2,
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
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

final List<Widget> imageSliders = index
    .map((item) => Card(
          elevation: 6,
          child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(flex: 2, child: Image.asset(imgList[item])),
                  SizedBox(width: 8),
                  Expanded(
                      flex: 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            nameList[item],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 2),
                          Text(
                            chiefList[item],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            descriptionList[item],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 11,
                              fontStyle: FontStyle.italic,
                            ),
                          )
                        ],
                      ))
                ],
              )),
        ))
    .toList();
