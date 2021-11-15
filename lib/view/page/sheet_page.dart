import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timesheet_flutter_app/controller/google_controller.dart';
import 'package:timesheet_flutter_app/controller/user_controller.dart';
import 'package:timesheet_flutter_app/model/form_google_sheet.dart';

class SheetPage extends StatefulWidget {
  final Map<String, String> googleSheetParam;

  const SheetPage(this.googleSheetParam, {Key? key}) : super(key: key);

  @override
  State<SheetPage> createState() => _SheetPageState(this.googleSheetParam);
}

class _SheetPageState extends State<SheetPage> {
  final UserController userController = UserController();
  // String hhh = '';
  // final JiraController jiraController = Get.put(JiraController());
  List<GooleSheetForm> feedbackItems = <GooleSheetForm>[];

  Map<String, String> googleSheetParam;
  _SheetPageState(this.googleSheetParam);

  // Method to Submit Feedback and save it in Google Sheets

  @override
  void initState() {
    super.initState();
    User? user = userController.getUserData();

    GoogleController().getFeedbackList(googleSheetParam).then((feedbackItems) {
      setState(() {
        this.feedbackItems = feedbackItems;
      });
    });
  }

  // final JiraController jiraController = Get.put(JiraController());

  @override
  Widget build(BuildContext context) {
    GoogleController googleController = new GoogleController();

    User? user = userController.getUserData();

    return Scaffold(
      appBar: AppBar(
        title: Text("Google Sheet"),
      ),
      floatingActionButton: Stack(
        children: <Widget>[
          // Positioned(
          //   right: 15,
          //   bottom: 90,
          //   child: FloatingActionButton(
          //     heroTag: 'add task',
          //     onPressed: () {},
          //     child: Icon(Icons.task_alt),
          //   ),
          // ),
          Positioned(
            right: 15,
            bottom: 15,
            child: FloatingActionButton(
              heroTag: 'start',
              onPressed: () {},
              child: Icon(Icons.play_arrow_rounded),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: feedbackItems.length,
        itemBuilder: (context, index) {
          String date = feedbackItems[index].actual;

          // String timeText = "";
          if (date != "") {
            if (date.contains("T")) {
              date = date.replaceAll("-", "");
              date = date.replaceAll(":", "");
            }
            if (date.contains("Z")) {
              date = date.substring(0, date.length - 5);
            }
            if (date.contains(" ") || date.contains("T")) {
              DateTime finalTime = DateTime.parse(date);

              DateTime startTime = DateTime.parse("1899-12-29T20:34:16.000Z");

              var diff = finalTime.difference(startTime);
              var timeInSec = (diff.inSeconds + 12600);
              Duration duration = Duration(seconds: timeInSec);

              feedbackItems[index].actual = [
                duration.inHours,
                duration.inMinutes,
                duration.inSeconds
              ]
                  .map((seg) => seg.remainder(60).toString().padLeft(2, '0'))
                  .join(':');
            }
          }
          return ListTile(
            onTap: () async {
              print(feedbackItems[index].toJson().toString());
              // jiraController.testAuth2();
            },
            title: Row(
              children: <Widget>[
                // Icon(Icons.date_range),
                Expanded(
                  child: Text(
                      "${feedbackItems[index].date} ${feedbackItems[index].weekday}"),
                )
              ],
            ),
            subtitle: Row(
              children: <Widget>[
                Expanded(
                  child: Text(feedbackItems[index].actual),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
