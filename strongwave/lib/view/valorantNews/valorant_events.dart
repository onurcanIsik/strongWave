import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:strongwave/bloc/news/news_bloc.dart';
import 'package:strongwave/colors/colors.dart';
import 'package:strongwave/core/service/valorant%20Service/valo_event_response.dart';

import '../../core/model/valorant/valorant_events_model.dart';

class ValorantEvents extends StatelessWidget {
  const ValorantEvents({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<ValorantEventApi>(
      create: (context) => ValorantEventApi(),
      child: BlocProvider(
        create: (context) => NewsBloc(
          RepositoryProvider.of<ValorantEventApi>(context),
        )..add(
            LoadDataEvent(),
          ),
        child: Scaffold(
          backgroundColor: bgColor,
          body: BlocBuilder<NewsBloc, NewsState>(
            builder: (context, state) {
              if (state is NewsLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is NewsLoadedState) {
                List<Datum?> newList = state.news;
                return ListView.builder(
                  itemCount: newList.length,
                  itemBuilder: (context, index) {
                    String dateStarting = newList[index]!.startTime.toString();
                    String dateEnding = newList[index]!.endTime.toString();
                    DateTime dateTime = DateTime.parse(dateStarting);
                    DateTime dateTimeEnd = DateTime.parse(dateEnding);
                    String dateStart =
                        "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";
                    String dateEnd =
                        "${dateTimeEnd.year}-${dateTimeEnd.month.toString().padLeft(2, '0')}-${dateTimeEnd.day.toString().padLeft(2, '0')}";
                    return SizedBox(
                      height: MediaQuery.of(context).size.height / 6,
                      width: MediaQuery.of(context).size.width / 1.3,
                      child: Card(
                        color: btmColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            Text(
                              newList[index]!.displayName.toString(),
                              style: GoogleFonts.balooDa2(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Short Name: ( ${newList[index]!.shortDisplayName.toString()} )",
                              style: GoogleFonts.comfortaa(
                                fontSize: 18,
                                color: bgColor,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 30),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "Start Time: $dateStart",
                                    style: GoogleFonts.comfortaa(
                                      color: Colors.green,
                                    ),
                                  ),
                                  Text(
                                    "End Time: $dateEnd",
                                    style: GoogleFonts.comfortaa(
                                      color: Colors.redAccent,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
              if (state is NewsErrorState) {
                return Center(
                  child: Text(state.errorMessage),
                );
              }
              return const Center(
                child: Text('ANAM'),
              );
            },
          ),
        ),
      ),
    );
  }
}
