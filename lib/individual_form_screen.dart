import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_individual_list_screen/individual_list_screen.dart';

import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'database_helper.dart';

import 'main.dart';

class IndividualFormScreen extends StatefulWidget {
  const IndividualFormScreen({Key? key}) : super(key: key);

  @override
  State<IndividualFormScreen> createState() => _IndividualFormScreenState();
}

class _IndividualFormScreenState extends State<IndividualFormScreen> {

  File? image;
  late String imagePath;

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if(image == null) return;

      final imageTemp = File(image.path);

      print('Gallery Image Path:');
      print(image.path);

      imagePath = image.path;

      setState(() => this.image = imageTemp);
    } on PlatformException catch(e) {
      print('Failed to pick image: $e');
    }
  }

  Future pickImageC() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);

      if(image == null) return;

      final imageTemp = File(image.path);

      print('Camera Image Path:');
      print(image.path);

      imagePath = image.path;

      setState(() => this.image = imageTemp);
    } on PlatformException catch(e) {
      print('Failed to pick image: $e');
    }
  }

  _uploadImageDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true, //true-out side click dissmisses
        builder: (param) {
          return AlertDialog(
            title: Text('Upload image'),
            content: SingleChildScrollView(
              child: Column(children: <Widget>[
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Color.fromRGBO(15, 53, 73, 1)),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                  ),
                  onPressed: () {
                    pickImage();
                    print('----------> uploaded from gallery');
                    Navigator.pop(context);
                  },
                  child: Text('Gallery'),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Color.fromRGBO(15, 53, 73, 1)),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                  ),
                  onPressed: () {
                    print('---------> Image: $image');
                    pickImageC();
                    Navigator.pop(context);
                    print('---------->uploaded from camera');
                  },
                  child: Text('Camera'),
                )
              ]),
            ),
          );
        });
  }

  var _firstLastNameController = TextEditingController(); //1
  var _middleNameController = TextEditingController(); //2
  var _businessNameController = TextEditingController(); //3
  var _businessStartDateController = TextEditingController(); //5
  var _natureofBusinessController = TextEditingController(); //6
  var _panNumberController = TextEditingController(); //7
  var _GSTinController = TextEditingController(); //8
  var _regOfficeAddressController = TextEditingController(); //9
  var _pincodeController = TextEditingController(); //10

  DateTime _dateTime = DateTime.now();

  _showDatePicker(BuildContext context) async{
    var _pickedDate = await showDatePicker(
        context: context,
        initialDate: _dateTime,
        firstDate: DateTime(2000),
        lastDate: DateTime(2050));

    if(_pickedDate != null){
      setState(() {
        _dateTime = _pickedDate;
        _businessStartDateController.text = DateFormat('dd-MM-yyyy').format(_pickedDate);
      });
    }
  }

   @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(15, 53, 73, 1),
        title: Text('Individual Form'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              image != null ?
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: ClipOval(
                  child: Image.file(
                    image!,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,),
                ),
              ):FlutterLogo(),
              SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 40,
                width: 125,
                child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Color.fromRGBO(15, 53, 73, 1)),
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                    ),
                    onPressed: () {
                      _uploadImageDialog(context);
                    },
                    child: Text('Add Photo')),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: SizedBox(
                  height: 50,
                  width: 370,
                  child: TextFormField(
                    controller: _firstLastNameController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(),
                        ),
                        labelText: 'First Name/Last Name'),
                  ),
                ),
              ), //1
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: SizedBox(
                  height: 50,
                  width: 370,
                  child: TextFormField(
                    controller: _middleNameController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(),
                        ),
                        labelText: 'Middle Name'),
                  ),
                ),
              ), //2
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: SizedBox(
                  height: 50,
                  width: 370,
                  child: TextFormField(
                    controller: _businessNameController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(),
                        ),
                        labelText: 'Business Name'),
                  ),
                ),
              ), //3
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: SizedBox(
                  height: 50,
                  width: 370,
                  child: TextFormField(
                    controller: _businessStartDateController,
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: 'Date',
                        hintText: 'Pick a Date',
                        prefixIcon: InkWell(
                          onTap: () {
                            _showDatePicker(context);
                          },
                          child: Icon(Icons.calendar_today),
                        )),
                  ),
                ),
              ), //5
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: SizedBox(
                  height: 50,
                  width: 370,
                  child: TextFormField(
                    controller: _natureofBusinessController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(),
                        ),
                        labelText: 'Nature of Business'),
                  ),
                ),
              ), //6
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: SizedBox(
                  height: 50,
                  width: 370,
                  child: TextFormField(
                    controller: _panNumberController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(),
                        ),
                        labelText: 'PAN Number'),
                  ),
                ),
              ), //7
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: SizedBox(
                  height: 50,
                  width: 370,
                  child: TextFormField(
                    controller: _GSTinController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(),
                        ),
                        labelText: 'GSTIN'),
                  ),
                ),
              ), //8
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: SizedBox(
                  height: 50,
                  width: 370,
                  child: TextFormField(
                    controller: _regOfficeAddressController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(),
                        ),
                        labelText: 'Registered Office Address'),
                  ),
                ),
              ), //9
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: SizedBox(
                  height: 50,
                  width: 370,
                  child: TextFormField(
                    controller: _pincodeController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(),
                        ),
                        labelText: 'Pincode'),
                  ),
                ),
              ), //

              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Color.fromRGBO(15, 53, 73, 1)),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                  ),
                  onPressed: () {
                    _save();
                  },
                  child: Text('Save'))
            ],
          ),
        ),
      ),
    );
  }

  void _save() async {
    print('------------> Image Path: $imagePath');
    print('---------------> FirstLastName: ${_firstLastNameController.text}');
    print('---------------> MiddleName: ${_middleNameController.text}');
    print('---------------> BusinessName: ${_businessNameController.text}');
    print('-----------> BusinessStartDate: ${_businessStartDateController.text}');
    print('---------------> NatureofBusiness: ${_natureofBusinessController.text}');
    print('---------------> PanNumber: ${_panNumberController.text}');
    print('---------------> GSTin: ${_GSTinController.text}');
    print('-------------> RegOfficeAddress: ${_regOfficeAddressController.text}');
    print('---------------> Pincode: ${_pincodeController.text}');

    Map<String, dynamic> row = {
      //DatabaseHelper.columnImage: 'images/person_sample.jpeg',
      DatabaseHelper.columnImage: imagePath,
      DatabaseHelper.columnFirstLastName: _firstLastNameController.text,
      DatabaseHelper.columnMiddleName: _middleNameController.text,
      DatabaseHelper.columnBusinessName: _businessNameController.text,
      DatabaseHelper.columnBusinessStartDate: _businessStartDateController.text,
      DatabaseHelper.columnNatureofBusiness: _natureofBusinessController.text,
      DatabaseHelper.columnPanNumber: _panNumberController.text,
      DatabaseHelper.columnGSTin: _GSTinController.text,
      DatabaseHelper.columnRegOfficeAddress: _regOfficeAddressController.text,
      DatabaseHelper.columnPincode: _pincodeController.text,
    };

    final result = await dbHelper.insert(row, DatabaseHelper.individualsTable);

    debugPrint('--------> inserted row id: $result');

    if (result > 0) {
      Navigator.pop(context);
      _showSuccessSnackBar(context, 'Saved');
    }
    setState(() {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => IndividualListScreen()));
    });
  }

  void _showSuccessSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(new SnackBar(content: new Text(message)));
  }
}
