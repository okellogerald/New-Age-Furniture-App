import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'classes.dart';
import 'home.dart';

class Favourites extends StatefulWidget {
  Favourites({Key key}) : super(key: key);

  @override
  _FavouritesState createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final height = size.height / 752;
    final width = size.width / 360;
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        elevation: .5,
        backgroundColor: Colors.white.withOpacity(.85),
        iconTheme: IconThemeData(color: Colors.black),
        bottom: PreferredSize(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: 20 * width),
                    Text('Wishlist',
                        style: GoogleFonts.acme(
                            fontSize: 26 * width,
                            fontWeight: FontWeight.normal,
                            color: Colors.black)),
                  ],
                ),
                SizedBox(height: 8 * height)
              ],
            ),
            preferredSize: Size.fromHeight(40 * height)),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(userholder.email)
              .collection('wishlist')
              .snapshots(),
          builder: (context, snapshot) {
            int cartItems = snapshot.data.docs.length;

            if (cartItems == 1 || !snapshot.hasData  ||snapshot.hasError ||
                          snapshot.connectionState == ConnectionState.none ||
                          snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                width: size.width,
                height: size.height,
                color: Colors.white.withOpacity(.85),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 200 * width,
                      height: 200 * width,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: Colors.black12,
                              width: 2,
                              style: BorderStyle.solid)),
                      child: Center(
                        child: SvgPicture.network(
                            'https://firebasestorage.googleapis.com/v0/b/furniture-design-mobileapp.appspot.com/o/favourite.svg?alt=media&token=524aec6c-03f1-42a9-a45e-092e365073df',
                            height: 100 * width,
                            width: 100 * width,
                            color: Colors.black45),
                      ),
                    ),
                    SizedBox(height: 40 * height),
                    Text('Your wishlist is empty',
                        style: GoogleFonts.acme(
                            fontSize: 16 * width,
                            fontWeight: FontWeight.normal,
                            color: Colors.black54)),
                    SizedBox(height: 20 * height),
                    Text('Fortunately, there\'s an easy solution',
                        style: GoogleFonts.acme(
                            fontSize: 18 * width,
                            fontWeight: FontWeight.normal,
                            color: Colors.black)),
                    SizedBox(height: 30 * height),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Home()));
                      },
                      child: Container(
                          width: 300 * width,
                          height: 40 * height,
                          color: colors.mainColor,
                          child: Center(
                            child: Text('Go shopping',
                                style: GoogleFonts.acme(
                                    fontSize: 18 * width,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.white)),
                          )),
                    )
                  ],
                ),
              );
            }
            if (cartItems != 1) {
              return Container(
                width: size.width,
                height: size.height,
                color: Colors.white.withOpacity(.85),
                child: ListView.builder(
                  padding: EdgeInsets.only(left: 20 * width),
                  itemCount: snapshot.data.docs.length,
                  physics: AlwaysScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    DocumentSnapshot _snap = snapshot.data.docs[index];
                    return index == 0
                        ? Container()
                        : Padding(
                           padding: EdgeInsets.only(top: 20 * height),
                          child: Stack(
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    /*  Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Item())); */
                                  },
                                  child: Container(
                                    width: 180 * width,
                                    height: 220 * height,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image:
                                                NetworkImage(_snap['images'][0])),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8 * width))),
                                  ),
                                ),
                                Positioned(
                                  bottom: 10 * height,
                                  left: 55 * width,
                                  child: Container(
                                    color: Colors.white.withOpacity(.4),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10 * width,
                                        vertical: 5 * width),
                                    child: Text('\$ ' + _snap['price'].toString(),
                                        style: GoogleFonts.acme(
                                            fontSize: 16 * width,
                                            fontWeight: FontWeight.normal,
                                            color: Colors.black)),
                                  ),
                                ),
                              ],
                            ),
                        );
                  },
                ),
              );
            }
            return null;
          }),
    );
  }
}
