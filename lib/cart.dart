import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'classes.dart';
import 'home.dart';

class Cart extends StatefulWidget {
  Cart({Key key}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double width = size.width / 360;
    final double height = size.height / 720;
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
                    Text('Shopping Cart',
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
            .collection('cart')
            .snapshots(),
        builder: (context, snapshot) {
          int cartItems = snapshot.data.docs.length;

          if (cartItems == 1 ||
              !snapshot.hasData ||
              snapshot.hasError ||
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
                      child: Icon(EvaIcons.shoppingCart,
                          size: 100 * width, color: Colors.black45),
                    ),
                  ),
                  SizedBox(height: 40 * height),
                  Text('Your shopping cart is empty',
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
              padding: EdgeInsets.only(left: 20 * width, top: 20 * height),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('users')
                            .doc(userholder.email)
                            .snapshots(),
                        builder: (context, snapshot) {
                          DocumentSnapshot cart = snapshot.data;
                          return Text(cart['cartItems'].toString() + ' items',
                              style: GoogleFonts.acme(
                                  fontSize: 18 * width,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black));
                        }),
                    SizedBox(
                      width: size.width,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: cartItems,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          DocumentSnapshot cartSnapshot =
                              snapshot.data.docs[index];

                          return index == 0
                              ? Container()
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 10 * height),
                                    Text(cartSnapshot['name'],
                                        style: GoogleFonts.acme(
                                            fontSize: 18 * width,
                                            fontWeight: FontWeight.normal,
                                            color: Colors.black)),
                                    Text(
                                        '\$ ' +
                                            cartSnapshot['price'].toString(),
                                        style: GoogleFonts.acme(
                                            fontSize: 18 * width,
                                            fontWeight: FontWeight.normal,
                                            color: colors.mainColor)),
                                    SizedBox(
                                      height: 120 * height,
                                      width: size.width,
                                      child: ListView.builder(
                                        itemCount: 6,
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        itemBuilder: (context, _index) {
                                          return cartSnapshot['quantities']
                                                      [_index] ==
                                                  0
                                              ? Container()
                                              : Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 5 * height,
                                                      right: 8 * width),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        width: 100 * width,
                                                        height: 80 * height,
                                                        child: Stack(
                                                          children: [
                                                            Container(
                                                              width:
                                                                  100 * width,
                                                              height:
                                                                  80 * height,
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(8 *
                                                                              width)),
                                                                  image: DecorationImage(
                                                                      fit: BoxFit
                                                                          .cover,
                                                                      image: NetworkImage(
                                                                          cartSnapshot['images']
                                                                              [
                                                                              _index]))),
                                                            ),
                                                            Positioned(
                                                              top: 3 * height,
                                                              left: 3 * width,
                                                              child: Container(
                                                                  width: 20 *
                                                                      width,
                                                                  height: 20 *
                                                                      height,
                                                                  decoration: BoxDecoration(
                                                                      color: Colors
                                                                          .black,
                                                                      shape: BoxShape
                                                                          .circle),
                                                                  child: Center(
                                                                    child: Text(
                                                                        cartSnapshot['quantities'][_index]
                                                                            .toString(),
                                                                        style: GoogleFonts.acme(
                                                                            fontSize: 14 *
                                                                                width,
                                                                            fontWeight:
                                                                                FontWeight.normal,
                                                                            color: Colors.white)),
                                                                  )),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                          height: 8 * height),
                                                      Text(
                                                          cartSnapshot['colors']
                                                                  [_index]
                                                              .toString(),
                                                          style: GoogleFonts.acme(
                                                              fontSize:
                                                                  14 * width,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: Colors
                                                                  .black54)),
                                                    ],
                                                  ),
                                                );
                                        },
                                      ),
                                    ),
                                  ],
                                );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return null;
        },
      ),
      bottomNavigationBar: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(userholder.email)
              .collection('cart')
              .snapshots(),
          builder: (context, snapshot) {
            int _cartitems = snapshot.data.docs.length;
            return _cartitems == 1
                ? Container(width: size.width, height: 0)
                : Container(
                    width: size.width,
                    height: 110 * height,
                    child: Column(
                      children: [
                        Container(
                            height: 40 * height,
                            width: size.width,
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(.7),
                                border: Border(
                                    top: BorderSide(
                                        color: Colors.black12, width: 1.5))),
                            padding:
                                EdgeInsets.symmetric(horizontal: 30 * width),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('Total',
                                    style: GoogleFonts.acme(
                                        fontSize: 16 * width,
                                        fontWeight: FontWeight.normal,
                                        color: colors.mainColor)),
                                StreamBuilder(
                                    stream: FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(userholder.email)
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      DocumentSnapshot _snapshot =
                                          snapshot.data;
                                      return Text(
                                          '\$ ' +
                                              _snapshot['cartTotalPrice']
                                                  .toString(),
                                          style: GoogleFonts.acme(
                                              fontSize: 16 * width,
                                              fontWeight: FontWeight.normal,
                                              color: colors.mainColor));
                                    }),
                              ],
                            )),
                        Container(
                          height: 70 * height,
                          width: size.width,
                          color: Colors.white,
                          child: Center(
                              child: Container(
                            height: 40 * height,
                            width: 300 * width,
                            color: colors.mainColor,
                            child: Center(
                              child: Text('Checkout',
                                  style: GoogleFonts.acme(
                                      fontSize: 18 * width,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.white)),
                            ),
                          )),
                        )
                      ],
                    ),
                  );
          }),
    );
  }
}
