// ignore_for_file: unnecessary_string_interpolations, duplicate_ignore, unused_element, prefer_const_constructors
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/company_model.dart';
import 'package:flutter_application_1/views/companyViews/companylist_Screen.dart';
import 'package:flutter_application_1/data_sources/company_services.dart';

class CompanyDetailsScreen extends StatefulWidget {
  final Company? company;

  const CompanyDetailsScreen({Key? key, this.company}) : super(key: key);
  @override
  _VehicleDetailsScreenState createState() => _VehicleDetailsScreenState();
}

class _VehicleDetailsScreenState extends State<CompanyDetailsScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _classController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    if (widget.company != null) {
      _idController.text = widget.company!.ResultId.toString();

      _classController.text = widget.company!.ClassA.toString();

      _descriptionController.text = widget.company!.DescriptionA.toString();
    }
    super.initState();
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _idController.dispose();
    _classController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final homeservices = CompanyService();

    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: Container(
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Company Details',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30.0,
                  color: Colors.grey,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height - 400,
                child: Form(
                  key: _formKey,
                  child: ListView(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    children: <Widget>[
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter id';
                          }
                          return null;
                        },
                        controller: _idController,
                        onSaved: (value) {
                          int ID = int.parse(value.toString());
                          widget.company!.ResultId = ID;
                        },
                        decoration: InputDecoration(
                          hintText: 'Enter id',
                          labelText: "Id",
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      TextFormField(
                        onSaved: (value) {
                          widget.company?.ClassA = value;
                        },
                        controller: _classController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter class';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'Enter class',
                          labelText: "Class",
                        ),
                        keyboardType: TextInputType.text,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        controller: _descriptionController,
                        onSaved: (value) {
                          widget.company?.DescriptionA = value;
                        },
                        decoration: InputDecoration(
                          hintText: 'Enter some text',
                          labelText: "Description",
                        ),
                        keyboardType: TextInputType.text,
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FlatButton(
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    color: Colors.grey,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  FlatButton(
                    child: Text(
                      'Edit',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    color: Colors.pink,
                    onPressed: () async {
                      int ResultID = int.parse(_idController.text.toString());
                      String ClassA = _classController.text.toString();
                      String DescriptionA =
                          _descriptionController.text.toString();
                      Company company = Company(
                          ResultId: ResultID,
                          ClassA: ClassA,
                          DescriptionA: DescriptionA);
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        await homeservices.updateCompany(company);

                        Navigator.of(context).pop();
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
