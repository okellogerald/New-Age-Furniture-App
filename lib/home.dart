import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:furniture_design/favs.dart';
import 'package:furniture_design/multiPurposeCard.dart';
import 'package:google_fonts/google_fonts.dart';
import 'account.dart';
import 'cart.dart';
import 'classes.dart';

class Home extends StatefulWidget {
  Home();

  @override
  _HomeState createState() => _HomeState();
}

GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

class _HomeState extends State<Home> {
  int _index = 0;
  List<String> categories = [
    'Accent Chairs',
    'Living Room Furniture',
    'Kitchen & Dining Furniture',
    'Office Furniture',
    'Decorations'
  ];
  List<int> items = [54, 107, 204, 34, 67];
  bool setDrawerOpen = false;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final height = size.height / 752;
    final width = size.width / 360;
    List<String> categories = [
      'Decorations',
      'Living Room Furniture',
      'Kitchen & Dining Furniture',
      'Office Furniture',
      'Ceiling'
    ];
    List<int> items = [54, 107, 204, 34, 67];

    _buildItems(IconData icon, String item) {
      return ListTile(
          trailing: Icon(EvaIcons.arrowForwardOutline),
          leading: Icon(icon, color: Colors.black54),
          title: Text(item,
              style: GoogleFonts.acme(
                  fontSize: 16 * width,
                  fontWeight: FontWeight.normal,
                  color: Colors.black54)));
    }

    _builUserDetails() {
      return ListTile(
          title: Row(
        children: [
          CircleAvatar(backgroundImage: NetworkImage(userholder.image)),
          SizedBox(width: 20),
          Column(
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
        ],
      ));
    }

    return Scaffold(
        key: scaffoldKey,
        drawer: Drawer(
          child: Container(
            width: 330 * width,
            height: size.height,
            child: Column(
              children: [
                SizedBox(height: 60 * height),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(EvaIcons.close,
                            size: 26 * width, color: Colors.black)),
                    SizedBox(width: 20 * width)
                  ],
                ),
                SizedBox(height: 30 * height),
                _builUserDetails(),
                SizedBox(height: 50 * height),
                _buildItems(EvaIcons.home, 'Home'),
                _buildItems(EvaIcons.archive, 'New Collections'),
                _buildItems(EvaIcons.bookmark, 'Editor\'s Picks'),
                _buildItems(EvaIcons.pricetags, 'Top Deals'),
                _buildItems(EvaIcons.bell, 'Notifications'),
                _buildItems(EvaIcons.settings, 'Settings'),
                GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Account()));
                    },
                    child: _buildItems(EvaIcons.person, 'My Account')),
                SizedBox(height: 80 * height),
                GestureDetector(
                    onTap: () async {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        duration: Duration(seconds: 3),
                        backgroundColor: Colors.black,
                        content: Text(
                            'Logging you out, the app will close immadiately after the process is completed',
                            style: GoogleFonts.acme(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: Colors.white)),
                      ));

                      if (FirebaseAuth.instance.currentUser != null) {
                        await FirebaseAuth.instance.currentUser.delete();
                      }

                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(userholder.email)
                          .collection('cart')
                          .get()
                          .then((value) {
                        value.docs.forEach((element) async {
                          await FirebaseFirestore.instance
                              .collection('users')
                              .doc(userholder.email)
                              .collection('cart')
                              .doc(element.id)
                              .delete();
                        });
                      });
                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(userholder.email)
                          .collection('wishlist')
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
                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(userholder.email)
                          .delete();

                      SystemNavigator.pop();
                    },
                    child: _buildItems(EvaIcons.logOut, 'Log out')),
              ],
            ),
          ),
        ),
        body: Container(
          width: size.width,
          height: size.height,
          color: Colors.white70,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    SizedBox(
                      width: size.width,
                      height: 350 * height,
                      child: PageView.builder(
                        itemCount: 3,
                        scrollDirection: Axis.horizontal,
                        onPageChanged: (value) {
                          setState(() {
                            _index = value;
                          });
                        },
                        itemBuilder: (context, index) {
                          return Container(
                            width: size.width,
                            height: 350 * height,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(_index == 0
                                        ? 'https://firebasestorage.googleapis.com/v0/b/furniture-design-mobileapp.appspot.com/o/042e9cb331234c6d36cef94523aecc7c.png?alt=media&token=f3aa4827-a92c-4a8c-9745-04d4f441d249'
                                        : _index == 1
                                            ? 'https://firebasestorage.googleapis.com/v0/b/furniture-design-mobileapp.appspot.com/o/pexels-photo-5793641.png?alt=media&token=701bff73-8e91-456f-bc84-116332a99770'
                                            : 'https://firebasestorage.googleapis.com/v0/b/furniture-design-mobileapp.appspot.com/o/c7b65834434b04b0577a2c698e31bb38.png?alt=media&token=002e7869-ef2b-49d0-9eb9-44fa5cac7909'),
                                    fit: BoxFit.cover)),
                            child: Container(
                              height: 150 * height,
                              padding: EdgeInsets.only(left: 20 * width),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 100 * height),
                                  Text(
                                      _index == 0
                                          ? 'Collection'
                                          : _index == 1
                                              ? 'Black Fridays'
                                              : 'Cyber Mondays',
                                      style: GoogleFonts.acme(
                                          fontSize: 16 * width,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.white70)),
                                  Text(
                                      _index == 0
                                          ? 'New\nWinter Arrivals'
                                          : _index == 1
                                              ? 'Sale Up\nTo 70% Off'
                                              : 'Big  Sale\n50% Off',
                                      style: GoogleFonts.acme(
                                          fontSize: 36 * width,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white)),
                                  SizedBox(height: 20 * height),
                                  TextButton(
                                    onPressed: () {},
                                    style: TextButton.styleFrom(
                                      backgroundColor: Color(0xff262C38),
                                      primary: Color(0xff262C38),
                                    ),
                                    child: Text('Shop now',
                                        style: GoogleFonts.acme(
                                            fontSize: 16 * width,
                                            fontWeight: FontWeight.normal,
                                            color: Colors.white)),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Positioned(
                      top: 40 * height,
                      child: Container(
                          width: size.width,
                          height: 50 * height,
                          padding: EdgeInsets.symmetric(horizontal: 20 * width),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  scaffoldKey.currentState.openDrawer();
                                },
                                child: Icon(EvaIcons.menu,
                                    size: 20 * width, color: Colors.black),
                              ),
                              Container(
                                width: 70 * width,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Cart())),
                                      child: Icon(EvaIcons.shoppingBagOutline,
                                          color: Colors.black,
                                          size: 20 * width),
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Favourites()));

                                        /*   final GoogleSignInAccount googleUser =
                                        await _gSignIn.signIn();

                                    final GoogleSignInAuthentication
                                        googleAuth =
                                        await googleUser.authentication;

                                    final AuthCredential credential =
                                        GoogleAuthProvider.credential(
                                      accessToken: googleAuth.accessToken,
                                      idToken: googleAuth.idToken,
                                    );
                                     _gSignIn.signOut();
                                    print('signed out'); 
                                    FirebaseAuth.instance.currentUser
                                        .reauthenticateWithCredential(
                                            credential); */
                                        //  FirebaseAuth.instance.currentUser.delete();
                                      },
                                      child: Icon(
                                        EvaIcons.heart,
                                        size: 20 * width,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )),
                    ),
                    Positioned(
                      left: 20 * width,
                      bottom: 10 * height,
                      child: SizedBox(
                          width: 60 * width,
                          height: 10 * height,
                          child: ListView.builder(
                            itemCount: 3,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.only(right: 8 * width),
                                child: AnimatedContainer(
                                  duration: Duration(milliseconds: 400),
                                  curve: Curves.easeIn,
                                  height: 10 * height,
                                  width:
                                      _index == index ? 20 * width : 10 * width,
                                  decoration: BoxDecoration(
                                      color: _index == index
                                          ? colors.mainColor
                                          : colors.inactiveColor,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(50 * width))),
                                ),
                              );
                            },
                          )),
                    )
                  ],
                ),
                SizedBox(height: 20 * height),
                Padding(
                  padding: EdgeInsets.only(left: 20 * width),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 5 * width),
                              child: Text('Categories',
                                  style: GoogleFonts.acme(
                                      fontSize: 20 * width,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black)),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 20 * width),
                              child: GestureDetector(
                                onTap: () =>
                                    Navigator.pushNamed(context, 'categories'),
                                child: Text('See all',
                                    style: GoogleFonts.acme(
                                        fontSize: 16 * width,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black54)),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10 * height),
                        SizedBox(
                            height: 230 * height,
                            child: ListView.builder(
                              itemCount: 5,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.only(right: 15 * width),
                                  child: Container(
                                    width: 130 * width,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Card(
                                          elevation: 3,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5 * width)),
                                          ),
                                          child: Container(
                                            width: 130 * width,
                                            height: 150 * height,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(
                                                        5 * width))),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5 * width)),
                                              child: Image.network(
                                                index == 0
                                                    ? 'https://i.pinimg.com/236x/9a/28/05/9a2805a12a9a775dd4fff5a4630653f8.jpg'
                                                    : index == 1
                                                        ? 'https://i.pinimg.com/236x/dc/d2/2a/dcd22a8779ae0436c5986b0f0bf7199d.jpg'
                                                        : index == 2
                                                            ? 'https://i.pinimg.com/236x/8c/35/d3/8c35d3194b24672cd0033dca70f6e7f7.jpg'
                                                            : index == 3
                                                                ? 'https://i.pinimg.com/564x/86/71/3a/86713acb1b9cf1de1ffadf974b160b29.jpg'
                                                                : 'https://i.pinimg.com/236x/ad/5a/e4/ad5ae42512de72d24e356893fd6e036a.jpg',
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 8 * height),
                                        Container(
                                          width: 130 * width,
                                          height: 40 * height,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                left: 2 * width),
                                            child: Text(
                                                index == 0
                                                    ? categories[0]
                                                    : index == 1
                                                        ? categories[1]
                                                        : index == 2
                                                            ? categories[2]
                                                            : index == 3
                                                                ? categories[3]
                                                                : categories[4],
                                                style: GoogleFonts.acme(
                                                    fontSize: 16 * width,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: Colors.black)),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 6 * height, left: 2 * width),
                                          child: Text(
                                              index == 0
                                                  ? items[0].toString() +
                                                      ' items'
                                                  : index == 1
                                                      ? items[1].toString() +
                                                          ' items'
                                                      : index == 2
                                                          ? items[2]
                                                                  .toString() +
                                                              ' items'
                                                          : index == 3
                                                              ? items[3]
                                                                      .toString() +
                                                                  ' items'
                                                              : items[4]
                                                                      .toString() +
                                                                  ' items',
                                              style: GoogleFonts.acme(
                                                  fontSize: 14 * width,
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.black54)),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            )),
                        SizedBox(height: 20 * height),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 5 * width),
                              child: Text('BestSelling',
                                  style: GoogleFonts.acme(
                                      fontSize: 20 * width,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black)),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 20 * width),
                              child: Text('See all',
                                  style: GoogleFonts.acme(
                                      fontSize: 16 * width,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black54)),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 340 * width,
                          height: 580 * height,
                          child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemCount: 5,
                            padding: EdgeInsets.only(top: 5 * height),
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.only(bottom: 0 * height),
                                child: MCard(
                                    'bestseller',
                                    index == 0
                                        ? 'Downlight floor lamp'
                                        : index == 1
                                            ? 'Leather armchair'
                                            : index == 2
                                                ? 'Console table'
                                                : index == 3
                                                    ? 'Creer desk'
                                                    : 'Wide polyester armchair',
                                    index == 0
                                        ? 53
                                        : index == 1
                                            ? 100
                                            : index == 2
                                                ? 67
                                                : index == 3
                                                    ? 98
                                                    : 120,
                                    index == 0
                                        ? 'https://i.pinimg.com/236x/12/ea/98/12ea98b6a57e1527827c48543a7e9699.jpg'
                                        : index == 1
                                            ? 'https://i.pinimg.com/236x/1a/68/f7/1a68f75d49624d4044cfe1c76924cc98.jpg'
                                            : index == 2
                                                ? 'https://i.pinimg.com/236x/e8/4c/8b/e84c8b57db89c653a6fdb6a56684e62a.jpg'
                                                : index == 3
                                                    ? 'https://i.pinimg.com/236x/0f/1b/0b/0f1b0b9a0a0bbf54d35ae188cabd1963.jpg'
                                                    : 'https://i.pinimg.com/236x/7f/d5/55/7fd5558a636ccaa2b76bf185fe661f0c.jpg'),
                              );
                            },
                          ),
                        ),
                        //  SizedBox(height: 20 * height),
                      ]),
                )
              ],
            ),
          ),
        ));
  }
}
