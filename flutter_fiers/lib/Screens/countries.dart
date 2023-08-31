import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fiers/Data/Cubits/cubit/countries_cubit.dart';
import 'package:flutter_fiers/Screens/league.dart';
import 'package:google_fonts/google_fonts.dart';

class CountriesScreen extends StatelessWidget {
  CountriesScreen({super.key});

  double getResponsiveHeight(double percentage, BuildContext context) {
    return MediaQuery.of(context).size.height * percentage;
  }

  double getResponsiveWidth(double percentage, BuildContext context) {
    return MediaQuery.of(context).size.width * percentage;
  }

  @override
  Widget build(BuildContext context) {
    context.read<CountriesCubit>().getCountries();
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
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
                SizedBox(height: getResponsiveHeight(0.01, context)),
                Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: getResponsiveHeight(0.1, context),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Color(0xff659EC7),
                  ),
                  child: Text(
                    'Select Country',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: getResponsiveHeight(0.03, context),
                        fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  height: getResponsiveHeight(0.02, context),
                ),
                BlocBuilder<CountriesCubit, CountriesState>(
                    builder: (context, state) {
                  if (state is CountriesLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is CountriesSuccess) {
                    return Expanded(
                      child: OrientationBuilder(
                        builder: (context, orientation) {
                          return GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount:
                                  (orientation == Orientation.portrait) ? 2 : 4,
                            ),
                            itemCount: state.response.result.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute<void>(
                                        builder: (BuildContext context) =>
                                            LeagueScreen(idleague: state.response.result[index].countryKey,),
                                      ));
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.all(
                                      getResponsiveWidth(0.02, context)),
                                  width: (orientation == Orientation.portrait)
                                      ? getResponsiveWidth(0.3, context)
                                      : getResponsiveWidth(0.16, context),
                                  height: (orientation == Orientation.portrait)
                                      ? getResponsiveHeight(0.3, context)
                                      : getResponsiveHeight(0.5, context),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        getResponsiveWidth(0.15, context)),
                                    color: Color(0xffe5ecf2),
                                  ),
                                  child: Stack(children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                            height: (orientation ==
                                                    Orientation.portrait)
                                                ? getResponsiveHeight(
                                                    0.03, context)
                                                : getResponsiveHeight(
                                                    0.05, context)),
                                        Container(
                                          width: (orientation ==
                                                  Orientation.portrait)
                                              ? getResponsiveWidth(
                                                  0.208, context)
                                              : getResponsiveWidth(
                                                  0.1, context),
                                          height: (orientation ==
                                                  Orientation.portrait)
                                              ? getResponsiveHeight(
                                                  0.09375, context)
                                              : getResponsiveHeight(
                                                  0.19, context),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                (orientation ==
                                                        Orientation.portrait)
                                                    ? getResponsiveWidth(
                                                        0.208 / 2, context)
                                                    : getResponsiveHeight(
                                                        0.208 / 2, context)),
                                            image: DecorationImage(
                                              image: NetworkImage(state
                                                      .response
                                                      .result[index]
                                                      .countryLogo ??
                                                  ''),
                                              fit: (orientation ==
                                                      Orientation.portrait)
                                                  ? BoxFit.fitHeight
                                                  : BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                            height: getResponsiveHeight(
                                                0.02, context)),
                                        Container(
                                          alignment: Alignment.center,
                                          child: Text(
                                            state.response.result[index]
                                                    .countryName ??
                                                '',
                                            style: TextStyle(
                                              fontSize: (orientation ==
                                                      Orientation.portrait)
                                                  ? 20
                                                  : 18,
                                              color: Color(0xff41627E),
                                              fontWeight: FontWeight.w400,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        )
                                      ],
                                    ),
                                  ]),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    );
                  } else {
                    return Center(
                      child: Text("Something went wrong"),
                    );
                  }
                })
              ],
            )
          ],
        ),
      ),
    );
  }
}
