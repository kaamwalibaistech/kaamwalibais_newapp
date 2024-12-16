import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kaamwalijobs_new/bloc/homepage_bloc.dart';
import 'package:kaamwalijobs_new/features/auth/splashscreen.dart';
import 'package:kaamwalijobs_new/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:kaamwalijobs_new/features/dashboard/network/dashboard_network.dart';

import 'core/local_storage.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LocalStoragePref.instance?.initPrefBox();
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
