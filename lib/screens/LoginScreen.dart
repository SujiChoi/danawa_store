import 'dart:convert';
import 'package:danawa_store2/screens/MainScreen.dart';
import 'package:danawa_store2/util/content.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreen createState() => _LoginScreen();
}

Future login(BuildContext context, String store_email, String store_password) async {
  String url = 'https://outsider21.cafe24.com/tour_app/store_login.php';
  http.Response response = await http.post(
    Uri.parse(url),
    headers: {
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Credentials": 'true',
      "Access-Control-Allow-Headers":
      "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
      "Access-Control-Allow-Methods": "GET,POST,PUT"
    },
    body: <String, String>{
      'storeEmail': store_email,
      'storePassword': store_password,
    },
  );
  if (response.body != 'false') {
      print(response.body);
      List<Map<String, dynamic>> parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      String BizNo = parsed[0]['BizNo'];
      String storeType = parsed[0]['storeType'];
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString('BizNo',BizNo);
      preferences.setString('storeList', response.body);
      preferences.setString('storeType', storeType);
      print(response.body);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainScreen(BizNo: BizNo,pageIndex: 0,storeList: parsed[0],storeType: storeType,)));
  } else {
    //예약 오류 예약
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('아이디 비밀번호 확인이 필요합니다.')));
  }
}

class _LoginScreen extends State<LoginScreen> {
  final email = TextEditingController();
  final password = TextEditingController();

  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: email,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.all(5),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.black45,
              ),
              hintText: 'ID',
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: password,
            keyboardType: TextInputType.visiblePassword,
            style: TextStyle(
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.all(5),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.black45,
              ),
              hintText: 'Password',
              // hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginBtn() {
    return Container(
      height: 50.0,
      // padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 5.0,
          padding: EdgeInsets.all(5.0),
          primary: MainColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
        onPressed: () {
          login(context, email.text, password.text);
        },
        child: Text(
          'LOGIN',
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 1.5,
            fontSize: MediaQuery.of(context).size.width * 0.05,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }


  Widget _buildSignupBtn() {
    return GestureDetector(
      // onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterScreen())),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Forgot your password?',
              style: TextStyle(
                color: Color(0xffFF1F319D),
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: double.infinity,
        child: Center(
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.fromLTRB(40.0, 10.0, 40.0, 0.0),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Sign In',
                    style: TextStyle(
                      color: Color(0xffFF1F319D),
                      fontFamily: 'OpenSans',
                      fontSize: MediaQuery.of(context).size.width * 0.09,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  addVerticalSpace(30),
                  _buildEmailTF(),
                  addVerticalSpace(10),
                  _buildPasswordTF(),
                  addVerticalSpace(10),
                  _buildLoginBtn(),
                  addVerticalSpace(30),
                  _buildSignupBtn(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
