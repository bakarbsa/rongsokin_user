import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rongsokin_user/components/default_appBar.dart';
import 'package:rongsokin_user/constant.dart';
import 'package:rongsokin_user/screens/home/home.dart';
import 'package:rongsokin_user/services/database.dart';

class RatingScreen extends StatefulWidget {
  const RatingScreen({
    Key? key,
    required this.userPengepulId,
    required this.namaPengepul
  }) : super(key: key);

  final String userPengepulId;
  final String namaPengepul;

  @override
  _RatingScreenState createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  int _rating = 0;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(backgroundColor: kPrimaryColor, ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 65, right: 65, bottom: 20),
        child: InkWell(
          onTap: () async{
            final user = FirebaseAuth.instance.currentUser != null
              ? FirebaseAuth.instance.currentUser
              : null;
            await DatabaseService(uid: user?.uid ?? null).giveRating(widget.userPengepulId, _rating);
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()),
            );
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
                  'Kirim',
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/images/good_rating.png'),
          SizedBox(height: 30),
          Text(
            widget.namaPengepul,
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Masukkan Penilaian Anda Untuk\nPengepul',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 20),
          Rating((rating) {
            setState(() {
              _rating = rating;
            });
          }),
        ],
      ),
    );
  }
}

class Rating extends StatefulWidget {
  final int maximumRating;
  final Function(int) onRatingselected;

  Rating(this.onRatingselected, [this.maximumRating = 5]);

  @override
  _RatingState createState() => _RatingState();
}

class _RatingState extends State<Rating> {
  int _currentRating = 0;

  Widget _buildRatingStar(int index) {
    if (index < _currentRating) {
      return Icon(Icons.star, color: Colors.orange, size: 50);
    } else {
      return Icon(Icons.star_border_outlined, color: Colors.orange, size: 50);
    }
  }

  Widget _buildBody() {
    final stars = List<Widget>.generate(this.widget.maximumRating, (index) {
      return GestureDetector(
          child: _buildRatingStar(index),
          onTap: () {
            setState(() {
              _currentRating = index + 1;
            });
            this.widget.onRatingselected(_currentRating);
          });
    });
    return Row(children: stars, mainAxisAlignment: MainAxisAlignment.center);
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }
}
