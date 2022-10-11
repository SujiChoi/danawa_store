
import 'package:danawa_store2/bean/Rest.dart';
import 'package:danawa_store2/bean/Result.dart';
import 'package:danawa_store2/mgr/RestMgr.dart';
import 'package:danawa_store2/util/content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timeline_tile/timeline_tile.dart';

class massageFinalScreen extends StatefulWidget {
  final String ReservNum;
  final ReservDay;
  final MainCate;
  final guestNum;
  final String reState;
  final int total;
  final int totalD;
  final int maPerson;
  final int maTotalPerson;
  final List<String> titleList;
  final List<int> countList;
  final String uNameK;
  final String uNameE;
  final String uPhone;
  final String uKakao;
  final String uRequest;
  final DateTime maDate;
  final TimeOfDay maTime;

  massageFinalScreen({
    Key? key,
    required this.ReservNum,
    required this.ReservDay,
    required this.MainCate,
    required this.guestNum,
    required this.reState,
    required this.total,
    required this.totalD,
    required this.maPerson,
    required this.maTotalPerson,
    required this.titleList,
    required this.countList,
    required this.uNameK,
    required this.uNameE,
    required this.uPhone,
    required this.uKakao,
    required this.uRequest,
    required this.maDate,
    required this.maTime,
  }) : super(key: key);

  @override
  _massageFinalScreen createState() => _massageFinalScreen();
}

class _massageFinalScreen extends State<massageFinalScreen> {

  TextStyle titleStyle =  TextStyle(fontSize: 17, fontWeight: FontWeight.bold);
  double menuWidth = 120;
  TextStyle menuStyle = TextStyle(fontWeight: FontWeight.w500,fontSize: 15);
  TextStyle menu2Style = TextStyle(fontWeight: FontWeight.w400,fontSize: 14);

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    var f = NumberFormat('###,###,###,###');
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.clear,color: Colors.black,),
          onPressed: () {
            Navigator.pop(context);
          },),
        bottomOpacity: 0.0,
        elevation: 1.0,
        title: Text(
          widget.reState,
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        height: double.infinity,
        child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children:<Widget>[
                addVerticalSpace(20),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                  child:
                  (widget.reState == '입금대기')?
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:<Widget>[
                      Text('아직 예약 완료 되지 않았습니다.', style: TextStyle(fontSize: 20, color: Colors.black,fontWeight: FontWeight.w600)),
                      addVerticalSpace(10),
                      Row(
                        children: [
                          Text('예약 확정', style: TextStyle(fontSize: 18,color: Colors.redAccent,fontWeight: FontWeight.bold)),
                          Text('을 누르면 확정 됩니다.', style: TextStyle(fontSize: 18,)),
                        ],
                      ),
                    ]
                   ) :(widget.reState == '예약확정')?
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:<Widget>[
                        Row(
                          children: [
                            Text('예약 확정 ', style: TextStyle(fontSize: 18,color: Colors.redAccent,fontWeight: FontWeight.bold)),
                            Text('되었습니다.', style: TextStyle(fontSize: 18,)),
                          ],
                        ),
                      ]
                  ): Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:<Widget>[
                        Row(
                          children: [
                            Text('예약 취소 ', style: TextStyle(fontSize: 18,color: Colors.redAccent,fontWeight: FontWeight.bold)),
                            Text('되었습니다.', style: TextStyle(fontSize: 18,)),
                          ],
                        ),
                      ]
                  )
                ),
                addVerticalSpace(20),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Color(0xfff7f7f7),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget> [
                        addVerticalSpace(5),
                        Container(
                          child: Text(
                            '결제 정보',
                            style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                                fontSize: 17),
                          ),
                        ),
                        addVerticalSpace(15),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                          color: Colors.white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget> [
                              Expanded(
                                child: Text('예상지불금(동)',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15),
                                ),
                              ),
                              Text('${f.format(widget.total)}동',
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red)
                              )
                                ],
                              ),
                        ),
                        if(widget.totalD != 0)...[
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                            color: Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget> [
                                Expanded(
                                  child: Text('현장지불금(달러)',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15),
                                  ),
                                ),
                                Text('${f.format(widget.totalD)}\$',
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue)
                                )
                              ],
                            ),
                          ),
                        ],
                        addVerticalSpace(20),
                      ]
                  ),
                ),
                addVerticalSpace(20),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            ClipOval(
                                child: Container(
                                  width: 23,
                                  height: 23,
                                  color: Colors.green,
                                  child: Icon(Icons.arrow_forward_ios,
                                      color: Colors.white,size: 14),
                                )),
                            addHorizontalSpace(10),
                            Text(
                              '예약 정보',
                              style: titleStyle,
                            ),
                          ],
                        ),
                        addVerticalSpace(10),
                        Divider(color: Colors.black45,thickness: 1),
                        addVerticalSpace(5),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  SizedBox(width: menuWidth,child: Text('예약 번호',style: menuStyle)),
                                  Expanded(
                                    child: Text(
                                        widget.ReservNum,
                                        style: TextStyle(
                                          color: Colors.blueAccent,
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ],
                              ),
                              addVerticalSpace(13),
                              Row(
                                children: [
                                  SizedBox(width: menuWidth,child: Text('접수 일시',style: menuStyle)),
                                  Expanded(
                                    child: Text(
                                        '${widget.ReservDay}',
                                        style: TextStyle(
                                            color: Colors.black)),
                                  ),
                                ],
                              ),
                              addVerticalSpace(13),
                              Row(
                                children: [
                                  SizedBox(width: menuWidth,child: Text('예약 일시',style: menuStyle)),
                                  Expanded(
                                    child: Text(
                                        '${onedataToString(widget.maDate)} ${widget.maTime.hour}시 ${widget.maTime.minute}분',
                                        style: TextStyle(
                                            color: Colors.black)),
                                  ),
                                ],
                              ),
                              addVerticalSpace(13),
                              Row(
                                children: [
                                  SizedBox(width: menuWidth,child: Text('마사지 인원',style: menuStyle)),
                                  Expanded(
                                    child: Text(
                                        widget.maPerson.toString()+'명',
                                        style: TextStyle(
                                            color: Colors.black)),
                                  ),
                                ],
                              ),
                              addVerticalSpace(13),
                              if(widget.maTotalPerson == 0)...[
                                Row(
                                  children: [
                                    SizedBox(width: menuWidth,child: Text('총 탑승 인원',style: menuStyle)),
                                    Expanded(
                                      child: Text(
                                          widget.maTotalPerson.toString()+'명',
                                          style: TextStyle(
                                              color: Colors.black)),
                                    ),
                                  ],
                                ),
                                addVerticalSpace(13),
                              ],
                              Row(
                                children: [
                                  SizedBox(width: menuWidth,child: Text('예약 코스',style: menuStyle)),
                                ],
                              ),
                              addVerticalSpace(13),
                              for(int i = 0 ; i < widget.titleList.length; i++)...[
                                Row(
                                  children: [
                                    Container(width: 10,),
                                    Expanded(child: SizedBox(width: menuWidth,child: Text('${widget.titleList[i]}',style: menu2Style))),
                                    Text(
                                          '${widget.countList[i]}건',
                                          style: TextStyle(
                                              color: Colors.black)),
                                  ],
                                ),
                                addVerticalSpace(13),
                              ]
                            ],
                          ),
                        ),
                        addVerticalSpace(5),
                        Divider(color: Colors.black45,thickness: 1),
                      ]),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            ClipOval(
                                child: Container(
                                  width: 23,
                                  height: 23,
                                  color: Colors.green,
                                  child: Icon(Icons.arrow_forward_ios,
                                      color: Colors.white,size: 14),
                                )),
                            addHorizontalSpace(10),
                            Text(
                              '예약자 정보',
                              style: titleStyle,
                            ),
                          ],
                        ),
                        addVerticalSpace(10),
                        Divider(color: Colors.black45,thickness: 1),
                        addVerticalSpace(10),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  SizedBox(width: menuWidth,child: Text('예약자명(한글)',style: menuStyle)),
                                  Expanded(
                                    child: Text(
                                        widget.uNameK,
                                        style: TextStyle(
                                            color: Colors.black)),
                                  )
                                ],
                              ),
                              addVerticalSpace(13),
                              Row(
                                children: [
                                  SizedBox(width: menuWidth,child: Text('예약자명(영문)',style: menuStyle)),
                                  Expanded(
                                    child: Text(
                                        widget.uNameE,
                                        style: TextStyle(
                                            color: Colors.black)),
                                  )
                                ],
                              ),
                              addVerticalSpace(13),
                              Row(
                                children: [
                                  SizedBox(width: menuWidth,child: Text('휴대전화',style: menuStyle)),
                                  Expanded(
                                    child: Text(
                                        widget.uPhone,
                                        style: TextStyle(
                                            color: Colors.black)),
                                  )
                                ],
                              ),
                              addVerticalSpace(13),
                              Row(
                                children: [
                                  SizedBox(width: menuWidth,child: Text('카카오ID',style: menuStyle)),
                                  Expanded(
                                    child: Text(
                                        widget.uKakao,
                                        style: TextStyle(
                                            color: Colors.black)),
                                  )
                                ],
                              ),
                              addVerticalSpace(13),
                              if(widget.uRequest != '')...[
                                Row(
                                children: [
                                  SizedBox(width: menuWidth,child: Text('요청사항',style: menuStyle)),
                                  Expanded(
                                    child: Text(
                                        widget.uRequest,
                                        style: TextStyle(
                                            color: Colors.black)),
                                  )
                                ],
                              ),
                                addVerticalSpace(13),
                              ]
                            ],
                          ),
                        ),
                        Divider(color: Colors.black45,thickness: 1),
                      ]),
                ),
                (widget.reState == '입금대기')?
                Row(
                  children: [
                      Expanded(
                      child: Container(
                        height: 50.0,
                        padding: EdgeInsets.fromLTRB(25,0,5,0),
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            Result res = await RestMgr().resConfirm(widget.ReservNum);
                            if(res.resultCode == '0000') {
                              MainDialog('업로드 성공','예약 확정 되었습니다.');
                            }else{
                              MainDialog('업로드 오류', res.resultMessage);
                            }
                          },
                          child: Text(
                            '예약확정',
                            style: TextStyle(
                              color: Colors.white,
                              letterSpacing: 1.5,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'OpenSans',
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: MainColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12), // <-- Radius
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 50.0,
                        padding: EdgeInsets.fromLTRB(5,0,25,0),
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            Result res = await RestMgr().resCancle(widget.ReservNum,widget.guestNum,widget.MainCate);
                            if(res.resultCode == '0000') {
                              MainDialog('업로드 성공','예약 취소 되었습니다.');
                            }else{
                              MainDialog('업로드 오류', res.resultMessage);
                            }
                          },
                          child: Text(
                            '예약취소',
                            style: TextStyle(
                              color: Colors.white,
                              letterSpacing: 1.5,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'OpenSans',
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: MainColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12), // <-- Radius
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ):
                (widget.reState == '예약확정')?
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 50.0,
                        padding: EdgeInsets.fromLTRB(25,0,25,0),
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            Result res = await RestMgr().resCancle(widget.ReservNum,widget.guestNum,widget.MainCate);
                            if(res.resultCode == '0000') {
                              MainDialog('업로드 성공','예약 취소 되었습니다.');
                            }else{
                              MainDialog('업로드 오류', res.resultMessage);
                            }
                          },
                          child: Text(
                            '예약취소',
                            style: TextStyle(
                              color: Colors.white,
                              letterSpacing: 1.5,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'OpenSans',
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: MainColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12), // <-- Radius
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ):
                (widget.reState == '이용완료')?
                Container():
                Container(),
            Container(height: 10,)
          ],
        ),
      ),
      )
    );
  }

  String onedataToString(DateTime data){
    String strWeek = '월 ';
    if(data.weekday==0){
      strWeek = '일';
    }else if(data.weekday==1){
      strWeek = '월';
    }else if(data.weekday==2){
      strWeek = '화';
    }else if(data.weekday==3){
      strWeek = '수';
    }else if(data.weekday==4){
      strWeek = '목';
    }else if(data.weekday==5){
      strWeek = '금';
    }else if(data.weekday==6){
      strWeek = '토';
    }else if(data.weekday==7){
      strWeek = '일';
    }
    DateTime a = DateTime.now();
    if(a.year == data.year){
      return data.month.toString() + '월 ' +
          data.day.toString() + '일 (' + strWeek + ')';
    }else {
      return data.year.toString() + '년 ' + data.month.toString() + '월 ' +
          data.day.toString() + '일 (' + strWeek + ')';
    }
  }

  String onedataontimeToString(String data) {
    bool bo = false;
    DateTime Ddate = DateTime.now();

    try {
      Ddate = DateFormat("yyyy-mm-dd HH:mm:ss").parse(data);
      bo = true;
    } catch (FormatException) {
      Ddate = DateFormat("yyyy-mm-dd").parse(data);
      bo = false;
    }
    String strWeek = '월 ';
    if (Ddate.weekday == 0) {
      strWeek = '일';
    } else if (Ddate.weekday == 1) {
      strWeek = '월';
    } else if (Ddate.weekday == 2) {
      strWeek = '화';
    } else if (Ddate.weekday == 3) {
      strWeek = '수';
    } else if (Ddate.weekday == 4) {
      strWeek = '목';
    } else if (Ddate.weekday == 5) {
      strWeek = '금';
    } else if (Ddate.weekday == 6) {
      strWeek = '토';
    } else if (Ddate.weekday == 7) {
      strWeek = '일';
    }

    DateTime a = DateTime.now();

    var f1 = DateFormat('yyyy년 MM월 dd일');
    var f2 = DateFormat('MM월 dd일');
    var f3 = DateFormat('a hh시mm분');

    if (a.year == Ddate.year) {
      if (bo) {
        String DTime = f3.format(Ddate).replaceAll('PM', '오후');
        DTime = DTime.replaceAll('AM', '오전');
        return f2.format(Ddate) + '(' + strWeek + ') ' + DTime;
      } else {
        return f2.format(Ddate) + '(' + strWeek + ')';
      }
    } else {
      if (bo) {
        String DTime = f3.format(Ddate).replaceAll('PM', '오후');
        DTime = f3.format(Ddate).replaceAll('AM', '오전');
        return f1.format(Ddate) + '(' + strWeek + ') ' + DTime;
      } else {
        return f1.format(Ddate) + '(' + strWeek + ')';
      }
    }
  }
  void MainDialog(String title, String cont) {
    showDialog(
        context: context,
        barrierDismissible: false, // 바깥 영역 터치시 닫을지 여부
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(cont),
                ],
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                child: Text('확인'),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.pop(context,true);
                },
              ),
            ],
          );
        }
      );
  }
}
