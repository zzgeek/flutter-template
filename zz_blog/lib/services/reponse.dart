class ResponseModel {
  ResponseModel({
    this.respCode,
    this.respMsg,
    this.respData,
  });

  dynamic respData;
  dynamic respMsg;
  dynamic respCode;

  factory ResponseModel.fromJson(Map<String,dynamic> json) => ResponseModel(
    respCode: json["code"],
    respMsg: json["message"],
    respData: json["respData"],
  );

  Map<String,dynamic> toJson() => {
    "code":respCode,
    "message":respMsg,
    "respData":respData,
  };

}