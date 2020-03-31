import 'package:covid_collection/helpers/constant.dart';
import 'package:covid_collection/helpers/custom_route.dart';
import 'package:covid_collection/providers/appProvider.dart';
import 'package:covid_collection/ui/pages/dataCapturePage.dart';
import 'package:covid_collection/ui/pages/homePage.dart';
import 'package:covid_collection/ui/pages/patientsPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: AppProvider()),
        ],
        child: MaterialApp(
          title: 'COVID COLLECTION DATA',
          theme: ThemeData(
              primaryColor: Constants.primaryColor,
              pageTransitionsTheme: PageTransitionsTheme(builders: {
                TargetPlatform.iOS: CustomPageTransitionBuilder(),
                TargetPlatform.android: CustomPageTransitionBuilder(),
              })),
          home: HomePage(),
          debugShowCheckedModeBanner: false,
          routes: {
            PatientsPage.routeName: (context) => PatientsPage(),
            DataCapture.routeName: (context) => DataCapture()
          },
        ));
  }
}
