import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaamwalijobs_new/features/dashboard/presentation/location/bloc/select_location_bloc.dart';

class LocationSelectScreen extends StatefulWidget {
  const LocationSelectScreen({super.key});

  @override
  State<LocationSelectScreen> createState() => _LocationSelectScreenState();
}

class _LocationSelectScreenState extends State<LocationSelectScreen> {
  @override
  void initState() {
    super.initState();
    context.read<SelectLocationBloc>().add(GetCurrentLocationEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.blue.shade100,
        title: Padding(
          padding: const EdgeInsets.only(right: 25),
          child: Material(
            elevation: 8,
            borderRadius: BorderRadius.circular(30.0),
            shadowColor: Colors.black26,
            child: TextField(
              onChanged: (value) =>
                  context.read<SelectLocationBloc>().add(SearchEvent(value)),
              onSubmitted: (value) =>
                  context.read<SelectLocationBloc>().add(SearchEvent(value)),
              cursorColor: Colors.blue.shade700,
              decoration: InputDecoration(
                hintText: "Search ",
                hintStyle: TextStyle(color: Colors.grey[600]),
                prefixIcon: const Icon(Icons.search,
                    color: Color.fromARGB(255, 0, 100, 181)),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(
                    color: Colors.deepPurple.shade400,
                    width: MediaQuery.of(context).size.width * 0.005,
                  ),
                ),
              ),
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<SelectLocationBloc, SelectLocationState>(
        builder: (context, state) {
          if (state is SelectLocationInitialState) {
            context.read<SelectLocationBloc>().add(GetCurrentLocationEvent());
            return Column(
              children: [
                GestureDetector(
                  onTap: () {
                    context
                        .read<SelectLocationBloc>()
                        .add(GetCurrentLocationEvent());
                  },
                  child: ListTile(
                    leading: Icon(
                      size: 16,
                      Icons.my_location,
                      color: Colors.blue.shade700,
                    ),
                    title: Text(
                      "Click to get current location",
                      style: TextStyle(fontSize: 14),
                    ),
                    textColor: Colors.blue.shade700,
                  ),
                )
              ],
            );
          } else if (state is SelectLocationSearchingState) {
            return ListView.builder(
                itemCount: state.searchLocationModel!.predictions.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      String city = state
                          .searchLocationModel!.predictions[index].description;
                      Navigator.pop(context, city);
                    },
                    child: ListTile(
                      title: Text(state.searchLocationModel!.predictions[index]
                          .structuredFormatting.mainText),
                      subtitle: Text(state
                          .searchLocationModel!
                          .predictions[index]
                          .structuredFormatting
                          .secondaryText),
                    ),
                  );
                });
          } else if (state is SelectLocationSuccessState) {
            return Column(
              children: [
                GestureDetector(
                  onTap: () {
                    String city = state.address;
                    Navigator.pop(context, city);
                  },
                  child: ListTile(
                    leading: Icon(
                      size: 16,
                      Icons.my_location,
                      color: Colors.blue.shade700,
                    ),
                    title: Text(
                      "${state.address}",
                      style: TextStyle(fontSize: 14),
                    ),
                    textColor: Colors.blue.shade700,
                  ),
                )
              ],
            );
          } else if (state is SelectLocationErrorState) {
            return Padding(
              padding: const EdgeInsets.all(30),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.location_off_rounded,
                      size: 70,
                      color: const Color.fromARGB(255, 212, 15, 1),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      state.error,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          }

          return Text("No State");
        },
      ),
    );
  }
}
