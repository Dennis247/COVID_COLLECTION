import 'dart:convert';

import 'package:covid_collection/helpers/constant.dart';
import 'package:covid_collection/models/patient.dart';
import 'package:covid_collection/models/state.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AppProvider with ChangeNotifier {
  List<Patient> _listedPatients = [];

  List<Patient> get listedPatients {
    return [..._listedPatients];
  }

  List<NigeriaState> _states = [];
  List<NigeriaState> get states {
    return [...states];
  }

  Future<bool> getStateData() async {
    try {
      final responseData = await http.get(Constants.nigeriaStates);
      if (responseData.statusCode == 200) {
        Iterable extractedPatinetList = json.decode(responseData.body);
        if (extractedPatinetList != null) {
          _states = NigeriaState.stateListFromJson(extractedPatinetList);
          notifyListeners();
          return true;
        }
      }
      return false;
    } catch (e) {
      print(e.toString());
    }
  }

  List<NigeriaState> getStateSuggestions(String state) {
    final autoList = _states.reversed.toList();
    if (state.isNotEmpty) {
      state = state.trim().toLowerCase();
      final suggestedState = autoList
          .where((element) => element.name.toLowerCase().contains(state))
          .toList();

      return suggestedState;
    }
  }

  Future<void> getPatientData() async {
    try {
      final responseData = await http.get(Constants.patientListingApi);
      if (responseData.statusCode == 200) {
        final Iterable extractedPatinetList =
            json.decode(responseData.body)['content'];
        if (extractedPatinetList != null) {
          _listedPatients = Patient.patientsListFromJson(extractedPatinetList);
          notifyListeners();
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<bool> submitPatinetData(Patient patinet) async {
    try {
      final responseData = await http.post(Constants.patientSubmissionApi,
          headers: {'Content-Type': 'application/json'},
          body: json.encode({
            'city': patinet.city,
            'firstname': patinet.firstname,
            'gender': patinet.gender,
            'lastname': patinet.lastname,
            'lat': patinet.lat,
            'lng': patinet.lng,
            'state': patinet.state,
            'street': patinet.street,
          }));
      if (responseData.statusCode == 201) {
        print("patinet data submitted sucessfully");
        _listedPatients.add(patinet);
        return true;
      }
      print("patinet submission failed");
      return false;
    } catch (e) {
      print(e.toString());
    }
  }
}
