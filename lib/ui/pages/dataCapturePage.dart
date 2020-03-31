import 'package:covid_collection/helpers/constant.dart';
import 'package:covid_collection/models/patient.dart';
import 'package:covid_collection/models/state.dart';
import 'package:covid_collection/providers/appProvider.dart';
import 'package:covid_collection/ui/pages/patientsPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

class DataCapture extends StatefulWidget {
  static final String routeName = "data-capture";
  @override
  _DataCaptureState createState() => _DataCaptureState();
}

class _DataCaptureState extends State<DataCapture> {
  Location location;
  LocationData currentLocation;
  bool _isLoading = false;
  List<NigeriaState> _nigeriaStates = [];
  List _genderList = ["MALE", "FEMALE"];
  String _selectedGender;
  String _latitude;
  String _longitude;

  final _fromKey = GlobalKey<FormState>();
  final FocusNode _cityFocusNode = FocusNode();
  final FocusNode _firstnameFocusNode = FocusNode();
  final FocusNode _lastnameFocusNode = FocusNode();
  final FocusNode _streetFocusNode = FocusNode();
  final FocusNode _stateFocusNode = FocusNode();

  final TextEditingController _firstNameController =
      new TextEditingController();
  final TextEditingController _lastNameController = new TextEditingController();
  final TextEditingController _cityController = new TextEditingController();
  final TextEditingController _streetController = new TextEditingController();
  final TextEditingController _stateController = new TextEditingController();

  @override
  void initState() {
    _selectedGender = _genderList[0];
    _isLoading = true;
    getRequiredData().whenComplete(() {
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _cityFocusNode.dispose();
    _firstnameFocusNode.dispose();
    _lastnameFocusNode.dispose();
    _streetFocusNode.dispose();
    _stateFocusNode.dispose();

    super.dispose();
  }

  Future<void> getRequiredData() async {
    await Provider.of<AppProvider>(context, listen: false).getStateData();
    location = new Location();
    currentLocation = await location.getLocation();
    _latitude = currentLocation.latitude.toString();
    _longitude = currentLocation.longitude.toString();
  }

  Future<void> _submitData() async {
    if (!_fromKey.currentState.validate()) {
      return;
    }
    _fromKey.currentState.save();
    setState(() {
      _isLoading = true;
    });

    try {
      final patientData = Patient(
          city: _cityController.text,
          firstname: _firstNameController.text,
          gender: _selectedGender,
          lastname: _lastNameController.text,
          lat: _latitude,
          lng: _longitude,
          state: _stateController.text,
          street: _streetController.text);
      final response = await Provider.of<AppProvider>(context, listen: false)
          .submitPatinetData(patientData);
      Navigator.of(context).pushReplacementNamed("/");

      if (!response) {
        _showFialureDialogue("Data SUbmission Failed", context);
      }
    } catch (error) {
      _showFialureDialogue(error.toString(), context);
    }
    setState(() {
      _isLoading = false;
    });
  }

  _showFialureDialogue(String message, BuildContext context) async {
    await showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text("Something went wrong"),
            content: Text(message),
            actions: <Widget>[
              FlatButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  Row buildGenderRadioButton(int btnValue, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio(
          activeColor: Constants.primaryColor,
          value: _genderList[btnValue],
          groupValue: _selectedGender,
          onChanged: (value) {
            setState(() {
              _selectedGender = value;
            });
          },
        ),
        Text(title)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("ADD  DATA"),
          centerTitle: true,
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.all(15.0),
                child: Form(
                  key: _fromKey,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Form(
                      child: ListView(
                        children: <Widget>[
                          TextFormField(
                            controller: _firstNameController,
                            focusNode: _firstnameFocusNode,
                            onSaved: (_) {
                              FocusScope.of(context)
                                  .requestFocus(_lastnameFocusNode);
                            },
                            validator: (value) {
                              if (value.isNotEmpty) {
                                return "First name cannot be empty";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                suffixIcon: IconButton(
                                    icon: Icon(
                                      Icons.close,
                                      color: Colors.grey,
                                      size: 15,
                                    ),
                                    onPressed: () {
                                      WidgetsBinding.instance
                                          .addPostFrameCallback((_) =>
                                              _firstNameController.clear());
                                    }),
                                labelText: "First Name"),
                          ),
                          TextFormField(
                            controller: _lastNameController,
                            focusNode: _lastnameFocusNode,
                            validator: (value) {
                              if (value.isNotEmpty) {
                                return "Last name cannot be empty";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                suffixIcon: IconButton(
                                    icon: Icon(
                                      Icons.close,
                                      color: Colors.grey,
                                      size: 15,
                                    ),
                                    onPressed: () {
                                      _lastNameController.clear();
                                    }),
                                labelText: "Last Name"),
                          ),
                          TextFormField(
                            controller: _cityController,
                            focusNode: _cityFocusNode,
                            onSaved: (_) {
                              FocusScope.of(context)
                                  .requestFocus(_streetFocusNode);
                            },
                            validator: (value) {
                              if (value.isNotEmpty) {
                                return "City cannot be empty";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                suffixIcon: IconButton(
                                    icon: Icon(
                                      Icons.close,
                                      color: Colors.grey,
                                      size: 15,
                                    ),
                                    onPressed: () {}),
                                labelText: "City"),
                          ),
                          TextFormField(
                            controller: _streetController,
                            focusNode: _streetFocusNode,
                            onSaved: (_) {
                              FocusScope.of(context)
                                  .requestFocus(_stateFocusNode);
                            },
                            validator: (value) {
                              if (value.isNotEmpty) {
                                return "Street cannot be empty";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                suffixIcon: IconButton(
                                    icon: Icon(
                                      Icons.close,
                                      color: Colors.grey,
                                      size: 15,
                                    ),
                                    onPressed: () {
                                      WidgetsBinding.instance
                                          .addPostFrameCallback(
                                              (_) => _streetController.clear());
                                    }),
                                labelText: "Street"),
                          ),
                          TypeAheadFormField(
                            direction: AxisDirection.up,
                            debounceDuration: Duration(milliseconds: 500),
                            textFieldConfiguration: TextFieldConfiguration(
                              controller: _stateController,
                              focusNode: _stateFocusNode,
                              style: TextStyle(fontSize: 12),
                              decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                      icon: Icon(
                                        Icons.close,
                                        color: Colors.grey,
                                        size: 15,
                                      ),
                                      onPressed: () {
                                        _stateController.clear();
                                      }),
                                  labelText: "State"),
                            ),
                            validator: (value) {
                              if (value.isNotEmpty) {
                                return "State name cannot be empty";
                              }
                              return null;
                            },
                            suggestionsCallback: (pattern) {
                              return Provider.of<AppProvider>(context,
                                      listen: false)
                                  .getStateSuggestions(pattern);
                            },
                            itemBuilder: (context, NigeriaState suggetion) {
                              return ListTile(
                                title: Text(
                                  suggetion.name,
                                  style: TextStyle(fontSize: 12),
                                ),
                                subtitle: Text(suggetion.id.toString()),
                              );
                            },
                            onSuggestionSelected:
                                (NigeriaState suggetion) async {
                              _stateController.text = suggetion.name;
                            },
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("Gender"),
                              buildGenderRadioButton(0, _genderList[0]),
                              buildGenderRadioButton(1, _genderList[1]),
                            ],
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 25, right: 25),
                            child: MaterialButton(
                              color: Constants.primaryColor,
                              onPressed: _submitData,
                              child: Text(
                                "SUBMIT",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
