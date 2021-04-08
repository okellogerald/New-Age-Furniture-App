import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'classes.dart';

class MCard extends StatefulWidget {
  final String where, title, image;
  final int price;
  MCard(this.where, this.title, this.price, this.image);

  @override
  _MCardState createState() => _MCardState();
}

class _MCardState extends State<MCard> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final height = size.height / 752;
    final width = size.width / 360;
    return Container(
      height: 110 * height,
      width: 345 * width,
      child: Stack(
        children: [
          Positioned(
            top: 15 * height,
            child: Card(
              elevation: 3,
              shadowColor: Colors.grey.withOpacity(.2),
              child: Container(
                height: 90 * height,
                width: 330 * width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: 115 * width),
                    Container(
                      width: 200 * width,
                      height: 80 * height,
                      color: Colors.white70,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(widget.title,
                                  style: GoogleFonts.acme(
                                      fontSize: 16 * width,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black)),
                              widget.where == 'cart'
                                  ? Icon(EvaIcons.minusCircle,
                                      size: 22 * width, color: colors.mainColor)
                                  : Container()
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  widget.where == 'categories'
                                      ? widget.price.toString() + ' items'
                                      : 'Price \$ ' + widget.price.toString(),
                                  style: GoogleFonts.acme(
                                      fontSize: 16 * width,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black54)),
                              widget.where == 'bestseller' ||
                                      widget.where == 'cart'
                                  ? TextButton(
                                      onPressed: () {},
                                      style: TextButton.styleFrom(
                                          backgroundColor: Colors.black87),
                                      child: Text('Shop',
                                          style: GoogleFonts.acme(
                                              fontSize: 14 * width,
                                              fontWeight: FontWeight.normal,
                                              color: Colors.white)),
                                    )
                                  : Icon(EvaIcons.arrowForwardOutline,
                                      size: 22 * width, color: Colors.black54)
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 10 * height,
            left: 8 * width,
            child: Container(
              height: 90 * height,
              width: 100 * width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5 * width))),
              child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5 * width)),
                  child: Image.network(widget.image, fit: BoxFit.cover)),
            ),
          )
        ],
      ),
    );
  }
}
