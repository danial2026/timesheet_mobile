import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
          var isToday = false;

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

          if (feedbackItems[index].date.contains(" ")) {
            DateTime now = new DateTime.now();
            String todayString =
                monthsInName[now.month].toString() + " " + now.day.toString();
            if (todayString == feedbackItems[index].date) {
              isToday = true;
            }
          }
          return ListTile(
            onTap: () async {
              print(feedbackItems[index].toJson().toString());
              if (feedbackItems[index].date.contains(" ")) {
                DateTime now = new DateTime.now();
                String todayString = monthsInName[now.month].toString() +
                    " " +
                    now.day.toString();
                if (todayString == feedbackItems[index].date) {
                  print("true");
                }
              }

            },
            title: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                      "${feedbackItems[index].date} ${feedbackItems[index].weekday}",
                      style: TextStyle(color: isToday ? Colors.redAccent : Colors.black,),
                ),
                ),
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

const Map<String, int> monthsInInt = {
  "January": 1,
  "February": 2,
  "March": 3,
  "April": 4,
  "May": 5,
  "June": 6,
  "July": 7,
  "August": 8,
  "September": 9,
  "October": 10,
  "November": 11,
  "December": 12
};

const Map<int, String> monthsInName = {
  1: "January",
  2: "February",
  3: "March",
  4: "April",
  5: "May",
  6: "June",
  7: "July",
  8: "August",
  9: "September",
  10: "October",
  11: "November",
  12: "December"
};
