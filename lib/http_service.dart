import 'dart:convert';
import 'package:http/http.dart';
import 'package:timesheet_flutter_app/Sheets.dart';
import 'package:timesheet_flutter_app/work_space.dart';

class HttpService {
  Future<String> getMyWorkSpaces() async {
    String getWorkSpaceURL = "192.168.1.36:8082";
    String getWorkSpacePATH = "/api/v1/work-spaces-list";

    Map<String, String> userQueParam = {"email": "1998alirezam@gmail.com"};
    Uri uri = new Uri.http(getWorkSpaceURL, getWorkSpacePATH, userQueParam);

    Map<String, String> userHeader = {
      "Google-Sheet-Access-Token":
          "ya29.a0ARrdaM9pP-Z8uMif0n6smnlrmLAAkJG87KLgISywEKosw6q-6SV6edbtN0Qzmw7dsMG0I0IGihUqFd-lt0GfSqJxDrBKFoVJ-zVycDdTiGxxLcQz27rbqyanwvDeqjG0EGtkppOjIM7XJcsIW26bb7T5wNuB",
      "Google-Sheet-Refresh-Token":
          "1//0dV34-NUWyWo3CgYIARAAGA0SNwF-L9IriwnEKaqdHyWCu0FyiAxg5x9b-v7T8q51UUJqa_SRHlBCYo5lZ4dehe9I-I-Nmm5kifc",
      "Google-Sheet-Expires-In-Seconds": "1635219916481",
      "Google-Sheet-ClientId":
          "397300109176-efllj9hjd6tmmq7b0pk11mbqpl64fm2e.apps.googleusercontent.com"
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

    Map<String, String> userQueParam = {
      "workSpaceId": "61782e8a8dab312b55c9ce92"
    };

    Uri uri = new Uri.http(getWorkSpaceURL, getWorkSpacePATH, userQueParam);

    Map<String, String> userHeader = {
      "Google-Sheet-Access-Token":
          "ya29.a0ARrdaM9pP-Z8uMif0n6smnlrmLAAkJG87KLgISywEKosw6q-6SV6edbtN0Qzmw7dsMG0I0IGihUqFd-lt0GfSqJxDrBKFoVJ-zVycDdTiGxxLcQz27rbqyanwvDeqjG0EGtkppOjIM7XJcsIW26bb7T5wNuB",
      "Google-Sheet-Refresh-Token":
          "1//0dV34-NUWyWo3CgYIARAAGA0SNwF-L9IriwnEKaqdHyWCu0FyiAxg5x9b-v7T8q51UUJqa_SRHlBCYo5lZ4dehe9I-I-Nmm5kifc",
      "Google-Sheet-Expires-In-Seconds": "1635219916481",
      "Google-Sheet-ClientId":
          "397300109176-efllj9hjd6tmmq7b0pk11mbqpl64fm2e.apps.googleusercontent.com"
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
