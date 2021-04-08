
import 'package:flutter/material.dart';

class ProjectColors {
  Color mainColor = Color(0xffCF021F);
  Color inactiveColor = Color(0xffEAEAEA);
  Color activeColor = Color(0xff4990E2);
  Color blackColor = Colors.black;
}

ProjectColors colors = ProjectColors();

class UserDetails {
  String image;
  String email;
  String name;
    bool addreview = true;

}

class ItemDetails {
  double price, avgRate;
  int numberOfReviews;
  String name, desc, type, brand, category;
  List images, colors, included;
}

UserDetails userholder = UserDetails();
ItemDetails itemholder = ItemDetails();

//use classes with constructors if you want to assign variables all at once;
//for example the above class would be class UserDetails{final String image,email,name; UserDetails(this.image,this.email,this.name)}
//when assigning UserDetails userdetails = new UserDetails(someiamge,someemail,somename)
//with constructor wherever the class goes, so are its children, name us all at once
//without a constructor a class doesn't care about his children, name them at whatever point you like
