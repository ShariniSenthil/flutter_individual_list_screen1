import 'package:flutter/material.dart';
import 'package:flutter_individual_list_screen/database_helper.dart';
import 'package:flutter_individual_list_screen/edit_individual_form_screen.dart';
import 'package:flutter_individual_list_screen/individual.dart';
import 'package:flutter_individual_list_screen/individual_form_screen.dart';
import 'package:flutter_individual_list_screen/main.dart';


class IndividualListScreen extends StatefulWidget {
  const IndividualListScreen({Key? key}) : super(key: key);

  @override
  State<IndividualListScreen> createState() => _IndividualListScreenState();
}

class _IndividualListScreenState extends State<IndividualListScreen> {
  late List<Individual> _IndividualList;

  @override
  void initState() {
    super.initState();
    getAllIndividuals();
  }

  getAllIndividuals() async {
    _IndividualList = <Individual>[];

    var individuals =
    await dbHelper.queryAllRows(DatabaseHelper.individualsTable);

    individuals.forEach((individual) {
      setState(() {
        print(individual['_id']);
        print(individual['_image']);
        print(individual['_firstLastName']);
        print(individual['_middleName']);
        print(individual['_businessName']);
        print(individual['_businessStartDate']);
        print(individual['_natureofBusiness']);
        print(individual['_panNumber']);
        print(individual['_GSTin']);
        print(individual['_regOfficeAddress']);
        print(individual['_pincode']);

        var individualModel = Individual(
          individual['_id'],
          individual['_image'],
          individual['_firstLastName'],
          individual['_middleName'],
          individual['_businessName'],
          individual['_businessStartDate'],
          individual['_natureofBusiness'],
          individual['_panNumber'],
          individual['_GSTin'],
          individual['_regOfficeAddress'],
          individual['_pincode'],
        );

        _IndividualList.add(individualModel);
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(15, 53, 73, 1),
        title: Text(
          'Individual list screen',
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: _IndividualList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0)),
                child: ListTile(
                  onTap: () {
                    print('---------->Edit or Delete invoked: Send Data');
                    print(_IndividualList[index].id);
                    print(_IndividualList[index].id);
                    print(_IndividualList[index].image);
                    print(_IndividualList[index].firstLastName);
                    print(_IndividualList[index].middleName);
                    print(_IndividualList[index].businessName);
                    print(_IndividualList[index].businessStartDate);
                    print(_IndividualList[index].natureofBusiness);
                    print(_IndividualList[index].panNumber);
                    print(_IndividualList[index].GSTin);
                    print(_IndividualList[index].regOfficeAddress);
                    print(_IndividualList[index].pincode);

                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => EditIndividualFormScreen(),
                      settings: RouteSettings(
                        arguments: _IndividualList[index],
                      ),
                    ));
                  },
                   title:Text(_IndividualList[index].businessName ?? 'No Data'),
                  ),
                ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromRGBO(15, 53, 73, 1),
        onPressed: () {
          print('---------->add invoked');
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => IndividualFormScreen()));
        },
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}
