import 'dart:convert';

import 'package:any_link_preview/any_link_preview.dart';
import 'package:danawa_store2/bean/Result.dart';
import 'package:danawa_store2/screens/QRScannerOverlay.dart';
import 'package:danawa_store2/util/content.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;


class ReadQR extends StatefulWidget {
  final BizNo;
  final storeType;
  Map<String, dynamic> storeList;

  ReadQR({
    Key? key,
    required this.BizNo,
    required this.storeList,
    required this.storeType,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ReadQR();
}

class _ReadQR extends State<ReadQR> {
  // Barcode? result;
  bool scanFlag = false;
  MobileScannerController controller = MobileScannerController();
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  bool use = false;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    // if (Platform.isAndroid) {
    //   controller!.pauseCamera();
    // }
    // controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        bottomOpacity: 0.0,
        elevation: 1.0,
        leading: BackButton(color: Colors.black),
        title: Text(
          '코드 스캔',
          style: TextStyle(
            fontSize: 17,
            color: Colors.black,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
      body: Stack(
          alignment: Alignment(0.9, -1),
          children: <Widget>[
            // _buildQrView(context),
            MobileScanner(
                allowDuplicates: true,
                controller: controller,
                onDetect: (barcode, args) {
                  if (scanFlag) {
                    scanFlag = false;
                    use = false;
                    setState(() {
                    });
                    if (barcode.type == BarcodeType.url){
                      bottom(barcode.rawValue!);
                    }else if(barcode.type == BarcodeType.text){
                      couponRead(barcode.rawValue!);
                    }
                  }
                }),
            QRScannerOverlay(overlayColour: Colors.black.withOpacity(0.5)),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 100,
                padding: EdgeInsets.fromLTRB(40,0,40,40),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: (use)?Colors.yellow:Colors.white54,
                  ),
                    onPressed: (){
                      if(!use){
                        use = true;
                        scanFlag = true;
                        setState(() {
                        });
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Scan a QR code',style: TextStyle(color: Colors.black,fontSize: 17),),
                            Text('Quét mã QR',style: TextStyle(color: Colors.black))
                        ],
                      ),
                    )
                  )
                ),
              ),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                  padding: EdgeInsets.fromLTRB(10,5,0,0),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary:Colors.yellow,
                      ),
                      onPressed: () async {
                        _asyncInputDialog(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child:
                            Text('Input Coupon Number',style: TextStyle(color: Colors.black,fontSize: 14),),
                      )
                  )
              ),
            ),
            Positioned(
                top: 10,
                child: Container(
                  height: 38,
                  width: 38,
                  child:CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white54,
                  child: IconButton(
                    color: Colors.white,
                    icon: ValueListenableBuilder(
                      valueListenable: controller.torchState,
                      builder: (context, state, child) {
                        switch (state as TorchState) {
                          case TorchState.off:
                            return const Icon(Icons.flash_off, color: Colors.black87,size: 20,);
                          case TorchState.on:
                            return const Icon(Icons.flash_on, color: Colors.yellow,size: 20);
                        }
                      },
                    ),
                    iconSize: 32.0,
                    onPressed: () => controller.toggleTorch(),
                  ),),)),]
      )
    );
  }

  Future _asyncInputDialog(BuildContext context) async {
    String teamName = '';
    return showDialog(
      context: context,
      barrierDismissible: false, // dialog is dismissible with a tap on the barrier
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Input Coupon Number'),
          content: new Row(
            children: [
              new Expanded(
                  child: new TextField(
                    autofocus: true,
                    decoration: new InputDecoration(
                        labelText: 'Coupon Number'),
                    onChanged: (value) {
                      teamName = value;
                    },
                  ))
            ],
          ),
          actions: [
            ElevatedButton(
              child: Text('Submit'),
              onPressed: () {
                Navigator.pop(context);
                couponRead(teamName);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> couponRead(String url) async {
      // url = url + +widget.storeNum;
      url = 'https://outsider21.cafe24.com/tour_app/store/scan/rest_insert_coupon.php?GuestNum=${url}&BizNo=${widget.BizNo}';
      print(url);
      http.Response response = await http.post(
        Uri.parse(url),
      );
      print(response.body);
      var parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      List<Result> re = parsed.map<Result>((json) => Result.fromJson(json)).toList();
      if (re[0].resultCode == '0000') {
        Alert(
          closeFunction: (){
            Navigator.of(context).pop();
            Navigator.pop(context);
          },
          context: context,
          type: AlertType.success,
          title: 'Coupon was applied',
          buttons: [
            DialogButton(
              color: Colors.green,
              child: Text(
                "OK",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.pop(context);
              },
              width: 100,
            )
          ],
        ).show();
      } else {
        Alert(
          closeFunction: (){
            Navigator.of(context).pop();
          },
          context: context,
          type: AlertType.error,
          title: 'Coupon can not be applied',
          desc: '${re[0].resultEn}\n${re[0].resultVt}',
          style: AlertStyle(
            descStyle: TextStyle(color: Colors.black54,fontSize: 16)
          ),
          buttons: [
            DialogButton(
              color: Colors.redAccent,
              child: Text(
                "OK",
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              width: 80,
            )
          ],
        ).show();
      }
  }

  void bottom(String url){
    showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return Container(
            height: 200,
            color: Colors.white,
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.close)),
                AnyLinkPreview(
                  removeElevation: true,
                  link: url,
                  displayDirection: UIDirection.uiDirectionHorizontal,
                  cache: Duration(hours: 5),
                  backgroundColor: Colors.white,
                  errorBody: url,
                  errorWidget:
                     Container(
                      width: double.infinity,
                      height: 130,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('QR를 코드를 읽을 수 없습니다.',textAlign: TextAlign.center,),
                          Text('Mã vạch QR  không thể đọc được',textAlign: TextAlign.center,),
                        ],
                      ),
                  ),
                  // errorImage: _errorImage,
                ),
              ],
            ),
          );
        }).whenComplete(() {
    });
  }

  // void _onQRViewCreated(QRViewController controller) {
  //   this.controller = controller;
  //   controller.scannedDataStream.listen((scanData) async {
  //     result = scanData;
  //     if(result != null) {
  //       if(result!.format == BarcodeFormat.qrcode) {
  //         //바코드가 QR일때
  //         if (scanCode != result!.code) {
  //           //코드랑 저장된 코드가 다를때
  //           if (scanCode == '') {
  //             // Navigator.pop(context);
  //           } else {
  //             scanCode = '';
  //             String url = result!.code!;
  //             HapticFeedback.vibrate();
  //             if (url.contains('.php')) {
  //               // url = url + widget.guestNum;
  //               url = url + '1';
  //               http.Response response = await http.post(
  //                 Uri.parse(url),
  //               );
  //               print(response.body);
  //               var parsed = json.decode(response.body).cast<Map<String, dynamic>>();
  //               List<Result> re = parsed.map<Result>((json) => Result.fromJson(json)).toList();
  //               if (re[0].resultCode == '0000') {
  //                 Navigator.pop(context);
  //                 showDialog(
  //                   context: context,
  //                   builder: (context) {
  //                     return AlertDialog(
  //                       title: Text('스캔 성공'),
  //                       content: Text(re[0].resultMessage),
  //                       actions: <Widget>[
  //                         TextButton(
  //                           onPressed: () {
  //                             scanCode = 'A';
  //                             Navigator.of(context).pop(); // dismisses only the dialog and returns true
  //                           },
  //                           child: Text('확인'),
  //                         ),
  //                       ],
  //                     );
  //                   },
  //                 );
  //               } else {
  //                 Navigator.pop(context);
  //                 showDialog(
  //                   context: context,
  //                   builder: (context) {
  //                     return AlertDialog(
  //                       title: Text('스캔 오류'),
  //                       content: Text(re[0].resultMessage),
  //                       actions: <Widget>[
  //                         TextButton(
  //                           onPressed: () {
  //                             scanCode = 'A';
  //                             Navigator.of(context).pop(); // dismisses only the dialog and returns true
  //                           },
  //                           child: Text('확인'),
  //                         ),
  //                       ],
  //                     );
  //                   },
  //                 );
  //               }
  //             }else{
  //               print(url);
  //               showModalBottomSheet<void>(
  //                   context: context,
  //                   isScrollControlled: true,
  //                   builder: (BuildContext context) {
  //                     return Container(
  //                       height: 200,
  //                       color: Colors.white,
  //                       padding: EdgeInsets.all(10),
  //                       child: Column(
  //                         crossAxisAlignment: CrossAxisAlignment.end,
  //                         children: [
  //                           IconButton(
  //                               onPressed: () {
  //                                 Navigator.pop(context);
  //                                 scanCode = 'A';
  //                               },
  //                               icon: Icon(Icons.close)),
  //                           AnyLinkPreview(
  //                             removeElevation: true,
  //                             link: url,
  //                             displayDirection: uiDirection.uiDirectionHorizontal,
  //                             cache: Duration(hours: 1),
  //                             backgroundColor: Colors.white,
  //                             errorBody: 'aaa'+url,
  //                             errorWidget: Container(
  //                               color: Colors.grey[300],
  //                               child: Text('QR CODE SCANING ERROR'),
  //                             ),
  //                             // errorImage: _errorImage,
  //                           ),
  //                         ],
  //                       ),
  //                     );
  //                   }).whenComplete(() {
  //                 scanCode = 'A';
  //               });
  //             }
  //           }
  //         }else{
  //           //코드랑 저장된 코드가 같을때
  //         }
  //       }
  //     }else{
  //
  //     }
  //   });
  // }

  void _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      try {
        await launch(url);
      } catch (err) {
        throw Exception('Could not launch $url. Error: $err');
      }
    }
  }

  // void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
  //   log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
  //   if (!p) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('no Permission')),
  //     );
  //   }
  // }

  @override
  void dispose() {
    // controller?.dispose();
    super.dispose();
  }
}