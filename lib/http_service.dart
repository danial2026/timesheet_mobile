import 'dart:convert';
import 'package:http/http.dart';
import 'package:timesheet_flutter_app/Sheets.dart';
import 'package:timesheet_flutter_app/work_space.dart';

class HttpService {
  Future<String> getMyWorkSpaces() async {
    String getWorkSpaceURL = "192.168.1.36:8082";
    String getWorkSpacePATH = "/api/v1/work-spaces-list";

    Map<String, String> userQueParam = {"email": ""};
    Uri uri = new Uri.http(getWorkSpaceURL, getWorkSpacePATH, userQueParam);

    Map<String, String> userHeader = {
      "Google-Sheet-Access-Token": "",
      "Google-Sheet-Refresh-Token": "",
      "Google-Sheet-Expires-In-Seconds": "",
      "Google-Sheet-ClientId": ""
    };

    Response res = await get(uri, headers: userHeader);

    if (res.statusCode == 200) {
      // dynamic body = jsonDecode(res.body);

      // WorkSpace workSpace = WorkSpace.fromJson(body);
      // return workSpace;

      return res.body.toString();
    } else {
      throw "Unable to retrieve WorkSpace.";
    }
  }

  Future<WorkSpaceDetails> getWorkSpace() async {
    String getWorkSpaceURL = "192.168.1.36:8082";
    String getWorkSpacePATH = "/api/v1/work-space";

    Map<String, String> userQueParam = {"workSpaceId": ""};

    Uri uri = new Uri.http(getWorkSpaceURL, getWorkSpacePATH, userQueParam);

    Map<String, String> userHeader = {
      "Google-Sheet-Access-Token": "",
      "Google-Sheet-Refresh-Token": "",
      "Google-Sheet-Expires-In-Seconds": "",
      "Google-Sheet-ClientId": ""
    };

    Response res = await get(uri, headers: userHeader);

    if (res.statusCode == 200) {
      dynamic body = jsonDecode(res.body);

      WorkSpaceDetails workSpaceDetails = WorkSpaceDetails.fromJson(body);

      return workSpaceDetails;
    } else {
      throw "Unable to retrieve WorkSpace.";
    }
  }
}
