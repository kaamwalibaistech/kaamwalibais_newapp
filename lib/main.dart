import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kaamwalijobs_new/bloc/homepage_bloc.dart';
import 'package:kaamwalijobs_new/core/local_storage.dart';
import 'package:kaamwalijobs_new/features/auth/bloc/auth_bloc.dart';
import 'package:kaamwalijobs_new/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:kaamwalijobs_new/features/dashboard/network/dashboard_network.dart';
import 'package:kaamwalijobs_new/features/jobs/bloc/job_bloc.dart';
import 'package:kaamwalijobs_new/features/navigation/bloc/packages_bloc.dart';
import 'package:kaamwalijobs_new/features/onboarding/presantation/splashscreen.dart';

import 'bloc/packages_bloc.dart';
import 'features/dashboard/presentation/location/bloc/select_location_bloc.dart';
import 'features/jobs/network/job_repository.dart';
import 'features/navigation/bloc/search_candidate_bloc.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStoragePref.instance?.initPrefBox();
  // final pres = await SharedPreferences.getInstance();
  // final onboarding = pres.getBool("onboarrding") ?? false;

  await dotenv.load(fileName: ".env");
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({
    super.key,
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomepageBloc>(create: (context) => HomepageBloc()),
        BlocProvider<AuthBloc>(create: (context) => AuthBloc()),
        BlocProvider<DashboardBloc>(
            create: (context) =>
                DashboardBloc(dashboardNetwork: DashboardNetwork())),
        BlocProvider<JobBloc>(create: (context) => JobBloc(JobRepository())),
        BlocProvider<PackagesBloc>(create: (context) => PackagesBloc()),
        BlocProvider<SelectLocationBloc>(
            create: (context) => SelectLocationBloc()),
        BlocProvider<SearchCandidateBloc>(
            create: (context) => SearchCandidateBloc()),
        BlocProvider<PurchasedPackageDataBloc>(
            create: (context) => PurchasedPackageDataBloc()),
        // BlocProvider<ApplicantsBloc>(create: (context) => ApplicantsBloc())
      ],
      child: ScreenUtilInit(
        designSize: Size(375, 812),
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: "KaamWaliJobs",
            home: Splashscreen()),
      ),
    );
  }
}
