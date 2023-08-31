
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class PageContent extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;
   const PageContent({
   required this.imagePath,
   required this.title,
   required this.description,});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.1),
          Container(
            width: MediaQuery.of(context).size.width*282.161/360,
            height: MediaQuery.of(context).size.height*253.544/800,
            alignment: Alignment.topCenter,
         decoration: BoxDecoration(image: DecorationImage(image: AssetImage(imagePath),
         fit: BoxFit.fitHeight,
         ), ), ),
         SizedBox(height: MediaQuery.of(context).size.height * 0.06),
          Text(
            title,
            style: GoogleFonts.raleway(
              fontSize: 24,
              color: Color(0xff41627E),
              fontWeight: FontWeight.bold, ),
            textAlign:TextAlign.center,),
       SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            Text(
              description,
              style: GoogleFonts.robotoSlab(
                fontSize: 15,
                color: Color(0xff659EC7),
                fontWeight: FontWeight.normal, ),
              textAlign:TextAlign.center,
          ),],),);
  }}