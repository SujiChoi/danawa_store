import 'dart:convert';
import 'package:danawa_store2/firebase_options.dart';
import 'package:danawa_store2/screens/MainScreen.dart';
import 'package:danawa_store2/screens/LoginScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_in_app_messaging/firebase_in_app_messaging.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String? storeList = preferences.getString('storeList');
  var storeType = preferences.getString('storeType');
  var BizNo = preferences.getString('BizNo');
  List<Map<String, dynamic>> list = [];
  if(storeList != null) {
    list = json.decode(storeList).cast<Map<String, dynamic>>();
    print(list);
    print(list[0]['BizNo']);
  }
  runApp(BizNo == null ? MyApp() : MainApp(storeNum: BizNo,storeType: storeType,storeList : list[0],pageIndex: 0,));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Login UI',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en'),
        const Locale('zh'),
        const Locale('ko', 'KR'),
      ],
      locale: Locale('ko', 'KR'),
      home: LoginScreen(),
    );
  }
}

class MainApp extends StatefulWidget {
  final storeNum;
  final storeType;
  final int pageIndex;
  Map<String, dynamic> storeList;

  MainApp({
    Key? key,
    required this.storeNum,
    required this.pageIndex,
    required this.storeList,
    required this.storeType,
  }) : super(key: key);

  @override
  _MainApp createState() => _MainApp();
}

class _MainApp extends State<MainApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Login UI',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en'),
        const Locale('zh'),
        const Locale('ko', 'KR'),
      ],
      locale: Locale('ko', 'KR'),
      home: MainScreen(BizNo: widget.storeNum,pageIndex: 0,storeList: widget.storeList,storeType: widget.storeType),
    );
  }
}