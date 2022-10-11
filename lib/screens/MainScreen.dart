import 'package:danawa_store2/mgr/RestMgr.dart';
import 'package:danawa_store2/screens/LoginScreen.dart';
import 'package:danawa_store2/screens/QRView.dart';
import 'package:danawa_store2/screens/ReservationScreen.dart';
import 'package:danawa_store2/screens/massageFinalScreen.dart';
import 'package:danawa_store2/util/content.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class MainScreen extends StatefulWidget {
  final BizNo;
  final storeType;
  final int pageIndex;
  Map<String, dynamic> storeList;

  MainScreen({
    Key? key,
    required this.BizNo,
    required this.pageIndex,
    required this.storeList,
    required this.storeType,
  }) : super(key: key);

  @override
  _MainScreen createState() => _MainScreen();
}


class _MainScreen extends State<MainScreen> with AutomaticKeepAliveClientMixin,SingleTickerProviderStateMixin{

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  TextStyle menuStyle = TextStyle(fontSize: 14, color: Colors.grey);
  TextStyle contentStyle = TextStyle(fontSize: 14);

  DateTime startDate = DateTime.now();
  DateTime finishDate = DateTime.now();
  late PickerDateRange Date;
  String StartDate = '';
  String FinishDate = '';
  late TabController _tabController;
  List<Map<String, dynamic>> coupon = [];
  List<Map<String, dynamic>> resList = [];

  DateTime startDate2 = DateTime.now();
  DateTime finishDate2 = DateTime.now();
  late PickerDateRange Date2;
  String StartDate2 = '';
  String FinishDate2 = '';
  String aline = '전체';

  late final TextEditingController _controller;
  late final FocusNode _focusNode;
  String _terms = '';

  Future<void> getToken() async {
    print("토큰 불러오기");
    final fcmToken = await FirebaseMessaging.instance.getToken();
    print(fcmToken);
  }

  @override
  void initState() {
    super.initState();
    Date = PickerDateRange(startDate, finishDate);
    _selectedIndexForBottomNavigationBar = widget.pageIndex;
    _tabController = TabController(length: 2, vsync: this);
    StartDate = new DateFormat("yyyy-MM-dd").format(startDate);
    FinishDate = new DateFormat("yyyy-MM-dd").format(finishDate);

    Date2 = PickerDateRange(startDate2, finishDate2);
    StartDate2 = new DateFormat("yyyy-MM-dd").format(startDate2);
    FinishDate2 = new DateFormat("yyyy-MM-dd").format(finishDate2);
    getCoupon();
    getReservationList();

    _controller = TextEditingController()..addListener(_onTextChanged);
    _focusNode = FocusNode();

    getToken();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    setState(() {
      _terms = _controller.text;
    });
  }

  void getCoupon() async {
    print(StartDate);
    print(FinishDate);
    print(widget.BizNo);
    coupon = await RestMgr().getCouponList(StartDate,FinishDate,widget.BizNo);
    setState(() {
    });
  }
  void getReservationList() async {
    print(widget.BizNo);
    resList = await RestMgr().setReservationSelect(widget.BizNo,aline,StartDate2,FinishDate2);
    setState(() {
    });
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      Date = args.value;
      StartDate = new DateFormat("yyyy-MM-dd").format(args.value.startDate);
      if(args.value.endDate != null) {
        FinishDate = new DateFormat("yyyy-MM-dd").format(args.value.endDate);
      }
    });
  }

  void _onSelectionChanged2(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      Date2 = args.value;
      StartDate2 = new DateFormat("yyyy-MM-dd").format(args.value.startDate);
      if(args.value.endDate != null) {
        FinishDate2 = new DateFormat("yyyy-MM-dd").format(args.value.endDate);
      }
    });
  }

  Future<void> _selectDate2(BuildContext context) async {
    showDialog(
        context: context,
        barrierDismissible: false, // 바깥 영역 터치시 닫을지 여부
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('날짜선택'),
            content:  Container(
              color: Colors.white,
              width: 250,
              height: 250,
              child: SfDateRangePicker(
                initialSelectedRange: Date2,
                onSelectionChanged: _onSelectionChanged2,
                selectionMode: DateRangePickerSelectionMode.range,
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                child: Text('확인'),
                onPressed: () {
                  Navigator.of(context).pop();
                  getReservationList();
                  setState((){
                  });
                  },
              ),
            ],
          );
        });
  }

  Future<void> _selectDate(BuildContext context) async {
    showDialog(
        context: context,
        barrierDismissible: false, // 바깥 영역 터치시 닫을지 여부
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('날짜선택'),
            content:  Container(
              color: Colors.white,
              width: 250,
              height: 250,
              child: SfDateRangePicker(
                  initialSelectedRange: Date,
                  onSelectionChanged: _onSelectionChanged,
                  selectionMode: DateRangePickerSelectionMode.range,
                ),
            ),
            actions: <Widget>[
              ElevatedButton(
                child: Text('확인'),
                onPressed: () {
                  getCoupon();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  int _selectedIndexForBottomNavigationBar = 0;
  void _onItemTappedForBottomNavigationBar(int index,) {
    // if(index == 0) {
    //   Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
    //       builder: (BuildContext context) =>
    //           MainScreen(BizNo: widget.BizNo,pageIndex: 0,storeList: widget.storeList,storeType: widget.storeType,)), (route) => false);
    // }else
      if(index == 1){
      Navigator.push(context, MaterialPageRoute(builder: (context) => ReadQR(BizNo: widget.BizNo,storeList: widget.storeList,storeType: widget.storeType,)));
    }
  }

  Future logout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove('BizNo');
    preferences.remove('storeList');
    preferences.remove('storeType');
    Navigator.pushAndRemoveUntil(
        context, MaterialPageRoute(builder: (context) => LoginScreen()),(route)=>false);
  }

  @override
  Widget build(BuildContext context) {
    final tabs = [
      Tab(
        text: "쿠폰내역관리",
      ),
      Tab(
        text: "예약내역",
      ),
    ];
    return Scaffold(
        backgroundColor: BackGroundColor,
        body: Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(onPressed: (){logout();}, icon: Icon(Icons.logout))
            ],
            title: Text(widget.storeList['BizNameKr']),
            bottom: TabBar(
//          isScrollable: true,
              tabs: tabs,
              controller: _tabController,
              unselectedLabelColor: Colors.white,
              indicatorColor: Colors.blue,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorWeight: 2,
              indicatorPadding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 8),
              labelColor: Colors.white,
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: [
              TabBar1(),
              TabBar2(),
            ]),),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          onTap: _onItemTappedForBottomNavigationBar,
          selectedItemColor: Colors.black87,
          backgroundColor: Colors.white,
          items: [
            BottomNavigationBarItem(icon: new Icon(Icons.home), label: '홈'),
            BottomNavigationBarItem(icon: new Icon(Icons.qr_code), label: 'QR스캔')
          ],
          currentIndex: _selectedIndexForBottomNavigationBar,
        )
    );
  }

  Widget TabBar1(){
    return Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('날짜 검색'),
                      Spacer(),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          border: Border.all(width: 1, color: Colors.grey),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  InkWell(
                                    child: Text(
                                        StartDate,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: Color(0xFF000000))
                                    ),
                                    onTap: (){
                                      _selectDate(context);
                                    },
                                  ),
                                  Ink(
                                    child: IconButton(
                                      icon: Icon(Icons.calendar_today,size: 15),
                                      padding: EdgeInsets.zero,
                                      constraints: BoxConstraints(),
                                      tooltip: 'Tap to open date picker',
                                      onPressed: () {
                                        _selectDate(context);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            addHorizontalSpace(5),
                            Text('-'),
                            addHorizontalSpace(5),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  InkWell(
                                    child: Text(
                                        FinishDate,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: Color(0xFF000000))
                                    ),
                                    onTap: (){
                                      _selectDate(context);
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.calendar_today,size: 15,),
                                    padding: EdgeInsets.zero,
                                    constraints: BoxConstraints(),
                                    tooltip: 'Tap to open date picker',
                                    onPressed: () {
                                      _selectDate(context);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(height: 1),
                Expanded(
                    child: (coupon.isEmpty)?
                    Center(child: CircularProgressIndicator()):
                    (coupon[0]['resultCode']!=null)?
                    Center(child: Text('검색 결과가 없습니다.')):
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Row(
                            children: [
                              Text('쿠폰 사용량'),
                              Spacer(),
                              Text('${coupon.length}건')
                            ],
                          ),
                        ),
                        ListView.separated(
                          shrinkWrap: true,
                          primary: false,
                          separatorBuilder: (context, index) {
                            return Divider();
                          },
                          itemCount: coupon.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(coupon[index]['guestName']),
                              subtitle: Text(coupon[index]['CouponDateTime'],
                                style: TextStyle(fontSize: 14,color: Colors.grey),),
                            );
                        },),
                      ],
                    )

                ),

              ],
            )
        );
  }
  Widget TabBar2(){
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            addVerticalSpace(5),
            SearchBar(controller: _controller,
                focusNode: _focusNode,
                Fun: (val) async {
                 resList = await RestMgr().getResText(val);
                 setState((){
                 });
                }),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 0,horizontal: 2),
                    child: ElevatedButton(
                        onPressed: () {
                          alinePopup();
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.transparent,
                      elevation: 0,
                      side: BorderSide(
                        color: Colors.grey, //枠線!
                        width: 1, //枠線！
                      ),
                    ),
                        child:Text('${aline} ▾ ',style: TextStyle(color: Colors.black, fontSize: 15),)
                    ),
                  ),
                  Spacer(),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      border: Border.all(width: 1, color: Colors.grey),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              InkWell(
                                child: Text(
                                    StartDate2,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Color(0xFF000000))
                                ),
                                onTap: (){
                                  _selectDate2(context);
                                },
                              ),
                              Ink(
                                child: IconButton(
                                  icon: Icon(Icons.calendar_today,size: 15),
                                  padding: EdgeInsets.zero,
                                  constraints: BoxConstraints(),
                                  tooltip: 'Tap to open date picker',
                                  onPressed: () {
                                    _selectDate2(context);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        addHorizontalSpace(5),
                        Text('-'),
                        addHorizontalSpace(5),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              InkWell(
                                child: Text(
                                    FinishDate2,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Color(0xFF000000))
                                ),
                                onTap: (){
                                  _selectDate2(context);
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.calendar_today,size: 15,),
                                padding: EdgeInsets.zero,
                                constraints: BoxConstraints(),
                                tooltip: 'Tap to open date picker',
                                onPressed: () {
                                  _selectDate2(context);
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Divider(height: 1),
            Expanded(
              child: (resList.isEmpty)?
              Center(child: CircularProgressIndicator()):
              (resList[0]['resultCode']!=null)?
              Center(child: Text('검색 결과가 없습니다.')):
              ListView.builder(
                itemCount: resList.length,
                itemBuilder: (context, index) {
                  dynamic mas = resList[index];
                  return GestureDetector(
                    onTap: () async {
                      List<Map<String, dynamic>> a = await RestMgr().getResDate(mas['id']);
                      List<String> titleList = a[0]['titleList'].split('|');
                      List<int> countList = a[0]['countList'].split('|').map<int>((String item) => int.parse(item)).toList();
                      DateTime maDate = DateFormat('yyyy-mm-dd').parse(a[0]['maDate']);
                      TimeOfDay maTime = TimeOfDay(hour:int.parse(a[0]['maTime'].split(":")[0]),minute: int.parse(a[0]['maTime'].split(":")[1]));
                        bool? received = await Navigator.push(context,
                           MaterialPageRoute(builder: (context) =>
                               massageFinalScreen(
                                 ReservNum : a[0]['id'],
                                 ReservDay: a[0]['ReservDay'],
                                 guestNum: a[0]['guestNum'],
                                 MainCate: a[0]['MainCate'],
                                 reState: mas['reState'],
                                 total: int.parse(a[0]['total']),
                                 totalD: int.parse(a[0]['totalD']),
                                 maPerson: int.parse(a[0]['maPerson']),
                                 maTotalPerson: int.parse(a[0]['maTotalPerson']),
                                 titleList: titleList,
                                 countList: countList,
                                 uNameK: a[0]['uNameK'],
                                 uNameE: a[0]['uNameE'],
                                 uPhone: a[0]['uPhone'],
                                 uKakao: a[0]['uKakao'],
                                 uRequest: a[0]['uRequest'],
                                 maDate: maDate,
                                 maTime: maTime,
                               )
                           )
                       );
                      setState((){
                        if(received != null) {
                          if (received == true) {
                            resList.clear();
                            getReservationList();
                          }
                        }
                      });
                    },
                    child: Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.grey, width: 0.5),
                        // borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              color:
                              (mas['reState'] == '입금대기')?
                              Colors.green.withOpacity(0.05):
                              (mas['reState'] == '예약확정')?
                              Colors.blue.withOpacity(0.05):
                              (mas['reState'] == '이용완료')?
                              Colors.red.withOpacity(0.05):
                              Colors.grey.withOpacity(0.05),

                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                  child: Text(mas['reState'], style:
                                      (mas['reState'] == '입금대기')?
                                        TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green):
                                      (mas['reState'] == '예약확정')?
                                      TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue):
                                      (mas['reState'] == '이용완료')?
                                      TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red):
                                      TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey)
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                  child: Text(mas['id'], style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue),),
                                )
                              ],
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                  child: Container(
                                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    height: 80,
                                    child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          addVerticalSpace(5),
                                          Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Text('일정', style: menuStyle,),
                                                addHorizontalSpace(10),
                                                Expanded(
                                                  child: Text(
                                                    onedataontimeToString(mas['reDate']),
                                                    style: contentStyle,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ]
                                          ),
                                          addVerticalSpace(5),
                                          Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text('인원', style: menuStyle,),
                                                addHorizontalSpace(10),
                                                Expanded(
                                                  child: Text(
                                                    mas['rePerson'] + '명',
                                                    style: contentStyle,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ]
                                          ),
                                          addVerticalSpace(5),
                                          Row(crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text('예약', style: menuStyle,),
                                                addHorizontalSpace(10),
                                                Expanded(
                                                  child: Text(
                                                    mas['reLocation'],
                                                    style: contentStyle,
                                                    overflow: TextOverflow.ellipsis,
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
                }
              )
            ),
          ],
        )
    );
  }

  String onedataontimeToString(String data) {
    bool bo = false;
    DateTime Ddate = DateTime.now();

    try {
      Ddate = DateFormat("yyyy-MM-dd HH:mm:ss").parse(data);
      bo = true;
    } catch (FormatException) {
      Ddate = DateFormat("yyyy-MM-dd").parse(data);
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

  void alinePopup(){
    showModalBottomSheet<void>(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10)),
        ),
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return FractionallySizedBox(
            // heightFactor: 0.2,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      '정렬',
                      style: TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(color: Colors.grey, height: 1),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 10.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                            title: Transform.translate(
                                offset: Offset(-16, 0),
                                child:Text("전체 (날짜 검색 동시에 가능)",
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.justify,
                                    maxLines: 1,
                                    style: TextStyle())),
                            onTap: () {
                              aline = '전체';
                              Navigator.pop(context);
                              getReservationList();
                            }),
                        ListTile(
                            title: Transform.translate(
                                offset: Offset(-16, 0),
                                child:Text("입금대기",
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.justify,
                                    maxLines: 1,
                                    style: TextStyle())),
                            onTap: () {
                              setState(() {
                                aline = '입금대기';
                                Navigator.pop(context);
                                getReservationList();
                              });
                            }),
                        ListTile(
                            title: Transform.translate(
                                offset: Offset(-16, 0),
                                child:Text("예약확정",
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.justify,
                                    maxLines: 1,
                                    style: TextStyle())),
                            onTap: () {
                              aline = '예약확정';
                              Navigator.pop(context);
                              getReservationList();
                            }),
                        ListTile(
                            title: Transform.translate(
                                offset: Offset(-16, 0),
                                child:Text("이용완료",
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.justify,
                                    maxLines: 1,
                                    style: TextStyle())),
                            onTap: () {
                              aline = '이용완료';
                              Navigator.pop(context);
                              getReservationList();
                            }),
                        ListTile(
                            title: Transform.translate(
                                offset: Offset(-16, 0),
                                child:Text("예약취소",
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.justify,
                                    maxLines: 1,
                                    style: TextStyle())),
                            onTap: () {
                              aline = '예약취소';
                              Navigator.pop(context);
                              getReservationList();
                            }),
                      ],
                    ),
                  ),
                ],
              ));
        });
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({
    required this.controller,
    required this.focusNode,
    required this.Fun,
    Key? key,
  }) : super(key: key);

  final TextEditingController controller;
  final FocusNode focusNode;
  final Function(String) Fun;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 4,
          vertical: 8,
        ),
        child: Row(
          children: [
            const Icon(
              CupertinoIcons.search,
              color: Colors.grey,
            ),
            Expanded(
              child: CupertinoTextField(
                controller: controller,
                focusNode: focusNode,
                textInputAction: TextInputAction.done,
                onSubmitted: Fun,
                // style: Styles.searchText,
                // cursorColor: Styles.searchCursorColor,
                placeholder: '예약 번호 / 예약이름 / 전화번호 / 카카오',
                decoration: null,
              ),
            ),
            GestureDetector(
              onTap: controller.clear,
              child: const Icon(
                CupertinoIcons.clear_thick_circled,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}