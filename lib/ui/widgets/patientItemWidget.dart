import 'package:covid_collection/models/patient.dart';
import 'package:flutter/material.dart';

class PatientItemWidget extends StatelessWidget {
  final Patient patient;

  const PatientItemWidget({Key key, this.patient}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: ListTile(
        title: Text(patient.firstname),
        subtitle: Text(patient.gender),
        trailing: Text(patient.city),
      ),
    );
  }
}
