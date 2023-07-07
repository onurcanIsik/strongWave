import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:strongwave/bloc/mmo/bloc/mmo_bloc.dart';
import 'package:strongwave/colors/colors.dart';
import 'package:strongwave/core/model/mmoModel/mmo_models.dart';
import 'package:strongwave/core/service/mmo%20Service/mmo_service.dart';

class MMONews extends StatelessWidget {
  const MMONews({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<MMOFetchApi>(
      create: (context) => MMOFetchApi(),
      child: BlocProvider(
        create: (context) => MmoBloc(
          RepositoryProvider.of<MMOFetchApi>(context),
        )..add(
            LoadMMOEvent(),
          ),
        child: Scaffold(
          appBar: _appBar(),
          backgroundColor: bgColor,
          body: _getData(),
        ),
      ),
    );
  }

  BlocBuilder<MmoBloc, MmoState> _getData() {
    return BlocBuilder<MmoBloc, MmoState>(
      builder: (context, state) {
        if (state is MMOLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is MMOLoadedState) {
          List<MmoGames> games = state.gms;
          return ListView.builder(
            itemCount: games.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 10,
                  child: Container(
                    height: MediaQuery.of(context).size.height / 3.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        colorFilter: ColorFilter.mode(
                          Colors.white.withOpacity(0.5),
                          BlendMode.hardLight,
                        ),
                        image: NetworkImage(
                          games[index].thumbnail,
                        ),
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    child: Center(
                      child: ListTile(
                        title: Text(
                          games[index].title,
                          style: GoogleFonts.balooDa2(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                        subtitle: Text(
                          games[index].shortDescription,
                          style: GoogleFonts.balooDa2(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }
        return const Center(
          child: Text('HATACIK'),
        );
      },
    );
  }

  AppBar _appBar() {
    return AppBar(
      centerTitle: true,
      backgroundColor: appBarColor,
      title: Text(
        'MMO News',
        style: GoogleFonts.balooDa2(
          fontSize: 24,
        ),
      ),
    );
  }
}
