import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:strongwave/bloc/newspaper/bloc/news_paper_bloc.dart';
import 'package:strongwave/colors/colors.dart';
import 'package:strongwave/core/model/newsPaper/news_paper.dart';
import 'package:strongwave/core/service/news%20Paper%20Service/news_paper_service.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<NewsPaperApi>(
      create: (context) => NewsPaperApi(),
      child: BlocProvider(
        create: (context) => NewsPaperBloc(
          RepositoryProvider.of<NewsPaperApi>(context),
        )..add(
            LoadNewsPaperEvent(),
          ),
        child: Scaffold(
          appBar: _appBar(),
          backgroundColor: bgColor,
          body: _newsPaper(),
        ),
      ),
    );
  }

  Stack _newsPaper() {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: bgColor.withOpacity(0.5),
            image: DecorationImage(
              image: const AssetImage('assets/images/nobgDoodle2.png'),
              colorFilter: ColorFilter.mode(
                bgColor.withOpacity(0.5),
                BlendMode.dstATop,
              ),
            ),
          ),
        ),
        BlocBuilder<NewsPaperBloc, NewsPaperState>(
          builder: (context, state) {
            if (state is NewsPaperLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is NewsPaperLoadedState) {
              List<Article> artic = state.article;
              return ListView.builder(
                itemCount: artic.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                      bottom: 5,
                      top: 5,
                    ),
                    child: Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ListTile(
                        trailing: IconButton(
                          icon: Icon(Iconsax.chrome, color: appBarColor),
                          onPressed: () {
                            urlLauncher(artic[index].url);
                          },
                        ),
                        title: Text(artic[index].title),
                        subtitle: Text(artic[index].author),
                      ),
                    ),
                  );
                },
              );
            }
            return const Center(
              child: Text('LO'),
            );
          },
        ),
      ],
    );
  }

  void urlLauncher(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      Fluttertoast.showToast(msg: 'HATA');
    }
  }

  AppBar _appBar() {
    return AppBar(
      backgroundColor: appBarColor,
      title: Text(
        'Strong Wave',
        style: GoogleFonts.balooDa2(
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
