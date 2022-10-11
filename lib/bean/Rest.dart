class Rest {
  var BizNo;
  var Area;
  var MainCate;
  var SubCate;
  var BizNameKr;
  var BizNameFo;
  var BizMainUrl;
  var TelNo;
  var AddrKr;
  var AddrFo;
  var AddrDetail;
  var BizIntra;
  var BizHomepage;
  var Recom1;
  var Recom2;
  var BizCate1;
  var BizCate2;
  var BizCate3;
  var OpenStart;
  var OpenFinish;
  var ReserStart;
  var ReserFinish;
  var DeliveryYN;
  var DeliveryMinAmt;
  var DeliveryPaymOpt;
  var DeliveryCharge;
  var IntroTitle;
  var IntroContent;
  var IntroUrl;
  var BizRemk1;
  var BizRemk2;
  var BizRemk3;
  var BizRemk4;
  var BizRemk5;
  var BizRemk6;
  var Holiday;
  var Represent;
  var RegistrationNo;
  var Email;
  var KakaoT;
  var Onjoin;
  var resultCode;
  var resultMessage;
  var MenuPrice;
  var MenuDisPrice;
  var favo;
  var favoCount;
  var fdRate;
  var fdCount;
  var branch;
  var lon;
  var lat;
  var Coupon;
  var TimeLimit1;
  var TimeLimit2;
  var PickUp;
  var Tip;

  Rest({this.BizNo,this.Area,this.MainCate,this.SubCate,this.BizNameKr,this.BizNameFo,this.BizMainUrl,
        this.TelNo,this.AddrKr,this.AddrFo,this.AddrDetail,this.BizIntra,this.BizHomepage,this.Recom1,this.Recom2,
        this.BizCate1,this.BizCate2,this.BizCate3,this.OpenStart,this.OpenFinish,this.ReserStart,this.ReserFinish,
        this.DeliveryYN,this.DeliveryMinAmt,this.DeliveryPaymOpt,this.DeliveryCharge,
        this.IntroTitle,this.IntroContent,this.IntroUrl,this.BizRemk1,this.BizRemk2,this.BizRemk3,
        this.BizRemk4,this.BizRemk5,this.BizRemk6,this.Holiday,this.Represent,this.RegistrationNo,
        this.Email,this.KakaoT,this.Onjoin,this.resultCode,this.resultMessage,this.branch,
        this.MenuPrice,this.MenuDisPrice,this.favo,this.favoCount,this.fdRate,this.fdCount,
        this.lon,this.lat,this.Coupon,this.TimeLimit1,this.TimeLimit2,this.PickUp,this.Tip});

  Map<String, dynamic> toMap(){
    Map<String, dynamic> map = {};
    map['BizNo'] = this.BizNo;
    map['Area'] = this.Area;
    map['MainCate'] = this.MainCate;
    map['SubCate'] = this.SubCate;
    map['BizNameKr'] = this.BizNameKr;
    map['BizNameFo'] = this.BizNameFo;
    map['BizMainUrl'] = this.BizMainUrl;
    map['TelNo'] = this.TelNo;
    map['AddrKr'] = this.AddrKr;
    map['AddrFo'] = this.AddrFo;
    map['AddrDetail'] = this.AddrDetail;
    map['BizIntra'] = this.BizIntra;
    map['BizHomepage'] = this.BizHomepage;
    map['Recom1'] = this.Recom1;
    map['Recom2'] = this.Recom2;
    map['BizCate1'] = this.BizCate1;
    map['BizCate2'] = this.BizCate2;
    map['BizCate3'] = this.BizCate3;
    map['OpenStart'] = this.OpenStart;
    map['OpenFinish'] = this.OpenFinish;
    map['ReserStart'] = this.ReserStart;
    map['ReserFinish'] = this.ReserFinish;
    map['DeliveryYN'] = this.DeliveryYN;
    map['DeliveryMinAmt'] = this.DeliveryMinAmt;
    map['DeliveryPaymOpt'] = this.DeliveryPaymOpt;
    map['DeliveryCharge'] = this.DeliveryCharge;
    map['IntroTitle'] = this.IntroTitle;
    map['IntroContent'] = this.IntroContent;
    map['IntroUrl'] = this.IntroUrl;
    map['BizRemk1'] = this.BizRemk1;
    map['BizRemk2'] = this.BizRemk2;
    map['BizRemk3'] = this.BizRemk3;
    map['BizRemk4'] = this.BizRemk4;
    map['BizRemk5'] = this.BizRemk5;
    map['BizRemk6'] = this.BizRemk6;
    map['Holiday'] = this.Holiday;
    map['Represent'] = this.Represent;
    map['RegistrationNo'] = this.RegistrationNo;
    map['Email'] = this.Email;
    map['KakaoT'] = this.KakaoT;
    map['Onjoin'] = this.Onjoin;
    map['resultCode'] = this.resultCode;
    map['resultMessage'] = this.resultMessage;
    map['MenuPrice'] = this.MenuPrice;
    map['MenuDisPrice'] = this.MenuDisPrice;
    map['favo'] = this.favo;
    map['favoCount'] = this.favoCount;
    map['fdRate'] = this.fdRate;
    map['fdCount'] = this.fdCount;
    map['branch'] = this.branch;
    map['lon'] = this.lon;
    map['lat'] = this.lat;
    map['Coupon'] = this.Coupon;
    return map;
  }

  factory Rest.fromJson(Map<String, dynamic> json) {
    return Rest(
        BizNo: json['BizNo'],
        Area : json['Area'],
        MainCate: json['MainCate'],
        SubCate: json['SubCate'],
        BizNameKr: json['BizNameKr'],
        BizNameFo: json['BizNameFo'],
        BizMainUrl: json['BizMainUrl'],
        TelNo: json['TelNo'],
        AddrKr: json['AddrKr'],
        AddrFo: json['AddrFo'],
        AddrDetail: json['AddrDetail'],
        BizIntra: json['BizIntra'],
        BizHomepage: json['BizHomepage'],
        Recom1: json['Recom1'],
        Recom2: json['Recom2'],
        BizCate1: json['BizCate1'],
        BizCate2: json['BizCate2'],
        BizCate3: json['BizCate3'],
        OpenStart: json['OpenStart'],
        OpenFinish: json['OpenFinish'],
        ReserStart: json['ReserStart'],
        ReserFinish: json['ReserFinish'],
        DeliveryYN: json['DeliveryYN'],
        DeliveryMinAmt: json['DeliveryMinAmt'],
        DeliveryPaymOpt: json['DeliveryPaymOpt'],
        DeliveryCharge: json['DeliveryCharge'],
        IntroTitle: json['IntroTitle'],
        IntroContent: json['IntroContent'],
        IntroUrl: json['IntroUrl'],
        BizRemk1: json['BizRemk1'],
        BizRemk2: json['BizRemk2'],
        BizRemk3: json['BizRemk3'],
        BizRemk4: json['BizRemk4'],
        BizRemk5: json['BizRemk5'],
        BizRemk6: json['BizRemk6'],
        Holiday: json['Holiday'],
        Represent: json['Represent'],
        RegistrationNo: json['RegistrationNo'],
        Email: json['Email'],
        KakaoT: json['KakaoT'],
        Onjoin: json['Onjoin'],
        resultCode: json['resultCode'],
        resultMessage: json['resultMessage'],
        favo : json['favo'],
        favoCount : json['favoCount'],
        fdRate : json['fdRate'],
        fdCount : json['fdCount'],
        branch : json['branch'],
        lon : json['lon'],
        lat : json['lat'],
        Coupon : json['Coupon'],
      PickUp : json['PickUp'],
      Tip : json['Tip'],
      TimeLimit1 : json['TimeLimit1'],
        TimeLimit2 : json['TimeLimit2'],
    );
  }
}