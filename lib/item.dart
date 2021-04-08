import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:furniture_design/reviews.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'cart.dart';
import 'classes.dart';
import 'favs.dart';

class Item extends StatefulWidget {
  Item({Key key}) : super(key: key);

  @override
  _ItemState createState() => _ItemState();
}

class _ItemState extends State<Item> with TickerProviderStateMixin {
  AnimationController animationController;
  bool tapped = false;
  Animation sizeAnimation;
  double _int = 0;
  List<List> _colorList = [
    [0]
  ];
  List favsList = [];
  bool touchedCart = false;

  assignList() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userholder.email)
        .get()
        .then((value) {
      setState(() {
        favsList = value['wishList'];
      });
    });
  }

  @override
  void initState() {
    super.initState();

    assignList();
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));

    sizeAnimation =
        Tween<double>(begin: 10.0, end: 30.0).animate(animationController);
    animationController.forward();

    double avgRate = itemholder.avgRate;
    double _double = 0;

    int rounded = avgRate.round();
    int integer = avgRate.toInt();

    if (rounded == integer) {
      for (int i = 1; i <= 5; i++) {
        if (i <= integer) {
          _double = _double + 1;
        }
      }
    }

    if (rounded - avgRate == 0.5) {
      for (int i = 1; i <= 5; i++) {
        if (i <= integer) {
          _double = _double + 1;
        }
        if (i == rounded) {
          _double = _double + 0.5;
        }
      }
    }

    if (rounded - avgRate < 0.5 && rounded - avgRate > 0) {
      for (int i = 1; i <= 5; i++) {
        if (i <= integer || i == rounded) {
          _double = _double + 1;
        }
      }
    }

    setState(() {
      _int = _double - 1.0;
    });
    print(_double);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  ItemScrollController _controller = ItemScrollController();
  int _index = 0, quantity = 1;
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final height = size.height / 752;
    final width = size.width / 360;

    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white.withOpacity(.85),
        elevation: 1,
        centerTitle: false,
        title: Text('Living room',
            style: GoogleFonts.acme(
                fontSize: 18 * width,
                fontWeight: FontWeight.normal,
                color: Colors.black)),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Cart()));
            },
            child: Icon(EvaIcons.shoppingBagOutline,
                color: Colors.black, size: 20 * width),
          ),
          SizedBox(width: 30 * width),
          GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Favourites()));
              },
              child: Icon(EvaIcons.heartOutline,
                  size: 22 * width, color: Colors.black)),
          SizedBox(width: 20 * width)
        ],
      ),
      body: ScrollablePositionedList.builder(
        itemScrollController: _controller,
        scrollDirection: Axis.vertical,
        itemCount: 3,
        itemBuilder: (context, index) {
          return index == 0
              ? Container(
                  width: size.width,
                  color: Colors.white.withOpacity(.85),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: 15 * width,
                            right: 10 * width,
                            top: 10 * height,
                            bottom: 20 * height),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(itemholder.name,
                                    style: GoogleFonts.acme(
                                        fontSize: 18 * width,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black)),
                                Text('\$ ${itemholder.price}',
                                    style: GoogleFonts.acme(
                                        fontSize: 18 * width,
                                        fontWeight: FontWeight.normal,
                                        color: colors.mainColor))
                              ],
                            ),
                            SizedBox(height: 10 * height),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: 260 * width,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                          width: 120 * width,
                                          height: 20 * height,
                                          child: ListView.builder(
                                            itemCount: 5,
                                            scrollDirection: Axis.horizontal,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding: EdgeInsets.only(
                                                    right: 5 * width),
                                                child: Icon(
                                                    _int.toInt() == _int.round()
                                                        ? index <= _int.toInt()
                                                            ? EvaIcons.star
                                                            : EvaIcons
                                                                .starOutline
                                                        : index <= _int.toInt()
                                                            ? EvaIcons.star
                                                            : index ==
                                                                    _int.toInt() +
                                                                        1
                                                                ? FontAwesome
                                                                    .star_half_alt
                                                                : EvaIcons
                                                                    .starOutline,
                                                    size: 18 * width,
                                                    color: Colors.orange),
                                              );
                                            },
                                          )),
                                      SizedBox(width: 20 * width),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Reviews()));
                                        },
                                        child: Text(
                                            '(${itemholder.numberOfReviews} reviews)',
                                            style: GoogleFonts.acme(
                                                fontSize: 16 * width,
                                                fontWeight: FontWeight.normal,
                                                color: colors.activeColor)),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                          width: size.width,
                          height: 300 * height,
                          child: Image.network(itemholder.images[_index],
                              fit: BoxFit.cover)),
                      Container(
                        color: Colors.white,
                        padding: EdgeInsets.only(
                            left: 15 * width,
                            top: 15 * width,
                            bottom: 5 * height),
                        child: Center(
                          child: SizedBox(
                            height: 115 * height,
                            child: ListView.builder(
                              itemCount: itemholder.colors.length,
                              scrollDirection: Axis.horizontal,
                              //   physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.only(right: 8 * width),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _index = index;
                                      });
                                    },
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Container(
                                          width: 100 * width,
                                          height: 80 * width,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(itemholder
                                                      .images[index])),
                                              //   shape: BoxShape.circle,
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(8 * width)),
                                              border: Border.all(
                                                  width: 2,
                                                  color: _index == index
                                                      ? colors.mainColor
                                                      : Colors.transparent)),
                                        ),
                                        //   SizedBox(height: 5 * height),
                                        Text(itemholder.colors[index],
                                            style: GoogleFonts.acme(
                                                fontSize: 16 * width,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.black54)),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: size.width,
                        padding: EdgeInsets.symmetric(
                            horizontal: 15 * width, vertical: 10 * height),
                        child: Text(itemholder.desc,
                            style: GoogleFonts.acme(
                                fontSize: 16 * width,
                                fontWeight: FontWeight.normal,
                                color: Colors.black54)),
                      ),
                      itemholder.included.length == 0
                          ? Container()
                          : Column(
                              children: [
                                Container(
                                  width: size.width,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 15 * width,
                                      vertical: 10 * height),
                                  child: Text('What\'s included',
                                      style: GoogleFonts.acme(
                                          fontSize: 18 * width,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black)),
                                ),
                                Container(
                                  width: size.width,
                                  //  height: 30 * height,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 15 * width,
                                      vertical: 0 * height),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: itemholder.included.length,
                                    itemBuilder: (context, constructor) {
                                      return Padding(
                                        padding:
                                            EdgeInsets.only(bottom: 5 * width),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Icon(EvaIcons.checkmark,
                                                size: 20 * width,
                                                color: Colors.black),
                                            SizedBox(width: 15 * width),
                                            Text(
                                                itemholder
                                                    .included[constructor],
                                                style: GoogleFonts.acme(
                                                    fontSize: 16 * width,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: Colors.black
                                                        .withOpacity(.7))),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                    ],
                  ),
                )
              : index == 1
                  ? Container(
                      // height: 180 * height,
                      width: size.width,
                      color: Colors.white.withOpacity(.85),
                      padding:
                          EdgeInsets.only(left: 15 * width, right: 10 * width),
                      child: Column(
                        children: [
                          Container(
                            width: size.width,
                            padding: EdgeInsets.only(
                                bottom: 10 * height, top: 25 * height),
                            child: Text(
                                quantity > 1 ? 'Select colors' : 'Select color',
                                style: GoogleFonts.acme(
                                    fontSize: 18 * width,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black)),
                          ),
                          SizedBox(
                            width: size.width,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: quantity,
                              scrollDirection: Axis.vertical,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, constructor) {
                                return Column(
                                  children: [
                                    quantity != 1
                                        ? Container(
                                            width: size.width,
                                            padding: EdgeInsets.only(
                                                bottom: 10 * height,
                                                top: 25 * height),
                                            child: Text(
                                                'Select color ' +
                                                    (constructor + 1)
                                                        .toString(),
                                                style: GoogleFonts.acme(
                                                    fontSize: 18 * width,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: Colors.black
                                                        .withOpacity(.7))),
                                          )
                                        : Container(),
                                    SizedBox(
                                      height: 40 * height,
                                      child: ListView.builder(
                                        itemCount: itemholder.colors.length,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: EdgeInsets.only(
                                                right: 8 * width),
                                            child: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  _colorList[constructor]
                                                      .clear();
                                                  _colorList[constructor]
                                                      .add(index);
                                                  touchedCart = true;
                                                });
                                                print(_colorList);
                                              },
                                              child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 8 * width,
                                                      vertical: 5 * height),
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      border: Border.all(
                                                          width: 2,
                                                          color: _colorList[
                                                                      constructor]
                                                                  .contains(
                                                                      index)
                                                              ? colors.mainColor
                                                              : Colors
                                                                  .transparent)),
                                                  child: Center(
                                                    child: Text(
                                                        itemholder
                                                            .colors[index],
                                                        style:
                                                            GoogleFonts.acme(
                                                                fontSize:
                                                                    15 * width,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                color: Colors
                                                                    .black54)),
                                                  )),
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
                          Container(
                            width: size.width,
                            padding: EdgeInsets.only(
                                bottom: 10 * height, top: 15 * height),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Select quantity',
                                    style: GoogleFonts.acme(
                                        fontSize: 18 * width,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black)),
                                Container(
                                  height: 40 * height,
                                  width: 125 * width,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 2, color: Colors.black45)),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          if (quantity == 1) {
                                            setState(() {
                                              quantity = 1;
                                            });
                                          } else {
                                            setState(() {
                                              quantity = quantity - 1;
                                              _colorList.removeAt(quantity - 1);
                                            });
                                            touchedCart = true;

                                            print(_colorList);
                                          }
                                        },
                                        child: Container(
                                          width: 40 * width,
                                          height: 40 * height,
                                          child: Center(
                                            child: Icon(EvaIcons.minus,
                                                size: 18 * width,
                                                color: quantity == 1
                                                    ? Colors.black54
                                                    : Colors.black),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 40 * width,
                                        height: 40 * height,
                                        child: Center(
                                          child: Text(quantity.toString(),
                                              style: GoogleFonts.acme(
                                                  fontSize: 18 * width,
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.black)),
                                        ),
                                      ),
                                      GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              quantity = quantity + 1;
                                              _colorList.add([0]);
                                              touchedCart = true;

                                              print(_colorList);
                                            });
                                          },
                                          child: Container(
                                            width: 40 * width,
                                            height: 40 * height,
                                            child: Center(
                                              child: Icon(EvaIcons.plus,
                                                  size: 18 * width,
                                                  color: Colors.black),
                                            ),
                                          ))
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(
                      width: size.width,
                      color: Colors.white.withOpacity(.85),
                      padding: EdgeInsets.only(left: 15 * width),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: size.width,
                            padding: EdgeInsets.symmetric(
                                horizontal: 0 * width, vertical: 10 * height),
                            child: Text('About this product',
                                style: GoogleFonts.acme(
                                    fontSize: 20 * width,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black)),
                          ),
                          SizedBox(
                              width: 345 * width,
                              height: 220 * height,
                              child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                itemCount: 4,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return Container(
                                      width: 345 * width,
                                      height: 50 * height,
                                      decoration: BoxDecoration(
                                          border: Border(
                                              top: BorderSide(
                                                  width: index == 0 ? 2 : 0,
                                                  color: index == 0
                                                      ? Colors.black45
                                                      : Colors.transparent),
                                              bottom: BorderSide(
                                                  width: 2,
                                                  color: Colors.black45))),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              index == 0
                                                  ? 'Key features'
                                                  : index == 1
                                                      ? 'Environment & materials'
                                                      : index == 2
                                                          ? 'Good to know'
                                                          : 'Assembly instructions/documents',
                                              style: GoogleFonts.acme(
                                                  fontSize: 18 * width,
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.black
                                                      .withOpacity(.75))),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                right: 10 * width),
                                            child: Icon(
                                                EvaIcons.arrowIosDownward,
                                                size: 20 * width,
                                                color: Colors.black45),
                                          )
                                        ],
                                      ));
                                },
                              ))
                        ],
                      ),
                    );
        },
      ),
      bottomNavigationBar: Container(
          height: 80 * height,
          decoration: BoxDecoration(
              color: Colors.white, boxShadow: kElevationToShadow[3]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    tapped = !tapped;
                    animationController.reset();
                    animationController.forward();
                  });
                  print(tapped);
                },
                child: GestureDetector(
                  onTap: () async {
                    if (favsList.contains(itemholder.name)) {
                      setState(() {
                        favsList.remove(itemholder.name);
                      });

                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(userholder.email)
                          .collection('wishlist')
                          .where('name', isEqualTo: itemholder.name)
                          .get()
                          .then((value) {
                        value.docs.forEach((element) async {
                          await FirebaseFirestore.instance
                              .collection('users')
                              .doc(userholder.email)
                              .collection('wishlist')
                              .doc(element.id)
                              .delete();
                        });
                      });
                    } else {
                      setState(() {
                        favsList.add(itemholder.name);
                      });

                      int docNumber = 1000;
                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(userholder.email)
                          .get()
                          .then((value) {
                        docNumber = docNumber - value['wishList'].length;
                      });
                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(userholder.email)
                          .collection('wishlist')
                          .doc('00' + docNumber.toString())
                          .set({
                        'name': itemholder.name,
                        'images': itemholder.images,
                        'from': _index == 0
                            ? 'ottoman'
                            : _index == 1
                                ? 'chairs'
                                : _index == 2
                                    ? 'sofas'
                                    : 'tables',
                        'price': itemholder.price,
                        'colors': itemholder.colors
                      });
                    }
                  },
                  child: Container(
                    width: 70 * width,
                    height: 50 * height,
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.all(Radius.circular(5 * width)),
                        border: Border.all(color: colors.mainColor, width: 2)),
                    child: Center(
                        child: Icon(
                            favsList.contains(itemholder.name)
                                ? EvaIcons.heart
                                : EvaIcons.heartOutline,
                            size: tapped ? sizeAnimation.value : 30 * width,
                            color: colors.mainColor)),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  if (touchedCart) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      duration: Duration(seconds: 2),
                      content: Text('Adding to cart...',
                          style: GoogleFonts.acme(
                              fontSize: 14 * width,
                              fontWeight: FontWeight.normal,
                              color: Colors.white)),
                    ));
                    List toCartList = [];
                    int q1 = 0, q2 = 0, q3 = 0, q4 = 0, q5 = 0, q6 = 0;
                    int docNumber = 9999;
                    for (int i = 0; i <= _colorList.length - 1; i++) {
                      toCartList.add(_colorList[i][0]);
                    }

                    for (int j = 0; j <= toCartList.length - 1; j++) {
                      if (toCartList[j] == 0) {
                        q1 = q1 + 1;
                      }
                      if (toCartList[j] == 1) {
                        q2 = q2 + 1;
                      }
                      if (toCartList[j] == 2) {
                        q3 = q3 + 1;
                      }
                      if (toCartList[j] == 3) {
                        q4 = q4 + 1;
                      }
                      if (toCartList[j] == 4) {
                        q5 = q5 + 1;
                      }
                      if (toCartList[j] == 5) {
                        q6 = q6 + 1;
                      }
                    }

                    await FirebaseFirestore.instance
                        .collection('users')
                        .doc(userholder.email)
                        .collection('cart')
                        .get()
                        .then((value) {
                      docNumber = docNumber - value.docs.length;
                    });
                    await FirebaseFirestore.instance
                        .collection('users')
                        .doc(userholder.email)
                        .collection('cart')
                        .doc('00' + docNumber.toString())
                        .set({
                      'name': itemholder.name,
                      'price': itemholder.price,
                      'colors': itemholder.colors,
                      'images': itemholder.images,
                      'quantities': [q1, q2, q3, q4, q5, q6]
                    });

                    await FirebaseFirestore.instance
                        .collection('users')
                        .doc(userholder.email)
                        .get()
                        .then((value) async {
                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(userholder.email)
                          .update({
                        'cartTotalPrice': value['cartTotalPrice'] +
                            (q1 + q2 + q3 + q4 + q5 + q6) * itemholder.price
                      });
                    });

                    await FirebaseFirestore.instance
                        .collection('users')
                        .doc(userholder.email)
                        .get()
                        .then((value) async {
                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(userholder.email)
                          .update({
                        'cartItems':
                            value['cartItems'] + q1 + q2 + q3 + q4 + q5 + q6
                      });
                    });

                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                          itemholder.name +
                              ' added to cart successfully. Continue shopping',
                          style: GoogleFonts.acme(
                              fontSize: 14 * width,
                              fontWeight: FontWeight.normal,
                              color: Colors.white)),
                    ));
                    Navigator.pop(context);
                  } else {
                    _controller.scrollTo(
                        index: 1,
                        curve: Curves.linearToEaseOut,
                        duration: Duration(milliseconds: 1000));
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                          'You sure with the color and quantity selected?',
                          style: GoogleFonts.acme(
                              fontSize: 14 * width,
                              fontWeight: FontWeight.normal,
                              color: Colors.white)),
                    ));
                    setState(() {
                      touchedCart = !touchedCart;
                    });
                  }
                },
                child: Container(
                  width: 240 * width,
                  height: 50 * height,
                  decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.all(Radius.circular(5 * width)),
                      color: colors.mainColor),
                  child: Center(
                    child: Text('Add to Cart',
                        style: GoogleFonts.acme(
                            fontSize: 18 * width,
                            fontWeight: FontWeight.normal,
                            color: Colors.white)),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
