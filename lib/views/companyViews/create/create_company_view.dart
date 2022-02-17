import 'package:flutter/material.dart';
import 'package:flutter_application_1/data_sources/company_services.dart';
import 'package:flutter_application_1/models/company_model.dart';

final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class AddCompanyScreen extends StatefulWidget {
  final Company? company;

  const AddCompanyScreen({Key? key, this.company}) : super(key: key);

  @override
  _FormAddScreenState createState() => _FormAddScreenState();
}

class _FormAddScreenState extends State<AddCompanyScreen> {
  bool _isLoading = false;
  CompanyService _companyService = CompanyService();
  bool? _isFieldResultId;
  bool? _isFieldClassA;
  bool? _isFieldDescreptionA;
  TextEditingController _controllerResultId = TextEditingController();
  TextEditingController _controllerClassA = TextEditingController();
  TextEditingController _controllerDescreptionA = TextEditingController();

  @override
  void initState() {
    if (widget.company != null) {
      _isFieldResultId = true;
      _controllerResultId.text = widget.company!.ResultId.toString();
      _isFieldClassA = true;
      _controllerClassA.text = widget.company!.ClassA.toString();
      _isFieldDescreptionA = true;
      _controllerDescreptionA.text = widget.company!.DescriptionA.toString();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          widget.company == null ? "Form Add" : "Change Data",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _buildTextFieldName(),
                _buildTextFieldEmail(),
                _buildTextFieldAge(),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: RaisedButton(
                    child: Text(
                      widget.company == null
                          ? "Submit".toUpperCase()
                          : "Update Data".toUpperCase(),
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      if (_isFieldResultId == null ||
                          _isFieldClassA == null ||
                          _isFieldDescreptionA == null ||
                          !_isFieldResultId! ||
                          !_isFieldClassA! ||
                          !_isFieldDescreptionA!) {
                        _scaffoldState.currentState!.showSnackBar(
                          SnackBar(
                            content: Text("Please fill all field"),
                          ),
                        );
                        return;
                      }
                      setState(() => _isLoading = true);
                      int resultID =
                          int.parse(_controllerResultId.text.toString());
                      String classA = _controllerClassA.text.toString();
                      String descreptionA =
                          _controllerDescreptionA.text.toString();
                      Company company = Company(
                          ResultId: resultID,
                          ClassA: classA,
                          DescriptionA: descreptionA);
                      if (widget.company == null) {
                        _companyService
                            .createCompany(company)
                            .then((isSuccess) {
                          setState(() => _isLoading = false);
                          if (isSuccess) {
                            Navigator.pop(
                                _scaffoldState.currentState!.context, true);
                          } else {
                            _scaffoldState.currentState!.showSnackBar(SnackBar(
                              content: Text("Submit data failed"),
                            ));
                          }
                        });
                      } else {
                        company.ResultId = widget.company!.ResultId;
                        _companyService
                            .updateCompany(company)
                            .then((isSuccess) {
                          setState(() => _isLoading = false);
                          if (isSuccess) {
                            Navigator.pop(
                                _scaffoldState.currentState!.context, true);
                          } else {
                            _scaffoldState.currentState!.showSnackBar(SnackBar(
                              content: Text("Update data failed"),
                            ));
                          }
                        });
                      }
                    },
                    color: Colors.orange[600],
                  ),
                )
              ],
            ),
          ),
          _isLoading
              ? Stack(
                  children: <Widget>[
                    Opacity(
                      opacity: 0.3,
                      child: ModalBarrier(
                        dismissible: false,
                        color: Colors.grey,
                      ),
                    ),
                    Center(
                      child: CircularProgressIndicator(),
                    ),
                  ],
                )
              : Container(),
        ],
      ),
    );
  }

  Widget _buildTextFieldName() {
    return TextField(
      controller: _controllerResultId,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "ResultID",
        errorText: _isFieldResultId == null || _isFieldResultId!
            ? null
            : "ResultID is required",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldResultId) {
          setState(() => _isFieldResultId = isFieldValid);
        }
      },
    );
  }

  Widget _buildTextFieldEmail() {
    return TextField(
      controller: _controllerClassA,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: "ClassA",
        errorText: _isFieldClassA == null || _isFieldClassA!
            ? null
            : "ClassA is required",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldClassA) {
          setState(() => _isFieldClassA = isFieldValid);
        }
      },
    );
  }

  Widget _buildTextFieldAge() {
    return TextField(
      controller: _controllerDescreptionA,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: "Descreption",
        errorText: _isFieldDescreptionA == null || _isFieldDescreptionA!
            ? null
            : "Descreption is required",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldDescreptionA) {
          setState(() => _isFieldDescreptionA = isFieldValid);
        }
      },
    );
  }
}
