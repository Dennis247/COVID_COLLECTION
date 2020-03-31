import 'package:covid_collection/helpers/constant.dart';
import 'package:covid_collection/models/state.dart';
import 'package:covid_collection/providers/appProvider.dart';
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

    super.dispose();
  }

  Future<void> getRequiredData() async {
    await Provider.of<AppProvider>(context, listen: false).getStateData();
    location = new Location();
    currentLocation = await location.getLocation();
    _latitude = currentLocation.latitude.toString();
    _longitude = currentLocation.longitude.toString();
  }

  Future<void> _submitData() {}

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
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.pop(context),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.save),
              onPressed: () {},
            ),
          ],
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
                                      _firstNameController.clear();
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
                                    onPressed: () {}),
                                labelText: "Street"),
                          ),
                          TypeAheadFormField(
                            direction: AxisDirection.up,
                            debounceDuration: Duration(milliseconds: 500),
                            textFieldConfiguration: TextFieldConfiguration(
                              controller: _stateController,
                              autofocus: true,
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
                            height: 15,
                          ),
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
