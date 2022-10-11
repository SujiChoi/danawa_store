class Result {
  var resultCode;
  var resultMessage;
  var resultEn;
  var resultVt;


  Result({this.resultCode,this.resultMessage,this.resultEn,this.resultVt});

  Map<String, dynamic> toMap(){
    Map<String, dynamic> map = {};
    map['resultCode'] = this.resultCode;
    map['resultMessage'] = this.resultMessage;
    map['resultEn'] = this.resultEn;
    map['resultVt'] = this.resultVt;
    return map;
  }

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      resultCode: json['resultCode'],
      resultMessage: json['resultMessage'],
      resultEn: json['resultEn'],
      resultVt: json['resultVt'],
    );
  }
}