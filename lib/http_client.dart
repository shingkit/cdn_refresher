import 'dart:convert';
import 'dart:io';
import 'package:cdn_refresher/config.dart';
import 'package:cdn_refresher/main.dart';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';

part 'http_client.g.dart';

@JsonSerializable(nullable: false)
@JsonSerializable()
class RefreshRespBean {
  factory RefreshRespBean.fromJson(Map<String, dynamic> json) =>
      _$RefreshRespBeanFromJson(json);

  Map<String, dynamic> toJson(instance) => _$RefreshRespBeanToJson(this);

  @JsonKey(name: "Code")
  final int code;
  @JsonKey(name: "Message")
  final String msg;
  @JsonKey(name: "itemId")
  final String itemId;

  RefreshRespBean(this.code, this.msg, this.itemId);
}


class HttpClient{
  HttpClient();

  String signAndBase64Encode(String data, String apiKey) {
    var hmac = new Hmac(sha1, utf8.encode(apiKey));
    var sha1Value = hmac.convert(utf8.encode(data));
    return base64.encode(sha1Value.bytes);
  }

  String encode(String date, String user, String apiKey) {
    var sign = signAndBase64Encode(date, apiKey);
    String userAndPwd = '$user:$sign';
    return base64.encode(utf8.encode(userAndPwd));
  }

  Future<void> requestRefresh(String url) async {
//    url = "https://static.majiang.fanle.com/ddzdown/getversion";
    var user = cdnUser;
    var apiKey = cdnApiKey;
    var date = HttpDate.format(DateTime.now()).trim();
    var auth = encode(date, user, apiKey);
    var data = {"urls": url.split("\n")};
    try {
      Response response = await Dio()
          .post('https://open.chinanetcenter.com/ccm/purge/ItemIdReceiver',
          data: json.encode(data),
          options: Options(headers: {
            "Accept": "application/json",
            "Content-Type": "application/json",
            "Date": date,
            "Authorization": "Basic $auth"
          }));
      if (response.statusCode == 200) {
        RefreshRespBean bean = RefreshRespBean.fromJson(response.data);
        if (bean.code == 1){
          return;
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

}

