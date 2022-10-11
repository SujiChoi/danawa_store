import 'package:danawa_store2/mgr/RestMgr.dart';
import 'package:danawa_store2/util/content.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReservationScreen extends StatefulWidget {
  final BizNo;

  ReservationScreen({Key? key,
    required this.BizNo,})
      : super(key: key);

  @override
  _ReservationScreen createState() => _ReservationScreen();
}

class _ReservationScreen extends State<ReservationScreen>{

  dynamic resList;

  Future getReservationList() async {
    setState(() {
      resList = RestMgr().setReservationSelect(widget.BizNo,'전체','','');
    });
  }

  @override
  void initState() {
    super.initState();
    getReservationList();
  }

  @override
  Widget build(BuildContext context) {
    //6
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: RefreshIndicator(
                  onRefresh: () async {
                    await Future.delayed(Duration(seconds: 1));
                    getReservationList();
                  },
                  color: Colors.purple,
                  child : ReservationList(
                      Info: resList,
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class ReservationList extends StatefulWidget {
  final Info;

  ReservationList({
    Key? key,
    required this.Info,
  }) : super(key: key);

  @override
  _ReservationList createState() => _ReservationList();
}

class _ReservationList extends State<ReservationList> {
  TextStyle menuStyle = TextStyle(fontSize: 14, color: Colors.grey);
  TextStyle contentStyle = TextStyle(fontSize: 14);


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: widget.Info,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Divider(
                  height: 1,
                  color: Colors.black26,
                ),
                Spacer(),
                Center(child: CircularProgressIndicator()),
                Spacer(),
              ],
            );
          }
          dynamic Maininfo = snapshot.data[0];
          if (Maininfo['resultCode'] != null) {
            return Center(
              child: new ListView(
                  shrinkWrap: true,
                  children: [
                    Center(child: new Text('검색 결과가 없습니다.'))
                  ]
              ),
            );
          } else
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  dynamic mas = snapshot.data[index];
                  return GestureDetector(
                    onTap: () async {
                      // if (widget.GuestState == '호텔') {
                      //   Accom accom = Accom.fromJson(mas);
                      //   dynamic result = await Navigator.push(context, MaterialPageRoute(
                      //       builder: (context) => HotelDetailScreen(
                      //         accom: accom,
                      //         child: 0,
                      //         adult: 2,
                      //         s: DateTime.now(),
                      //         e: DateTime.now().add(Duration(days: 2)),
                      //         guestNum: widget.guestNum,
                      //       )));
                      //   print(result);
                      //   setState(() {
                      //     mas['favo'] = result;
                      //   });
                      // } else if (widget.GuestState == '식당') {
                      //   print('식당');
                      // } else if (widget.GuestState == '마사지') {
                      //   print('마사지');
                      // } else if (widget.GuestState == '네일') {
                      //   print('네일');
                      // } else if (widget.GuestState == '이발') {
                      //   print('이발');
                      // } else if (widget.GuestState == '투어') {
                      //   print('투어');
                      // }

                    },
                    child: Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.grey, width: 0.5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(5),
                                  topLeft: Radius.circular(5)),
                              color: Colors.white,
                              // image: DecorationImage(
                              //     fit: BoxFit.cover,
                              //     image: (widget.ImagePath + mas['BizMainUrl']))
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  // decoration: BoxDecoration(
                                  //         border: Border.all(
                                  //             color: Colors.redAccent,width: 1)),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  child: Text(mas['reMenu'], style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black),),
                                ),
                                Spacer(),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  child: Text(mas['reState'], style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green),),
                                )
                              ],
                            ),
                          ),
                          Container(height: 0.5, color: Colors.grey,),
                          Row(
                            children: <Widget>[
                              Container(
                                height: 120.0,
                                width: 100.0,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(5)),
                                    color: Colors.blue,
                                    image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: AssetImage(
                                        'assets/logos/danang.jpg',
                                      ),
                                    )
                                  // image: DecorationImage(
                                  //     fit: BoxFit.cover,
                                  //     image: (widget.ImagePath + mas['BizMainUrl']))
                                ),
                              ),
                              Expanded(
                                  child: Container(
                                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    height: 110,
                                    child: Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        mainAxisAlignment: MainAxisAlignment
                                            .start,
                                        children: [
                                          addVerticalSpace(5),
                                          Container(
                                            padding: EdgeInsets.fromLTRB(
                                                0, 2, 0, 2),
                                            child: Text(
                                              mas['reTitle'],
                                              style: TextStyle(fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black87),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          addVerticalSpace(5),
                                          Row(
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .center,
                                              mainAxisAlignment: MainAxisAlignment
                                                  .start,
                                              children: [
                                                Text(
                                                  '일정',
                                                  style: menuStyle,
                                                ),
                                                addHorizontalSpace(10),
                                                Expanded(
                                                  child: Text(
                                                    onedataontimeToString(
                                                        mas['reDate']),
                                                    style: contentStyle,
                                                    overflow: TextOverflow
                                                        .ellipsis,
                                                  ),
                                                ),
                                              ]
                                          ),
                                          addVerticalSpace(5),
                                          Row(
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .center,
                                              mainAxisAlignment: MainAxisAlignment
                                                  .start,
                                              children: [
                                                Text(
                                                  '인원',
                                                  style: menuStyle,
                                                ),
                                                addHorizontalSpace(10),
                                                Expanded(
                                                  child: Text(
                                                    mas['rePerson'] + '명',
                                                    style: contentStyle,
                                                    overflow: TextOverflow
                                                        .ellipsis,
                                                  ),
                                                ),
                                              ]
                                          ),
                                          addVerticalSpace(5),
                                          Row(
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .center,
                                              mainAxisAlignment: MainAxisAlignment
                                                  .start,
                                              children: [
                                                Text(
                                                  '장소',
                                                  style: menuStyle,
                                                ),
                                                addHorizontalSpace(10),
                                                Expanded(
                                                  child: Text(
                                                    mas['reLocation'],
                                                    style: contentStyle,
                                                    overflow: TextOverflow
                                                        .ellipsis,
                                                  ),
                                                ),
                                              ]
                                          )
                                        ]),
                                  )),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                });
        });
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
}

