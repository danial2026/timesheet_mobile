import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:timesheet_flutter_app/controller/user_controller.dart';
import 'package:timesheet_flutter_app/model/form_google_sheet.dart';

import 'package:timesheet_flutter_app/model/local_data_source.dart';
import 'package:timesheet_flutter_app/model/spreadsheet_dto.dart';

class GoogleController extends GetxController {
  final UserController userController = UserController();

  var checkIfFirstTime = true;

  static const String googleURL = "script.google.com";

  static const String googleSheetPATH =
      "/macros/s/AKfycbwBxxN9u1OrALy7Rmwk6sz6zQATPR1c1mbwte8MyqA/dev";

  // static const String serverURL = "192.168.43.114:8082";
  static const String serverURL = "192.168.1.33:8082";

  static const String serverPATH = "/api/v1";

  // Success Status Message
  static const STATUS_SUCCESS = "SUCCESS";

  /// Async function which saves feedback, parses [feedbackForm] parameters
  /// and sends HTTP GET request on [URL]. On successful response, [callback] is called.
  // void submitForm(
  //     GooleSheetForm gooleSheetForm, void Function(String) callback) async {
  //   try {
  //     await post(URI, body: gooleSheetForm.toJson()).then((response) async {
  //       if (response.statusCode != 200 && response.statusCode != 302 && checkIfFirstTime) {
  //         // TODO : new token
  //         userController.refreshGoogleToken();
  //         checkIfFirstTime = !checkIfFirstTime;
  //         submitForm(gooleSheetForm, callback);
  //       }
  //       if (checkIfFirstTime) {
  //         checkIfFirstTime = !checkIfFirstTime;
  //       }
  //       if (response.statusCode == 302) {
  //         var url = response.headers['location'];
  //         await get(Uri.parse(url!)).then((response) {
  //           callback(jsonDecode(response.body)['status']);
  //         });
  //       } else {
  //         callback(jsonDecode(response.body)['status']);
  //       }
  //     });
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  /// Async function which loads feedback from endpoint URL and returns List.
  Future<List<GooleSheetForm>> getFeedbackList(
      Map<String, String> googleSheetParam) async {
    Uri URI = new Uri.http(googleURL, googleSheetPATH, googleSheetParam);
    LocalDataSource lds = new LocalDataSource();
    final String? accessToken = await lds.getToken();
    var header = {"Authorization": "Bearer " + accessToken!};

    return await get(URI, headers: header).then((response) {
      if (response.statusCode != 200 && checkIfFirstTime) {
        // TODO : new token
        userController.refreshGoogleToken();
        checkIfFirstTime = !checkIfFirstTime;
        // getFeedbackList(googleSheetParam);
      }
      if (checkIfFirstTime) {
        checkIfFirstTime = !checkIfFirstTime;
      }
      var jsonFeedback = jsonDecode(response.body) as List;
      return jsonFeedback.map((json) => GooleSheetForm.fromJson(json)).toList();
    });
  }

  getSpreadSheetList() async {
    Uri URI = new Uri.http(serverURL, serverPATH + "/work-spaces-list");
    LocalDataSource lds = new LocalDataSource();
    final String? accessToken = await lds.getToken();
    var header = {"Authorization": accessToken!};

    return await get(URI, headers: header).then((response) {
      if (response.statusCode != 200 && checkIfFirstTime) {
        // TODO : new token
        userController.refreshGoogleToken();
        checkIfFirstTime = !checkIfFirstTime;
      }
      if (checkIfFirstTime) {
        checkIfFirstTime = !checkIfFirstTime;
      }
      var jsonFeedback = jsonDecode(response.body) as List;
      return jsonFeedback.map((json) => SpreadSheetDTO.fromJson(json)).toList();
    });
  }

  getSpreadSheetDetails(Map<String, String> spreadSheetId) async {
    Uri URI =
        new Uri.http(serverURL, serverPATH + "/work-space", spreadSheetId);
    LocalDataSource lds = new LocalDataSource();
    final String? accessToken = await lds.getToken();
    var header = {"Authorization": accessToken!};

    return await get(URI, headers: header).then((response) {
      if (response.statusCode != 200 && checkIfFirstTime) {
        // TODO : new token
        userController.refreshGoogleToken();
        checkIfFirstTime = !checkIfFirstTime;
      }
      if (checkIfFirstTime) {
        checkIfFirstTime = !checkIfFirstTime;
      }
      var jsonFeedback = jsonDecode(response.body);
      return SpreadSheetDTO.fromJson(jsonFeedback);
      // return jsonFeedback
      //     .map<SpreadSheetDTO>((json) => SpreadSheetDTO.fromJson(json));
    });
  }
}
