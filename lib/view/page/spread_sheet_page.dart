import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timesheet_flutter_app/controller/google_controller.dart';
import 'package:timesheet_flutter_app/controller/user_controller.dart';
import 'package:timesheet_flutter_app/model/local_data_source.dart';
import 'package:timesheet_flutter_app/model/spreadsheet_dto.dart';
import 'package:timesheet_flutter_app/view/page/main_page.dart';
import 'package:timesheet_flutter_app/view/page/sheet_page.dart';
import 'login_page.dart';

import 'package:flutter/material.dart';

class SpreadsheetPage extends StatefulWidget {
  SpreadsheetPage({Key? key}) : super(key: key);

  @override
  State<SpreadsheetPage> createState() => _SpreadsheetPageState();
}

class _SpreadsheetPageState extends State<SpreadsheetPage> {
  final UserController userController = UserController();

  List<SpreadSheetDTO> spreadSheetDTOs = <SpreadSheetDTO>[];

  // Method to Submit Feedback and save it in Google Sheets

  @override
  void initState() {
    super.initState();
    User? user = userController.getUserData();

    GoogleController().getSpreadSheetList().then((spreadSheetDTOs) {
      setState(() {
        this.spreadSheetDTOs = spreadSheetDTOs;
        print(spreadSheetDTOs);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    User? user = userController.getUserData();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Spread Sheets"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                userController.signOutFromGoogle(error: (String error) {
                  Get.snackbar("Error", error);
                }, action: () {
                  Get.offAll(LoginPage());
                });
              },
              icon: const Icon(Icons.logout)),
        ],
      ),
      floatingActionButton: Stack(
        children: <Widget>[
          Positioned(
            right: 15,
            bottom: 90,
            child: FloatingActionButton(
              heroTag: 'add task',
              onPressed: () {
                Get.offAll(AddSpreadsheet());
              },
              child: Icon(Icons.task_alt),
            ),
          ),
          Positioned(
            right: 15,
            bottom: 15,
            child: FloatingActionButton(
              heroTag: 'start',
              onPressed: () async {
              },
              child: Icon(Icons.play_arrow_rounded),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: spreadSheetDTOs.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () async {
              print(spreadSheetDTOs[index].toJson().toString());

              Map<String, String> sheetId = {
                "workSpaceId": spreadSheetDTOs[index].workSpaceId
              };

              SpreadSheetDTO spreadSheetDTO =
                  await GoogleController().getSpreadSheetDetails(sheetId);
              
              print(spreadSheetDTO);

              Map<String, String> googleSheetParam = {
                "q": "taskList",
                "spreadsheetId": spreadSheetDTO.spreadSheetId.toString(),
                "sheetName": spreadSheetDTO.sheets!.last.sheetTitle.toString()
              };

              print(userController.getUserData());

              LocalDataSource lds = new LocalDataSource();
              final String? accessToken = await lds.getToken();

              print(accessToken);

              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return SheetPage(googleSheetParam);
              }));
            },
            title: Row(
              children: <Widget>[
                // Icon(Icons.date_range),
                Expanded(
                  child: Text("${spreadSheetDTOs[index].workSpaceTitle}"),
                )
              ],
            ),
            subtitle: Row(
              children: <Widget>[
                Expanded(
                  child: Text(spreadSheetDTOs[index].workSpaceId),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class AddSpreadsheet extends StatefulWidget {
  @override
  _AddSpreadsheetState createState() => _AddSpreadsheetState();
}

class _AddSpreadsheetState extends State<AddSpreadsheet> {
  TextEditingController spreadsheetIdController = new TextEditingController();
  TextEditingController sheetNameController = new TextEditingController();
  TextEditingController qController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Add Spread Sheet"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MainPage()),
                );
              },
              icon: const Icon(Icons.logout)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15.0),
              child: TextField(
                controller: spreadsheetIdController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'spreadsheetId',
                    hintText: 'Enter spreadsheetId'),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15.0),
              child: TextField(
                controller: sheetNameController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'sheetName',
                    hintText: 'Enter sheetName'),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15.0),
              child: TextField(
                controller: qController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'q',
                    hintText: 'Enter Q'),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              child: FlatButton(
                onPressed: () async {
                  // FirebaseFirestore.instance.collection('data').add({
                  //   'q': qController.text.toString(),
                  //   'spreadsheetId': spreadsheetIdController.text.toString(),
                  //   'sheetName': sheetNameController.text.toString()
                  // });
                },
                child: Text(
                  'Add',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            FlatButton(
              onPressed: () {
                //TODO FORGOT PASSWORD SCREEN GOES HERE
              },
              child: Text(
                'cancel',
                style: TextStyle(color: Colors.blue, fontSize: 25),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
