import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';

import 'classes.dart';
import 'filters.dart';
import 'item.dart';

class Category extends StatefulWidget {
  Category({Key key}) : super(key: key);

  @override
  _CategoryState createState() => _CategoryState();
}

List favsList = [];

class _CategoryState extends State<Category> {
  @override
  void initState() {
    super.initState();
    assignList();
  }

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
    print(favsList);
  }

  PageController __controller = PageController();
  int _index = 0;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final height = size.height / 752;
    final width = size.width / 360;
    return WillPopScope(
      onWillPop: () async {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userholder.email)
            .update({'wishList': favsList});
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white.withOpacity(.9),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white.withOpacity(.85),
          //  automaticallyImplyLeading: false,leading: Icon(EvaIcons.),
          elevation: 1,
          centerTitle: true,
          title: Text('Living room furniture',
              style: GoogleFonts.acme(
                  fontSize: 18 * width,
                  fontWeight: FontWeight.normal,
                  color: Colors.black)),
          bottom: PreferredSize(
            preferredSize: Size(size.width, 40),
            child: SizedBox(
              height: 40 * height,
              width: size.width,
              child: ListView.builder(
                itemCount: 4,
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.only(top: 10 * height),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _index = index;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: 15 * width,
                              right: index == 5 ? 40 * width : 20 * width),
                          child: Text(
                              index == 0
                                  ? 'Ottoman'
                                  : index == 1
                                      ? 'Chairs'
                                      : index == 2
                                          ? 'Sofas'
                                          : 'Tables',
                              style: GoogleFonts.acme(
                                  fontSize: 16 * width,
                                  fontWeight: FontWeight.normal,
                                  color: _index == index
                                      ? colors.mainColor
                                      : Colors.black)),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 15 * width),
                          child: Container(
                              width: _index == 2 ? 30 * width : 40 * width,
                              height: 3 * height,
                              color: _index == index
                                  ? colors.mainColor
                                  : Colors.transparent),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        body: PageView.builder(
          itemCount: 4,
          controller: __controller,
          onPageChanged: (value) {
            setState(() {
              _index = value;
            });
          },
          itemBuilder: (context, constructor) {
            return StreamBuilder(
                stream: _index == 0
                    ? FirebaseFirestore.instance
                        .collection('ottoman')
                        .snapshots()
                    : _index == 1
                        ? FirebaseFirestore.instance
                            .collection('chairs')
                            .snapshots()
                        : _index == 2
                            ? FirebaseFirestore.instance
                                .collection('sofas')
                                .snapshots()
                            : FirebaseFirestore.instance
                                .collection('tables')
                                .snapshots(),
                builder: (context, snapshot) {
                  return !snapshot.hasData ||
                          snapshot.hasError ||
                          snapshot.connectionState == ConnectionState.none
                      ? Center(
                          child: CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation(colors.mainColor)))
                      : StaggeredGridView.countBuilder(
                          padding: EdgeInsets.all(10 * width),
                          crossAxisCount: 2,
                          mainAxisSpacing: 12 * width,
                          crossAxisSpacing: 12 * width,
                          itemCount: snapshot.data.docs.length,
                          physics: AlwaysScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            DocumentSnapshot furniture =
                                snapshot.data.docs[index];

                            return ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10 * width)),
                              child: Stack(
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      itemholder.price = furniture['0price'];
                                      itemholder.name = furniture['1name'];
                                      itemholder.images = furniture['2images'];
                                      itemholder.colors = furniture['3colors'];
                                      itemholder.desc = furniture['4desc'];
                                      itemholder.avgRate =
                                          furniture['7av-rate'];
                                      itemholder.included =
                                          furniture['9included'];
                                      itemholder.numberOfReviews =
                                          furniture['8no-reviews'];

                                      itemholder.category = _index == 0
                                          ? 'ottoman'
                                          : _index == 1
                                              ? 'chairs'
                                              : _index == 2
                                                  ? 'sofas'
                                                  : 'tables';
                                      await FirebaseFirestore.instance
                                          .collection('users')
                                          .doc(userholder.email)
                                          .update({'wishList': favsList});
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Item()));
                                    },
                                    child: Image.network(
                                        furniture['2images'][0],
                                        fit: BoxFit.cover),
                                  ),
                                  Positioned(
                                    bottom: 10 * height,
                                    left: 55 * width,
                                    child: Container(
                                      color: Colors.white.withOpacity(.4),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10 * width,
                                          vertical: 5 * width),
                                      child: Text(
                                          '\$ ' +
                                              furniture['0price'].toString(),
                                          style: GoogleFonts.acme(
                                              fontSize: 16 * width,
                                              fontWeight: FontWeight.normal,
                                              color: Colors.black)),
                                    ),
                                  ),
                                  Positioned(
                                      right: 10 * width,
                                      top: 10 * height,
                                      child: GestureDetector(
                                          onTap: () async {
                                            if (favsList
                                                .contains(furniture['1name'])) {
                                              setState(() {
                                                favsList
                                                    .remove(furniture['1name']);
                                              });

                                              await FirebaseFirestore.instance
                                                  .collection('users')
                                                  .doc(userholder.email)
                                                  .collection('wishlist')
                                                  .where('name',
                                                      isEqualTo:
                                                          furniture['1name'])
                                                  .get()
                                                  .then((value) {
                                                value.docs
                                                    .forEach((element) async {
                                                  await FirebaseFirestore
                                                      .instance
                                                      .collection('users')
                                                      .doc(userholder.email)
                                                      .collection('wishlist')
                                                      .doc(element.id)
                                                      .delete();
                                                });
                                              });
                                            } else {
                                              setState(() {
                                                favsList
                                                    .add(furniture['1name']);
                                              });

                                              int docNumber =
                                                  1000 - favsList.length;

                                              await FirebaseFirestore.instance
                                                  .collection('users')
                                                  .doc(userholder.email)
                                                  .collection('wishlist')
                                                  .doc('000' +
                                                      docNumber.toString())
                                                  .set({
                                                'name': furniture['1name'],
                                                'images': furniture['2images'],
                                                'from': _index == 0
                                                    ? 'ottoman'
                                                    : _index == 1
                                                        ? 'chairs'
                                                        : _index == 2
                                                            ? 'sofas'
                                                            : 'tables',
                                                'price': furniture['0price'],
                                                'colors': furniture['3colors']
                                              });
                                            }
                                          },
                                          child: Icon(
                                              favsList.contains(
                                                      furniture['1name'])
                                                  ? EvaIcons.heart
                                                  : EvaIcons.heartOutline,
                                              color: favsList.contains(
                                                      furniture['1name'])
                                                  ? colors.mainColor
                                                  : Colors.black,
                                              size: 22 * width)))
                                ],
                              ),
                            );
                          },
                          staggeredTileBuilder: (index) => StaggeredTile.fit(1),
                        );
                });
          },
        ),
        floatingActionButton: Align(
            alignment: Alignment(-0.75, 1),
            child: FloatingActionButton(
                backgroundColor: colors.mainColor,
                child: Icon(EvaIcons.funnelOutline, color: Colors.white),
                onPressed: () async {
                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc(userholder.email)
                      .update({'wishList': favsList});
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Filters()));
                })),
      ),
    );
  }
}
