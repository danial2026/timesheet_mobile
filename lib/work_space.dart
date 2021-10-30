import 'package:flutter/foundation.dart';

class WorkSpace {
  final String workSpaceId;
  final String workSpaceTitle;

  WorkSpace({
    required this.workSpaceId,
    required this.workSpaceTitle,
  });

  factory WorkSpace.fromJson(Map<String, dynamic> json) {
    return WorkSpace(
      workSpaceId: json['workSpaceId'] as String,
      workSpaceTitle: json['workSpaceTitle'] as String,
    );
  }
}
