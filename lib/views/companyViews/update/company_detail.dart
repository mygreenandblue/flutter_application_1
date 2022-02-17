// ignore_for_file: unnecessary_string_interpolations, duplicate_ignore, unused_element, prefer_const_constructors
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/company_model.dart';
import 'package:flutter_application_1/views/companyViews/companylist_Screen.dart';
import 'package:flutter_application_1/data_sources/company_services.dart';

class CompanyDetailsScreen extends StatefulWidget {
  final Company? company;

  CompanyDetailsScreen({this.company});
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
    final todo = ModalRoute.of(context)!.settings.arguments as Company;
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
                        controller: _descriptionController,
                        onSaved: (value) {
                          widget.company?.ResultId = value as int?;
                        },
                        decoration: InputDecoration(
                          icon: Icon(Icons.directions_car),
                          hintText: 'Enter id',
                          labelText: todo.ResultId.toString(),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      TextFormField(
                        onSaved: (value) {
                          widget.company?.ClassA = value;
                        },
                        controller: _idController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter class';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          icon: Icon(Icons.directions_car_outlined),
                          hintText: 'Enter class',
                          labelText: todo.ClassA.toString(),
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
                        controller: _classController,
                        onSaved: (value) {
                          widget.company?.DescriptionA = value;
                        },
                        decoration: InputDecoration(
                          icon: Icon(Icons.calendar_today),
                          hintText: 'Enter some text',
                          labelText: todo.DescriptionA.toString(),
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
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
////The method bellow updateList ()needs to be changed in order to modify the existing list, this method just creates a new one.
                        // await updateList(Company(
                        //   friendlyName: friendlyName.toString(),
                        //   color: color.toString(),
                        //   licencePlate: licencePlate.toString(),
                        // ));
                        await homeservices.updateCompany(Company(
                            ResultId: todo.ResultId,
                            DescriptionA: todo.ClassA,
                            ClassA: todo.DescriptionA));

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
