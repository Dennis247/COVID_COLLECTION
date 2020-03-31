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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            children: <Widget>[
              ListTile(
                title: Text(
                  "First Name",
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
                subtitle: Text(
                  patient.firstname,
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
              ),
              Divider(),
              ListTile(
                title: Text(
                  "Last Name",
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
                subtitle: Text(
                  patient.lastname,
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
              ),
              Divider(),
              ListTile(
                title: Text(
                  "Gender",
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
                subtitle: Text(
                  patient.gender,
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
              ),
              Divider(),
              ListTile(
                title: Text(
                  "City",
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
                subtitle: Text(
                  patient.city,
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
              ),
              Divider(),
              ListTile(
                title: Text(
                  "Street",
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
                subtitle: Text(
                  patient.street,
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
              ),
              Divider(),
              ListTile(
                title: Text(
                  "State",
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
                subtitle: Text(
                  patient.state,
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
              ),
              Divider(),
              ListTile(
                title: Text(
                  "Location",
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
                subtitle: Text(
                  "Latitude : ${patient.lat}\nLongitude : ${patient.lng}",
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
              ),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
