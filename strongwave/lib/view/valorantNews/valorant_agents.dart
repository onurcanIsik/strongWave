import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:strongwave/bloc/agents/bloc/agents_bloc.dart';
import 'package:strongwave/colors/colors.dart';
import 'package:strongwave/core/service/valorant%20Service/valo_agents_response.dart';

import '../../core/model/valorant/valo_agent_model.dart';

class ValorantAgents extends StatelessWidget {
  const ValorantAgents({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<ValorantAgentApi>(
      create: (context) => ValorantAgentApi(),
      child: BlocProvider(
        create: (context) => AgentsBloc(
          RepositoryProvider.of<ValorantAgentApi>(context),
        )..add(
            LoadAgentEvent(),
          ),
        child: Scaffold(
          backgroundColor: bgColor,
          body: _getAllData(),
        ),
      ),
    );
  }

  BlocBuilder<AgentsBloc, AgentsState> _getAllData() {
    return BlocBuilder<AgentsBloc, AgentsState>(
      builder: (context, state) {
        if (state is AgentsLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is AgentsLoadedState) {
          List<Datum?> newList = state.agents;
          return ListView.builder(
            itemCount: newList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(4, 4),
                        spreadRadius: 1,
                        blurRadius: 3,
                        color: Colors.black38,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(30),
                    color: btmColor,
                    image: DecorationImage(
                      colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.5),
                        BlendMode.srcATop,
                      ),
                      fit: BoxFit.scaleDown,
                      image: NetworkImage(
                        newList[index]!.background.toString(),
                      ),
                    ),
                  ),
                  height: MediaQuery.of(context).size.height / 2,
                  width: MediaQuery.of(context).size.width / 5,
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
                      newList[index]!.bustPortrait == null
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : Image.network(
                              newList[index]!.bustPortrait.toString(),
                              fit: BoxFit.cover,
                              loadingBuilder: (
                                BuildContext context,
                                Widget child,
                                ImageChunkEvent? loadingProgress,
                              ) {
                                if (loadingProgress == null) return child;
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress.cumulativeBytesLoaded
                                                .toDouble() /
                                            loadingProgress.expectedTotalBytes!
                                                .toDouble()
                                        : null,
                                  ),
                                );
                              },
                            ),
                    ],
                  ),
                ),
              );
            },
          );
        }
        if (state is AgentsErrorState) {
          return Center(
            child: Text(state.errorMessage),
          );
        }
        return const Center(
          child: Text('ERROR'),
        );
      },
    );
  }
}
