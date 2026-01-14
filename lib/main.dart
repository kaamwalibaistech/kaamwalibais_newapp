import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kaamwalijobs_new/bloc/homepage_bloc.dart';
import 'package:kaamwalijobs_new/core/local_storage.dart';
import 'package:kaamwalijobs_new/features/auth/bloc/auth_bloc.dart';
import 'package:kaamwalijobs_new/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:kaamwalijobs_new/features/dashboard/network/dashboard_network.dart';
import 'package:kaamwalijobs_new/features/jobs/bloc/job_bloc.dart';
import 'package:kaamwalijobs_new/features/navigation/bloc/packages_bloc.dart';
import 'package:kaamwalijobs_new/features/notification_service.dart';
import 'package:kaamwalijobs_new/features/onboarding/presantation/splashscreen.dart';
import 'package:kaamwalijobs_new/firebase_options.dart';

import 'bloc/packages_bloc.dart';
import 'features/dashboard/presentation/location/bloc/select_location_bloc.dart';
import 'features/jobs/network/job_repository.dart';
import 'features/navigation/bloc/search_candidate_bloc.dart';

// final updater = ShorebirdUpdater();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
 

 await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseMessaging.instance.requestPermission(
  alert: true,
  badge: true,
  sound: true,
);


  // await NotificationService.init();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Title: ${message.notification?.title}');
    print('Body: ${message.notification?.body}');
  });



  await LocalStoragePref.instance?.initPrefBox();
  await dotenv.load(fileName: ".env");
 

  runApp(MyApp());

  configLoading();
}
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Background message: ${message.messageId}");
}



void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.light
    ..maskType = EasyLoadingMaskType.black
    ..dismissOnTap = false;
}

// Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
// }

class MyApp extends StatefulWidget {
  const MyApp({super.key});

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
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "KaamWaliJobs",
          home: Splashscreen(),
          builder: EasyLoading.init(),
        ),
      ),
    );
  }
}
