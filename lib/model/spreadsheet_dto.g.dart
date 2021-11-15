// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spreadsheet_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpreadSheetDTO _$SpreadSheetDTOFromJson(Map<String, dynamic> json) =>
    SpreadSheetDTO(
      json['workSpaceId'] as String,
      json['workSpaceTitle'] as String,
      json['spreadSheetId'] as String?,
      (json['sheets'] as List<dynamic>?)
          ?.map((e) => SheetDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SpreadSheetDTOToJson(SpreadSheetDTO instance) =>
    <String, dynamic>{
      'workSpaceId': instance.workSpaceId,
      'workSpaceTitle': instance.workSpaceTitle,
      'spreadSheetId': instance.spreadSheetId,
      'sheets': instance.sheets,
    };

SheetDTO _$SheetDTOFromJson(Map<String, dynamic> json) => SheetDTO(
      json['sheetId'] as int?,
      json['sheetTitle'] as String?,
    );

Map<String, dynamic> _$SheetDTOToJson(SheetDTO instance) => <String, dynamic>{
      'sheetId': instance.sheetId,
      'sheetTitle': instance.sheetTitle,
    };
