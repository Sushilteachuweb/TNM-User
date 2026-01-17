import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:naukri_mitra_jobs/Screens/splash/Splash.dart';
import 'package:naukri_mitra_jobs/providers/AppliedJobsProvider.dart';
import 'package:naukri_mitra_jobs/providers/Auth_Provider.dart';
import 'package:naukri_mitra_jobs/providers/CreateProfileProvider.dart';
import 'package:naukri_mitra_jobs/providers/JobProvider.dart';
import 'package:naukri_mitra_jobs/providers/ProfileProvider.dart';
import 'package:naukri_mitra_jobs/providers/LocationProvider.dart';
import 'package:naukri_mitra_jobs/providers/LocalizationProvider.dart';
import 'generated/l10n/app_localizations.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Set system UI overlay style for status bar
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
  );
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LocalizationProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => JobProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => CreateProfileProvider()),
        ChangeNotifierProvider(create: (_) => AppliedJobsProvider()),
        ChangeNotifierProvider(create: (_) => LocationProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return Consumer<LocalizationProvider>(
      builder: (context, localizationProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          locale: localizationProvider.locale,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en'), // English
            Locale('hi'), // Hindi
            Locale('pa'), // Punjabi
            Locale('gu'), // Gujarati
            Locale('mr'), // Marathi
          ],
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.white,
              elevation: 0,
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                statusBarIconBrightness: Brightness.dark,
                statusBarBrightness: Brightness.light,
              ),
              iconTheme: IconThemeData(color: Colors.black87),
              titleTextStyle: TextStyle(
                color: Colors.black87,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          home: const Splash(),
        );
      },
    );
  }
}





// correct 10-09-2025
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:naukri_mitra_jobs/SplashScreen/Splash.dart';
// import 'package:naukri_mitra_jobs/provider/AppliedJobsProvider.dart';
// import 'package:naukri_mitra_jobs/provider/Auth_Provider.dart';
// import 'package:naukri_mitra_jobs/provider/CreateProfileProvider.dart';
// import 'package:naukri_mitra_jobs/provider/JobProvider.dart';
// import 'package:naukri_mitra_jobs/provider/ProfileProvider.dart';
// import 'package:naukri_mitra_jobs/provider/create_provider.dart' hide ProfileProvider;
// import 'screens/login.dart';
//
// void main() {
//   runApp(
//     MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => AuthProvider()),
//         ChangeNotifierProvider(create: (_) => CreateProvider()),
//         ChangeNotifierProvider(create: (_) => JobProvider()),
//         ChangeNotifierProvider(create: (_) => ProfileProvider()),
//         ChangeNotifierProvider(create: (_) => CreateProfileProvider()),
//         ChangeNotifierProvider(create: (_) => AppliedJobsProvider ()),
//
//       ],
//       child: const MyApp(),
//     ),
//   );
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//       ),
//       home: const Splash(),
//     );
//   }
// }
//
//







// import 'package:flutter/material.dart';
// import 'package:naukri_mitra_jobs/SplashScreen/Splash.dart';
//
// void main() {
//   runApp(const MyApp());
// }
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//       ),
//       home: const Splash(),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'providers/product_provider.dart';
// import 'screens/product_screen.dart';
//
// void main() {
//   runApp(
//     MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => ProductProvider()),
//       ],
//       child: const MyApp(),
//     ),
//   );
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: const ProductScreen(),
//     );
//   }
// }
