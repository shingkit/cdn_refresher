// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'http_client.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RefreshRespBean _$RefreshRespBeanFromJson(Map<String, dynamic> json) {
  return RefreshRespBean(
    json['Code'] as int,
    json['Message'] as String,
    json['itemId'] as String,
  );
}

Map<String, dynamic> _$RefreshRespBeanToJson(RefreshRespBean instance) =>
    <String, dynamic>{
      'Code': instance.code,
      'Message': instance.msg,
      'itemId': instance.itemId,
    };
