import 'dart:async';

import 'package:adivery/adivery_ads.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:adivery/adivery.dart';
import 'package:url_launcher/url_launcher.dart';

String codemeli = '';
bool resualt = false;
bool first = true;
// ignore: non_constant_identifier_names
String APPID = '3bf4ce32-8257-4be7-a5e9-8382758bc3c7';
// ignore: non_constant_identifier_names
String PLACEMENT_ID = "871c9a54-2ea6-4d74-9a90-3805ddc2820e";
// ignore: non_constant_identifier_names
String PLACEMENT_ID_BANNER = 'f5daf077-a78f-4c4e-947b-252c8afe26f5';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  _showInterstitial() {
    Timer(const Duration(seconds: 3), () {
      AdiveryPlugin.isLoaded(PLACEMENT_ID)
          .then((isLoaded) => showPlacement(isLoaded!, PLACEMENT_ID));
    });
  }

  void showPlacement(bool isLoaded, String placementId) {
    if (isLoaded) {
      AdiveryPlugin.show(placementId);
    }
  }

  @override
  void initState() {
    super.initState();
    AdiveryPlugin.initialize(APPID);
    AdiveryPlugin.prepareInterstitialAd(PLACEMENT_ID);
  }

  Widget build(BuildContext context) {
    return MaterialApp(
        localizationsDelegates: [
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          Locale("fa", "IR"),
        ],
        home: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.blue[300],
          appBar: AppBar(
            backgroundColor: Colors.indigo,
            title: Center(
                child: Text('استعلام کد ملی',
                    style: new TextStyle(
                        fontSize: 25, color: Colors.white, fontFamily: 'yek'),
                    textScaleFactor: 1.0)),
          ),
          body: Container(
            // color: Colors.indigo[90],

            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Center(
                child: Column(
              children: [
                Spacer(),
                Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width / 1.2,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.indigo,
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 10.0,
                            color: Colors.white,
                            spreadRadius: 3),
                      ],
                    ),
                    child: TextField(
                        keyboardType: TextInputType.number,
                        onChanged: (text) {
                          codemeli = text;
                        },
                        textAlign: TextAlign.center,
                        textAlignVertical: TextAlignVertical.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w900),
                        decoration: InputDecoration(
                            hintText: "کد ملی",
                            hintStyle: TextStyle(
                                fontSize: 20.0,
                                color: Colors.white,
                                fontFamily: 'yek'),
                            fillColor: Colors.white,
                            border: OutlineInputBorder()))),
                Spacer(),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.indigo,
                    ),
                    onPressed: () {
                      FocusManager.instance.primaryFocus!.unfocus();
                      estelam();
                    },
                    child: Text('استعلام',
                        style: new TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                            fontFamily: 'yek'),
                        textScaleFactor: 1.0)),
                Spacer(),
                first
                    ? Text('')
                    : resualt
                        ? Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width / 1.2,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.green[900],
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 10.0,
                                    color: Colors.white,
                                    spreadRadius: 3),
                              ],
                            ),
                            child: Text('کد ملی وارد شده معتبر میباشد',
                                style: new TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontFamily: 'yek'),
                                textScaleFactor: 1.0))
                        : Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width / 1.2,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.red[900],
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 10.0,
                                    color: Colors.white,
                                    spreadRadius: 3),
                              ],
                            ),
                            child: Text('کد ملی وارد شده معتبر نمی باشد',
                                style: new TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontFamily: 'yek'),
                                textScaleFactor: 1.0)),
                Spacer(),
                BannerAd(
                  PLACEMENT_ID_BANNER,
                  BannerAdSize.LARGE_BANNER,
                  onAdLoaded: (ad) {},
                  onAdClicked: (ad) {},
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Spacer(),
                    TextButton(
                        onPressed: () {
                          launchURL('https://mfuzzy.com');
                        },
                        child: Text(
                          'Mokav وبسایت',
                          style: TextStyle(color: Colors.white),
                          textScaleFactor: 1,
                        )),
                    Spacer(),
                    TextButton(
                      onPressed: () {
                        launchURL(
                            'mailto:<info@mfuzzy.com>?subject=<برنامه استعلام کد ملی >&body=<ارتباط با توسعه دهنده   ->');
                        // launch("email:" +
                        //     Uri.encodeComponent('info@mfuzzy.com'));
                      },
                      child: Text('Email ایمیل',
                          style: TextStyle(color: Colors.white),
                          textScaleFactor: 1.0),
                    ),
                    Spacer(),
                  ],
                ),
              ],
            )),
          ),
        ));
  }

  estelam() async {
    first = false;
    var dio = Dio();
    final response =
        await dio.get("https://api.codebazan.ir/codemelli/?code=$codemeli");

    if (response.data['Ok'] == 'ture') {
      setState(() {
        resualt = true;
      });
    } else {
      setState(() {
        resualt = false;
      });
    }

    // _showInterstitial();
  }
}

launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
