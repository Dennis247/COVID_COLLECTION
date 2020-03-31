import 'package:covid_collection/helpers/constant.dart';
import 'package:covid_collection/providers/appProvider.dart';
import 'package:covid_collection/ui/pages/dataCapturePage.dart';
import 'package:covid_collection/ui/widgets/appDrawerWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
      ),
      drawer: AppDrawerWidget(),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Constants.primaryColor,
        onPressed: () {
          Navigator.of(context).pushNamed(DataCapture.routeName);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
