import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:furniture_design/favs.dart';
import 'package:google_fonts/google_fonts.dart';

import 'classes.dart';

class Account extends StatefulWidget {
  Account({Key key}) : super(key: key);

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final height = size.height / 752;
    final width = size.width / 360;

    Widget _buildItems(String item) {
      return Padding(
        padding: EdgeInsets.only(bottom: 10 * height),
        child: Container(
            width: 320 * width,
            height: 50 * height,
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(width: 2, color: Colors.black12))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 240 * width,
                  padding: EdgeInsets.only(left: 0 * width),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(item,
                          style: GoogleFonts.acme(
                              fontSize: 18 * width,
                              fontWeight: FontWeight.normal,
                              color: Colors.black54)),
                    ],
                  ),
                ),
                Container(
                    width: 60 * width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(FontAwesome5.chevron_right,
                                size: 20 * width, color: Colors.black26)),
                      ],
                    )),
              ],
            )),
      );
    }

    return Scaffold(
      backgroundColor: Colors.grey,
      body: Container(
        width: size.width,
        height: size.height,
        color: Colors.white70,
        padding: EdgeInsets.only(left: 20 * width),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 60 * height),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(EvaIcons.arrowBack,
                        size: 26 * width, color: Colors.black)),
                SizedBox(width: 20 * width)
              ],
            ),
            SizedBox(height: 30 * height),
            Text('My Account',
                style: GoogleFonts.acme(
                    fontSize: 36 * width,
                    fontWeight: FontWeight.normal,
                    color: Colors.black)),
            SizedBox(height: 30 * height),
            Container(
              width: 300 * width,
              height: 100 * height,
              padding: EdgeInsets.only(
                  left: 00 * width, bottom: 15 * height, top: 10 * height),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      width: 50 * width,
                      height: 50 * height,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(userholder.image)))),
                  SizedBox(width: 20 * width),
                  Container(
                    width: 200 * width,
                    height: 50 * height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(userholder.name,
                            style: GoogleFonts.acme(
                                fontSize: 18 * width,
                                fontWeight: FontWeight.normal,
                                color: Colors.black)),
                        Text(userholder.email,
                            style: GoogleFonts.acme(
                                fontSize: 16 * width,
                                fontWeight: FontWeight.normal,
                                color: Colors.black54))
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 50 * height),
            GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Favourites()));
                },
                child: _buildItems('Wishlist')),
            _buildItems('My Orders'),
            _buildItems('Payment Methods'),
            _buildItems('Delivery Address'),
            _buildItems('Gift cards & vouchers'),
            _buildItems('Contact preferences'),
          ],
        ),
      ),
    );
  }
}
