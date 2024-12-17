import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaamwalijobs_new/assets/colors.dart';
import 'package:kaamwalijobs_new/bloc/homepage_bloc.dart';
import 'package:kaamwalijobs_new/bloc/homepage_state.dart';
import 'package:kaamwalijobs_new/models/homepage_model.dart';
import 'package:kaamwalijobs_new/screens/category_page.dart';

class Allcategories extends StatefulWidget {
  const Allcategories({super.key});

  @override
  State<Allcategories> createState() => _AllcategoriesState();
}

class _AllcategoriesState extends State<Allcategories> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldColor,
      appBar: AppBar(
        // title: const Text("All Categories"),
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back)),
        backgroundColor: scaffoldColor,
      ),
      body: BlocConsumer<HomepageBloc, HomepageState>(
          buildWhen: (previous, current) {
            if (current is HomePageLoadedState) {
              return true;
            }
            return false;
          },
          listener: (context, state) {},
          builder: (context, state) {
            if (state is HomePageLoadedState) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: GridView.builder(
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisSpacing: 20,
                            crossAxisCount: 3,
                            crossAxisSpacing: 20),
                    itemCount: state.homepagemodel.categorylist.length,
                    itemBuilder: (BuildContext context, int index) {
                      List<Categorylist> categories =
                          state.homepagemodel.categorylist;

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CategoryPage(
                                      categoryId:
                                          categories[index].categoryId)));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromARGB(255, 200, 197, 197),
                                  // spreadRadius: 1,
                                  blurRadius: 7,
                                  offset: Offset(
                                      5, 5), // changes position of shadow
                                ),
                              ],
                              color: whiteColor,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: const Color.fromARGB(
                                      255, 243, 243, 245))),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.network(
                                categories[index].image,
                                // color: const Color.fromARGB(255, 247, 115, 106),
                                height: 60,
                              ),
                              Text(
                                categories[index].categoryName,
                                style: const TextStyle(
                                    // color: blueColor,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            }
            return const CircularProgressIndicator();
          }),
    );
  }
}
