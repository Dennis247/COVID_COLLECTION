import 'package:covid_collection/helpers/constant.dart';
import 'package:covid_collection/providers/appProvider.dart';
import 'package:covid_collection/ui/pages/dataCapturePage.dart';
import 'package:covid_collection/ui/widgets/appDrawerWidget.dart';
import 'package:covid_collection/ui/widgets/patientItemWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PatientsPage extends StatelessWidget {
  static final routeName = "patients-page";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Patients List"),
      ),
      drawer: AppDrawerWidget(),
      body: FutureBuilder(
        future:
            Provider.of<AppProvider>(context, listen: false).getPatientData(),
        builder: (ctx, dataSnapShot) {
          if (dataSnapShot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (dataSnapShot.error != null) {
              return Center(
                child: Text("An Error has Occured"),
              );
            } else {
              return Consumer<AppProvider>(
                  builder: (ctx, appData, child) =>
                      appData.listedPatients.length > 0
                          ? ListView.builder(
                              itemBuilder: (BuildContext context, int index) {
                                return PatientItemWidget(
                                  patient: appData.listedPatients[index],
                                );
                              },
                              itemCount: appData.listedPatients.length,
                            )
                          : Center(
                              child: Text("Patient Data is currently Empty"),
                            ));
            }
          }
        },
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
