import 'package:covid_collection/models/patient.dart';
import 'package:covid_collection/ui/pages/patientsPage.dart';
import 'package:flutter/material.dart';

class AppDrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text("COVID COLLECTION"),
            automaticallyImplyLeading: false,
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushNamed("/");
            },
            leading: Icon(
              Icons.home,
              color: Colors.blue,
            ),
            title: Text("Home"),
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.local_hospital,
              color: Colors.green,
            ),
            title: Text("Patients"),
            onTap: () {
              Navigator.of(context).pushNamed(PatientsPage.routeName);
            },
          )
        ],
      ),
    );
  }
}
