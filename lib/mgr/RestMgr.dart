import 'dart:convert';
import 'package:danawa_store2/bean/Result.dart';
import 'package:http/http.dart' as http;

class RestMgr{

  // 예약 정보 불러오기
  Future<List<Map<String, dynamic>>> getCouponList(String StartDay,String FinishDay,String BizNo) async {
    Map<String, String> map = <String, String>{"StartDay": StartDay};
    map["FinishDay"] = FinishDay;
    map["BizNo"] = BizNo;
    String url = 'https://outsider21.cafe24.com/tour_app/store/coupon_detail_select.php';
    http.Response response = await http.post(
        Uri.parse(url),
        body: map
    );
    var parsed = json.decode(response.body).cast<Map<String, dynamic>>();
    return parsed.toList();
  }

  Future<List<Map<String, dynamic>>> setReservationSelect(String BizNo,String condition,String StartDay,String FinishDay,) async {
    Map<String, String> map = <String, String>{"BizNo": BizNo};
    map['condition'] = condition;
    map['StartDay'] = StartDay;
    map['FinishDay'] = FinishDay;
    String url = 'https://outsider21.cafe24.com/tour_app/store/reservation_select.php';
    http.Response response = await http.post(
        Uri.parse(url),
        body: map
    );
    print(response.body);
    var parsed = json.decode(response.body).cast<Map<String, dynamic>>();
    return parsed.toList();
  }

  Future<List<Map<String, dynamic>>> getResDate(String id) async {
    Map<String, String> map = <String, String>{"id": id};
    String url = 'https://outsider21.cafe24.com/tour_app/store/resDetail_select.php';
    http.Response response = await http.post(
        Uri.parse(url),
        body: map
    );
    print(response.body);
    var parsed = json.decode(response.body).cast<Map<String, dynamic>>();
    return parsed.toList();
  }

  Future<List<Map<String, dynamic>>> getResText(String text) async {
    Map<String, String> map = <String, String>{"text": text};
    String url = 'https://outsider21.cafe24.com/tour_app/store/resText_select.php';
    http.Response response = await http.post(
        Uri.parse(url),
        body: map
    );
    print(response.body);
    var parsed = json.decode(response.body).cast<Map<String, dynamic>>();
    return parsed.toList();
  }

  Future<Result> resConfirm(String id) async {
    Map<String, String> map = <String, String>{"id": id};
    String url = 'https://outsider21.cafe24.com/tour_app/store/res_confirm.php';
    http.Response response = await http.post(
        Uri.parse(url),
        body: map
    );
    print(response.body);
    Map<String, dynamic> Rmap = jsonDecode(response.body);
    Result res = Result.fromJson(Rmap);
    return res;
  }

  Future<Result> resCancle(String id,String guestNum,String MainCate) async {
    Map<String, String> map = <String, String>{"id": id};
    map['MainCate'] = MainCate;
    map['guestNum'] = guestNum;

    String url = 'https://outsider21.cafe24.com/tour_app/store/res_cancle.php';
    http.Response response = await http.post(
        Uri.parse(url),
        body: map
    );
    print(response.body);
    Map<String, dynamic> Rmap = jsonDecode(response.body);
    Result res = Result.fromJson(Rmap);
    return res;
  }
}