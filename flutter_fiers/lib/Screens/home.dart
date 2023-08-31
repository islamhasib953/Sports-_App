import 'package:flutter/material.dart';
import 'package:flutter_fiers/Screens/countries.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  List names = ["FootBall", "BasketBall", "Cricket", "Tennis"];
  List images = [
    "lib/Assets/Images/Sports soccer.svg",
    "lib/Assets/Images/Sports basketball.svg",
    "lib/Assets/Images/Sports cricket.svg",
    "lib/Assets/Images/Sports tennis.svg"
  ];
  double getResponsiveHeight(double percentage, BuildContext context) {
    return MediaQuery.of(context).size.height * percentage;
  }

  double getResponsiveWidth(double percentage, BuildContext context) {
    return MediaQuery.of(context).size.width * percentage;
  }

  Widget buildGridItem(
      BuildContext context, int index, Orientation orientation) {
    double widthRatio = 0.3; // Default width ratio for portrait
    double heightRatio = 0.3; // Default height ratio for portrait
    if (orientation == Orientation.landscape) {
      widthRatio = 0.16; // Width ratio for landscape
      heightRatio = 0.5; // Height ratio for landscape
    }

    return InkWell(
      onTap: () {
        if (index == 0) {
           Navigator.push(context,  MaterialPageRoute<void>(
           builder: (BuildContext context) =>  CountriesScreen(),),);
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Alert',
                    style: GoogleFonts.robotoSlab(
                        color: Color.fromRGBO(65, 98, 126, 1),
                        fontWeight: FontWeight.w600)),
                content: Text('Coming Soon',
                    style: GoogleFonts.robotoSlab(
                        color: Color.fromRGBO(65, 98, 126, 1))),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Ok',
                        style: GoogleFonts.robotoSlab(
                            color: Color.fromRGBO(65, 98, 126, 1),
                            fontWeight: FontWeight.w600)),
                  ),
                ],
              );
            },
          );
        }
      },
      child: Padding(
        padding: EdgeInsets.all(
            getResponsiveWidth(0.03, context)), // Responsive padding
        child: Container(
          width: getResponsiveWidth(widthRatio, context), // Responsive width
          height:
              getResponsiveHeight(heightRatio, context), // Responsive height
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(getResponsiveWidth(
                widthRatio / 2, context)), // Responsive radius
            color: Color.fromRGBO(229, 236, 242, 0.70),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                images[index],
                height:
                    getResponsiveHeight(0.14, context), // Responsive SVG height
              ),
              SizedBox(
                  height:
                      getResponsiveHeight(0.02, context)), // Responsive spacing
              Text(
                names[index],
                style: GoogleFonts.robotoSlab(
                    color: Color.fromRGBO(65, 98, 126, 1),
                    fontSize: getResponsiveHeight(
                        0.03, context), // Responsive font size
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.white,
                    Colors.white,
                    Color.fromRGBO(101, 158, 199, 1),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            Column(
              children: [
                Container(
                  width: double.infinity,
                  height: getResponsiveHeight(
                      0.1, context), // Responsive app bar height
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(15)),
                    color: Color.fromRGBO(101, 158, 199, 1),
                  ),
                  child: Center(
                    child: Text(
                      "Select your favorite sport",
                      style: GoogleFonts.robotoSlab(
                          fontSize: getResponsiveHeight(
                              0.03, context), // Responsive font size
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                SizedBox(height: getResponsiveHeight(0.02, context)),
                Expanded(
                  child: OrientationBuilder(
                    builder: (context, orientation) {
                      if (orientation == Orientation.portrait) {
                        return buildPortraitGridView(context);
                      } else {
                        return buildLandscapeGridView(context);
                      }
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildPortraitGridView(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      children: [
        for (int i = 0; i < 4; i++)
          buildGridItem(
              context, i, Orientation.portrait), // Pass the orientation
      ],
    );
  }

  Widget buildLandscapeGridView(BuildContext context) {
    return GridView.count(
      crossAxisCount: 4,
      children: [
        for (int i = 0; i < 4; i++)
          buildGridItem(
              context, i, Orientation.landscape), // Pass the orientation
      ],
    );
  }
}
