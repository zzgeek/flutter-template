class UserModel {
  UserModel({
    this.userStatus,
    this.userName,
    this.userRole,
    this.userId,
    this.userPwd,
    this.userToken,
  });

  int? userStatus;
  String? userName;
  String? userRole;
  int? userId;
  String? userPwd;
  String? userToken;

  factory UserModel.fromJson(Map<String,dynamic> json) => UserModel(
    userStatus: json["userStatus"],
    userName: json["userName"],
    userRole: json["userRole"],
    userId: json["userId"],
    userPwd: json["userPwd"],
    userToken: json["userToken"],
  );

  Map<String,dynamic> toJson() => {
    "userStatus":userStatus,
    "userName":userName,
    "userRole":userRole,
    "userId":userId,
    "userPwd":userPwd,
    "userToken":userToken,
  };

}