import 'package:flutter/material.dart';
import 'package:furniture_design/multiPurposeCard.dart';
import 'package:google_fonts/google_fonts.dart';

import 'category.dart';

class Categories extends StatefulWidget {
  Categories({Key key}) : super(key: key);

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
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
        centerTitle: true,
        title: Text('Categories',
            style: GoogleFonts.acme(
                fontSize: 18 * width,
                fontWeight: FontWeight.normal,
                color: Colors.black)),
      ),
      body: Container(
          width: size.width,
          height: size.height,
          color: Colors.white70,
          child: ListView.builder(
            padding: EdgeInsets.only(
                top: 5 * height, left: 10 * width, bottom: 10 * height),
            itemCount: 7,
            physics: AlwaysScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Category()));
                },
                child: MCard(
                    'categories',
                    index == 1
                        ? 'Decorations'
                        : index == 0
                            ? 'Living room furniture'
                            : index == 3
                                ? 'Bedroom furniture'
                                : index == 4
                                    ? 'Kitchen & Dining furniture'
                                    : index == 5
                                        ? 'Ceiling'
                                        : index == 6
                                            ? 'Floor'
                                            : 'Office furniture',
                    index == 0
                        ? 126
                        : index == 1
                            ? 457
                            : index == 2
                                ? 125
                                : index == 4
                                    ? 223
                                    : index == 5
                                        ? 65
                                        : index == 3
                                            ? 209
                                            : 342,
                    index == 0
                        ? 'https://i.pinimg.com/236x/dc/d2/2a/dcd22a8779ae0436c5986b0f0bf7199d.jpg'
                        : index == 1
                            ? 'https://i.pinimg.com/236x/5d/cb/47/5dcb470a5e9b5d4d2d67752289f5fd41.jpg'
                            : index == 2
                                ? 'https://i.pinimg.com/564x/86/71/3a/86713acb1b9cf1de1ffadf974b160b29.jpg'
                                : index == 3
                                    ? 'https://i.pinimg.com/236x/84/05/2d/84052dcc076f8c9139ef336e4f2065d9.jpg'
                                    : index == 4
                                        ? 'https://i.pinimg.com/236x/8c/35/d3/8c35d3194b24672cd0033dca70f6e7f7.jpg'
                                        : index == 5
                                            ? 'https://i.pinimg.com/236x/ad/5a/e4/ad5ae42512de72d24e356893fd6e036a.jpg'
                                            : 'https://i.pinimg.com/236x/e8/44/96/e844962b5b0155bdf03080c1f5af4910.jpg'),
              );
            },
          )),
    );
  }
}
