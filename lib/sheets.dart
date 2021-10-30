import 'dart:ffi';

import 'package:flutter/foundation.dart';

class WorkSpaceDetails {
  final String workSpaceId;
  final String workSpaceTitle;
  final String spreadSheetId;
  final List<Sheets> sheets;

  WorkSpaceDetails({
    required this.workSpaceId,
    required this.workSpaceTitle,
    required this.spreadSheetId,
    required this.sheets,
  });

  factory WorkSpaceDetails.fromJson(Map<String, dynamic> json) {
    return WorkSpaceDetails(
        workSpaceId: json['workSpaceId'] as String,
        workSpaceTitle: json['workSpaceTitle'] as String,
        spreadSheetId: json['spreadSheetId'] as String,
        sheets: json['sheets'] as List<Sheets>);
  }
}

class Sheets {
  final String sheetId;
  final String sheetTitle;

  Sheets({
    required this.sheetId,
    required this.sheetTitle,
  });

  factory Sheets.fromJson(Map<String, dynamic> json) {
    return Sheets(
        sheetId: json['sheetId'] as String,
        sheetTitle: json['sheetTitle'] as String);
  }
}
