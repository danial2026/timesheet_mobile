import 'package:json_annotation/json_annotation.dart';

part 'spreadsheet_dto.g.dart';

@JsonSerializable()
class SpreadSheetDTO {
  String workSpaceId;
  String workSpaceTitle;
  String? spreadSheetId;
  List<SheetDTO>? sheets;

  SpreadSheetDTO(this.workSpaceId, this.workSpaceTitle, this.spreadSheetId,
      this.sheets);

  factory SpreadSheetDTO.fromJson(Map<String, dynamic> json) =>
      _$SpreadSheetDTOFromJson(json);

  Map<String, dynamic> toJson() => _$SpreadSheetDTOToJson(this);
}

@JsonSerializable()
class SheetDTO {
  int? sheetId;
  String? sheetTitle;

  SheetDTO(this.sheetId, this.sheetTitle);

  factory SheetDTO.fromJson(Map<String, dynamic> json) =>
      _$SheetDTOFromJson(json);

  Map<String, dynamic> toJson() => _$SheetDTOToJson(this);
}
