import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fiers/Data/Cubits/GetPlayers/cubit/get_players_cubit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class Players extends StatelessWidget {
  final int id;
  Players({super.key, required this.id});
  final TextEditingController _searchController = TextEditingController();

  double getResponsiveHeight(double percentage, BuildContext context) {
    return MediaQuery.of(context).size.height * percentage;
  }

  double getResponsiveWidth(double percentage, BuildContext context) {
    return MediaQuery.of(context).size.width * percentage;
  }

  void _showPlayerDetailsDialog(BuildContext context, dynamic player) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(
                    player.playerImage ??
                        "https://jetpunk.b-cdn.net/img/user-photo-library/d8/d8f21957be-235.png",
                  ),
                ),
                SizedBox(height: 5),
                Text(player.playerName ?? "Unknown",
                    style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff41627E))),
                Text("Number: ${player.playerNumber ?? 'N/A'}"),
                Text("Country: ${player.playerCountry ?? 'N/A'}"),
                Text("Position: ${player.playerType ?? 'N/A'}"),
                Text("Age: ${player.playerAge ?? 'N/A'}"),
                Text("Yellow Cards: ${player.playerYellowCards ?? '0'}"),
                Text("Red Cards: ${player.playerRedCards ?? '0'}"),
                Text("Goals: ${player.playerGoals ?? '0'}"),
                Text("Assists: ${player.playerAssists ?? '0'}"),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: Text("Close"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    context.read<GetPlayersCubit>().getPlayers(id);

    return OrientationBuilder(
      builder: (context, orientation) {
        if (orientation == Orientation.portrait) {
          return buildPortraitLayout(context);
        } else {
          return buildLandscapeLayout(context);
        }
      },
    );
  }

  Widget buildPortraitLayout(BuildContext context) {
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
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
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
                      child: Text("Select Player",
                          style: GoogleFonts.robotoSlab(
                              fontSize: getResponsiveHeight(
                                  0.03, context), // Responsive font size
                              color: Colors.white,
                              fontWeight: FontWeight.w600)),
                    ),
                  ),
                  SizedBox(
                    height: getResponsiveHeight(0.02, context),
                  ),
                  Padding(
                    padding: EdgeInsets.all(getResponsiveWidth(0.025, context)),
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search player name...',
                        suffixIcon: Icon(
                          Icons.search,
                          color: Color.fromRGBO(101, 158, 199, 1),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                      onChanged: (searchQuery) {
                        // Here you can filter your player list based on the searchQuery
                      },
                    ),
                  ),

                  SizedBox(
                      height: getResponsiveHeight(
                          0.02, context)), // Responsive spacing
                  BlocBuilder<GetPlayersCubit, GetPlayersState>(
                    builder: (context, state) {
                      if (state is GetPlayersLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is GetPlayersSuccess) {
                        return Text(state.response.result[0].playerGoals);
                        //   final List<dynamic> filteredPlayers =
                        //       state.response.result.where((player) {
                        //     final playerName = player.playerName.toLowerCase();
                        //     final searchQuery =
                        //         _searchController.text.toLowerCase();
                        //     return playerName.contains(searchQuery);
                        //   }).toList();
                        //   return Column(
                        //     children: [
                        //       for (int i = 0;
                        //           i < state.response.result.length;
                        //           i++)
                        //         GestureDetector(
                        //           onTap: () {
                        //             _showPlayerDetailsDialog(
                        //                 context, state.response.result[i]);
                        //           },
                        //           child: Padding(
                        //             padding: EdgeInsets.all(getResponsiveWidth(
                        //                 0.025, context)), // Responsive padding
                        //             child: Container(
                        //               width: getResponsiveWidth(
                        //                   0.9, context), // Responsive width
                        //               height: getResponsiveHeight(
                        //                   0.2, context), // Responsive height
                        //               decoration: BoxDecoration(
                        //                 borderRadius: BorderRadius.circular(
                        //                     getResponsiveWidth(0.3,
                        //                         context)), // Responsive radius
                        //                 color:
                        //                     Color.fromRGBO(229, 236, 242, 0.70),
                        //               ),
                        //               child: Padding(
                        //                 padding: EdgeInsets.all(
                        //                     getResponsiveWidth(0.025,
                        //                         context)), // Responsive padding
                        //                 child: Row(
                        //                   mainAxisAlignment:
                        //                       MainAxisAlignment.start,
                        //                   children: [
                        //                     CircleAvatar(
                        //                       radius: getResponsiveWidth(0.1,
                        //                           context), // Responsive radius
                        //                       backgroundImage: NetworkImage(
                        //                         state.response.result[i]
                        //                                 .playerImage ??
                        //                             "https://jetpunk.b-cdn.net/img/user-photo-library/d8/d8f21957be-235.png",
                        //                       ),
                        //                     ),
                        //                     SizedBox(
                        //                       width: getResponsiveWidth(0.02,
                        //                           context), // Responsive spacing
                        //                     ),
                        //                     Column(
                        //                       mainAxisAlignment:
                        //                           MainAxisAlignment.center,
                        //                       children: [
                        //                         Text(
                        //                           state.response.result[i]
                        //                                   .playerName ??
                        //                               "Unknown",
                        //                           style: GoogleFonts.robotoSlab(
                        //                               fontSize: getResponsiveHeight(
                        //                                   0.02,
                        //                                   context), // Responsive font size
                        //                               fontWeight: FontWeight.w600,
                        //                               color: Color(0xff41627E)),
                        //                           softWrap: true,
                        //                         ),
                        //                         Text(
                        //                           'Position: ${state.response.result[i].playerType ?? "Unknown"}',
                        //                           style: GoogleFonts.robotoSlab(
                        //                               fontSize: getResponsiveHeight(
                        //                                   0.02,
                        //                                   context), // Responsive font size
                        //                               fontWeight: FontWeight.w600,
                        //                               color: Color(0xff41627E)),
                        //                           softWrap: true,
                        //                         ),
                        //                       ],
                        //                     ),
                        //                   ],
                        //                 ),
                        //               ),
                        //             ),
                        //           ),
                        //         ),
                        //     ],
                        //   );
                      } else {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Lottie.asset(
                              'lib/Assets/Images/animation_llw7fh94.json',
                              width: getResponsiveWidth(
                                  0.4, context), // Responsive width
                            ),
                            Text(
                              'An error has occurred',
                              style: GoogleFonts.inter(
                                  color: Color.fromRGBO(65, 98, 126, 1),
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        );
                      }
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildLandscapeLayout(BuildContext context) {
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
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: getResponsiveHeight(
                        0.2, context), // Responsive app bar height
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.vertical(bottom: Radius.circular(15)),
                      color: Color.fromRGBO(101, 158, 199, 1),
                    ),
                    child: Center(
                      child: Text("Select Player",
                          style: GoogleFonts.robotoSlab(
                              fontSize: getResponsiveHeight(
                                  0.05, context), // Responsive font size
                              color: Colors.white,
                              fontWeight: FontWeight.w600)),
                    ),
                  ),
                  SizedBox(
                    height: getResponsiveHeight(0.02, context),
                  ),
                  Padding(
                    padding: EdgeInsets.all(getResponsiveWidth(0.025, context)),
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search player name...',
                        suffixIcon: Icon(
                          Icons.search,
                          color: Color.fromRGBO(101, 158, 199, 1),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                      onChanged: (searchQuery) {
                        // Here you can filter your player list based on the searchQuery
                      },
                    ),
                  ),

                  SizedBox(
                    height: getResponsiveHeight(0.02, context),
                  ), // Responsive spacing
                  BlocBuilder<GetPlayersCubit, GetPlayersState>(
                    builder: (context, state) {
                      if (state is GetPlayersLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is GetPlayersSuccess) {
                        final List<dynamic> filteredPlayers =
                            state.response.result.where((player) {
                          final playerName = player.playerName.toLowerCase();
                          final searchQuery =
                              _searchController.text.toLowerCase();
                          return playerName.contains(searchQuery);
                        }).toList();
                        return GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            childAspectRatio: getResponsiveWidth(0.8, context) /
                                getResponsiveHeight(0.35, context),
                          ),
                          itemCount: state.response.result.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                _showPlayerDetailsDialog(
                                    context, state.response.result[index]);
                              },
                              child: Padding(
                                padding: EdgeInsets.all(getResponsiveWidth(
                                    0.025, context)), // Responsive padding
                                child: Container(
                                  width: getResponsiveWidth(
                                      0.9, context), // Responsive width
                                  height: getResponsiveHeight(
                                      0.3, context), // Responsive height
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        getResponsiveWidth(
                                            0.5, context)), // Responsive radius
                                    color: Color.fromRGBO(229, 236, 242, 0.70),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(getResponsiveWidth(
                                        0.025, context)), // Responsive padding
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        CircleAvatar(
                                          radius: 50, // Responsive radius
                                          backgroundImage: NetworkImage(
                                            state.response.result[index]
                                                    .playerImage ??
                                                "https://jetpunk.b-cdn.net/img/user-photo-library/d8/d8f21957be-235.png",
                                          ),
                                        ),
                                        SizedBox(
                                          width: getResponsiveWidth(0.005,
                                              context), // Responsive spacing
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              state.response.result[index]
                                                      .playerName ??
                                                  "Unknown",
                                              style: GoogleFonts.robotoSlab(
                                                  fontSize: getResponsiveHeight(
                                                      0.05,
                                                      context), // Responsive font size
                                                  fontWeight: FontWeight.w500,
                                                  color: Color(0xff41627E)),
                                              softWrap: true,
                                            ),
                                            Text(
                                              'Position: ${state.response.result[index].playerType ?? "Unknown"}',
                                              style: GoogleFonts.robotoSlab(
                                                  fontSize: getResponsiveHeight(
                                                      0.05,
                                                      context), // Responsive font size
                                                  fontWeight: FontWeight.w500,
                                                  color: Color(0xff41627E)),
                                              softWrap: true,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      } else {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Lottie.asset(
                                'lib/Assets/Images/animation_llw7fh94.json',
                                width: getResponsiveWidth(
                                    0.4, context), // Responsive width
                              ),
                            ),
                            Expanded(
                              child: Text(
                                'An error has occurred',
                                style: GoogleFonts.inter(
                                    color: Color.fromRGBO(65, 98, 126, 1),
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        );
                      }
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
