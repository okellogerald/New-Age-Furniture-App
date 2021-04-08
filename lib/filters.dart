import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'classes.dart';

class Filters extends StatefulWidget {
  Filters({Key key}) : super(key: key);

  @override
  _FiltersState createState() => _FiltersState();
}

class _FiltersState extends State<Filters> {
  List<int> _list = [];
  List<int> _list1 = [];
  RangeValues range = RangeValues(40, 200);
  List<int> _list2 = [];
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final height = size.height / 752;
    final width = size.width / 360;

//LOOK AT THIS, AND STUDY IT, it might save you next time, you don't have to use Listview.builder() all the time.
    Widget _buildBrand(String brand, int number) {
      return GestureDetector(
        onTap: () {
          setState(() {
            _list.contains(number) ? _list.remove(number) : _list.add(number);
          });
          print(_list);
        },
        child: Container(
            width: 100 * width,
            height: 50 * height,
            decoration: BoxDecoration(
                border: Border.all(
                    width: 2,
                    color: _list.contains(number)
                        ? colors.mainColor
                        : Colors.black54)),
            child: Center(child: Image.network(brand, fit: BoxFit.contain))),
      );
    }

    Widget _buildCategory(String category, int number, String image) {
      return GestureDetector(
        onTap: () {
          setState(() {
            _list1.contains(number)
                ? _list1.remove(number)
                : _list1.add(number);
          });
        },
        child: Container(
            width: 100 * width,
            height: 100 * height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5 * width)),
            ),
            child: Stack(
              children: [
                Container(
                  width: 100 * width,
                  height: 100 * height,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5 * width)),
                  ),
                  child: ClipRRect(
                      borderRadius:
                          BorderRadius.all(Radius.circular(5 * width)),
                      child: Image.network(image, fit: BoxFit.cover)),
                ),
                Positioned(
                  bottom: 5 * height,
                  left: 5 * width,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 10 * width, vertical: 5 * height),
                    decoration: BoxDecoration(
                      color: _list1.contains(number)
                          ? colors.mainColor
                          : Colors.white24,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(category,
                            style: GoogleFonts.acme(
                                fontSize: 16 * width,
                                fontWeight: FontWeight.normal,
                                color: _list1.contains(number)
                                    ? Colors.white
                                    : Colors.black)),
                      ],
                    ),
                  ),
                ),
              ],
            )),
      );
    }

    return WillPopScope(
      onWillPop: () async {
        _list.clear();
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
          backgroundColor: Colors.grey,
          appBar: AppBar(
            leading: GestureDetector(
                onTap: () {
                  _list.clear();
                  Navigator.pop(context);
                },
                child: Icon(EvaIcons.close, color: Colors.black)),
            backgroundColor: Colors.white.withOpacity(.85),
            elevation: 1,
            centerTitle: true,
            title: Text('Filtering Ottoman',
                style: GoogleFonts.acme(
                    fontSize: 20 * width,
                    fontWeight: FontWeight.normal,
                    color: Colors.black)),
            actions: [
              Center(
                child: Padding(
                  padding: EdgeInsets.only(right: 20 * width),
                  child: Center(
                    child: Text('Done',
                        style: GoogleFonts.acme(
                            fontSize: 16 * width,
                            fontWeight: FontWeight.normal,
                            color: colors.activeColor)),
                  ),
                ),
              ),
            ],
          ),
          body: Container(
            width: size.width,
            height: size.height,
            color: Colors.white54,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: size.width,
                    height: 50 * height,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(width: 15 * width),
                        Text('Brand',
                            style: GoogleFonts.acme(
                                fontSize: 20 * width,
                                fontWeight: FontWeight.normal,
                                color: colors.blackColor)),
                      ],
                    ),
                  ),
                  Container(
                      width: size.width,
                      color: Colors.white,
                      padding: EdgeInsets.symmetric(
                          horizontal: 15 * width, vertical: 20 * height),
                      child: Wrap(
                          spacing: 10 * width,
                          runSpacing: 15 * width,
                          children: [
                            _buildBrand(
                                'https://firebasestorage.googleapis.com/v0/b/furniture-design-mobileapp.appspot.com/o/logo1.png?alt=media&token=d17f8ab4-acd5-4f68-82a3-6be300e83891',
                                1),
                            _buildBrand(
                                'https://firebasestorage.googleapis.com/v0/b/furniture-design-mobileapp.appspot.com/o/logo2.png?alt=media&token=8bef4b75-f0fe-4ce0-8cd9-409990c095d6',
                                2),
                            _buildBrand(
                                'https://firebasestorage.googleapis.com/v0/b/furniture-design-mobileapp.appspot.com/o/logo3.png?alt=media&token=62fb1422-d90f-45c9-9499-95de6e377055',
                                3),
                            _buildBrand(
                                'https://firebasestorage.googleapis.com/v0/b/furniture-design-mobileapp.appspot.com/o/logo4.png?alt=media&token=628f761e-260d-4214-83f0-57fc07515c2b',
                                4),
                            _buildBrand(
                                'https://firebasestorage.googleapis.com/v0/b/furniture-design-mobileapp.appspot.com/o/logo5.png?alt=media&token=6eb6d26b-dfef-4a6f-afe7-6f342cfd7415',
                                5),
                          ])),
                  Container(
                    width: size.width,
                    height: 50 * height,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(width: 15 * width),
                        Text('Types',
                            style: GoogleFonts.acme(
                                fontSize: 20 * width,
                                fontWeight: FontWeight.normal,
                                color: colors.blackColor)),
                      ],
                    ),
                  ),
                  Container(
                      width: size.width,
                      color: Colors.white,
                      padding: EdgeInsets.symmetric(
                          horizontal: 15 * width, vertical: 20 * height),
                      child: Wrap(
                          spacing: 10 * width,
                          runSpacing: 15 * width,
                          children: [
                            _buildCategory('sleeper', 1,
                                'https://i.pinimg.com/236x/d3/db/a7/d3dba7d3fd89086ba65741e8c13635d5.jpg'),
                            _buildCategory('cube', 2,
                                'https://i.pinimg.com/236x/5d/32/ce/5d32cef012c0688f2c2a53ebf549dd25.jpg'),
                            _buildCategory('cocktail', 3,
                                'https://i.pinimg.com/236x/52/e0/9f/52e09f832bafe26e8491c40f8acb8966.jpg'),
                            _buildCategory('tray top', 4,
                                'https://i.pinimg.com/236x/d7/88/a6/d788a6848f1b7eb939e3f30889408454.jpg'),
                            _buildCategory('smooth', 5,
                                'https://i.pinimg.com/236x/9e/d7/9f/9ed79f7b2d28e57a5027343087a9434f.jpg'),
                            _buildCategory('tufted', 6,
                                'https://i.pinimg.com/236x/26/ea/9e/26ea9e7769c4d28fb850b81d9c52f317.jpg')
                          ])),
                  Container(
                    width: size.width,
                    height: 50 * height,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(width: 15 * width),
                        Text('Colors',
                            style: GoogleFonts.acme(
                                fontSize: 20 * width,
                                fontWeight: FontWeight.normal,
                                color: colors.blackColor)),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(15 * width),
                    child: SizedBox(
                      height: 50 * height,
                      child: ListView.builder(
                        itemCount: 7,
                        scrollDirection: Axis.horizontal,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(right: 8 * width),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _list2.contains(index)
                                      ? _list2.remove(index)
                                      : _list2.add(index);
                                });
                              },
                              child: Container(
                                width: 35 * width,
                                height: 35 * width,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                    border: Border.all(
                                        width: 2,
                                        color: _list2.contains(index)
                                            ? colors.mainColor
                                            : Colors.transparent)),
                                child: Center(
                                  child: Container(
                                    width: 25 * width,
                                    height: 25 * width,
                                    decoration: BoxDecoration(
                                      color: index == 0
                                          ? colors.mainColor
                                          : index == 1
                                              ? Colors.orange
                                              : index == 2
                                                  ? Colors.black
                                                  : index == 3
                                                      ? Color(0xffF8E71E)
                                                      : index == 4
                                                          ? Color(0xff8B562A)
                                                          : index == 5
                                                              ? Color(
                                                                  0xff4990E2)
                                                              : Color(
                                                                  0xffD5CFCF),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Container(
                    width: size.width,
                    height: 50 * height,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(width: 15 * width),
                        Text('Price range',
                            style: GoogleFonts.acme(
                                fontSize: 20 * width,
                                fontWeight: FontWeight.normal,
                                color: colors.blackColor)),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    height: 90 * height,
                    padding: EdgeInsets.all(10 * width),
                    child: Column(
                      children: [
                        RangeSlider(
                            values: range,
                            onChanged: (values) {
                              setState(() {
                                range = values;
                              });
                            },
                          //  labels: RangeLabels('20', '800'),
                            min: 10,
                            max: 400,
                            activeColor: colors.mainColor,
                            inactiveColor: colors.inactiveColor),
                        Container(
                          width: 350 * width,padding: EdgeInsets.symmetric(horizontal: 20*width),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('\$ 10',
                                  style: GoogleFonts.acme(
                                      fontSize: 16 * width,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black54)),
                              Text('\$ 400',
                                  style: GoogleFonts.acme(
                                      fontSize: 16 * width,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black54)),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
