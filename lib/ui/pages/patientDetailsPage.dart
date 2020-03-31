import 'package:covid_collection/models/patient.dart';
import 'package:flutter/material.dart';

class PatientsDetail extends StatelessWidget {
  final Patient patient;

  const PatientsDetail({Key key, this.patient}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Patient Details"),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Text("First Name"),
              subtitle: Text(patient.firstname),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
