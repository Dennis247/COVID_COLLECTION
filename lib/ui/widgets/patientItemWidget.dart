import 'package:covid_collection/models/patient.dart';
import 'package:covid_collection/ui/pages/patientDetailsPage.dart';
import 'package:flutter/material.dart';

class PatientItemWidget extends StatelessWidget {
  final Patient patient;

  const PatientItemWidget({Key key, this.patient}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
          return PatientsDetail(
            patient: patient,
          );
        }));
      },
      child: ListTile(
        title: Text(patient.firstname),
        subtitle: Text(patient.gender),
        trailing: Text(patient.state),
      ),
    );
  }
}
