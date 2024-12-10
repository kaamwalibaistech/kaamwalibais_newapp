import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaamwalijobs_new/assets/colors.dart';
import 'package:kaamwalijobs_new/bloc/homepage_bloc.dart';
import 'package:kaamwalijobs_new/bloc/homepage_state.dart';

class Alljobsopenings extends StatefulWidget {
  const Alljobsopenings({super.key});

  @override
  State<Alljobsopenings> createState() => _AlljobsopeningsState();
}

class _AlljobsopeningsState extends State<Alljobsopenings> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldColor,
      appBar: AppBar(
        backgroundColor: scaffoldColor,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back)),
      ),
      body: BlocConsumer<HomepageBloc, HomepageState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                if (state is HomePageLoadedState)
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.homepagemodel.joblist.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: const BoxDecoration(color: Colors.black),
                        ),
                      );
                    },
                  ),
              ],
            );
          }),
    );
  }
}
