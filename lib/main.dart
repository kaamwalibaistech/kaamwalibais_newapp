import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kaamwalijobs_new/bloc/homepage_bloc.dart';
import 'package:kaamwalijobs_new/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:kaamwalijobs_new/features/dashboard/network/dashboard_network.dart';
import 'package:kaamwalijobs_new/screens/splashscreen.dart';

Future main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomepageBloc>(create: (context) => HomepageBloc()),
        BlocProvider<DashboardBloc>(
            create: (context) =>
                DashboardBloc(dashboardNetwork: DashboardNetwork()))
      ],
      child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "KaamWaliJobs",
          home: Splashscreen()),
    );
  }
}
