import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common/themes/theme.dart';
import '../../router/app_routes.dart';
import 'login_controller.dart';

class LoginPage extends GetView<LoginController> {
  final controller = Get.put(LoginController());

  final Widget _loginTitle = Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      PopupMenuButton(
        icon: Icon(Icons.widgets_outlined),
        itemBuilder: (BuildContext context) {
          return[
            PopupMenuItem(child: Container(constraints: BoxConstraints(minHeight: 52, minWidth: double.infinity,),decoration: BoxDecoration(color: Colors.yellow),),value: Themes.yellow,),
            PopupMenuItem(child: Container(constraints: BoxConstraints(minHeight: 52, minWidth: double.infinity,),decoration: BoxDecoration(color: Colors.red),),value: Themes.red,),
            PopupMenuItem(child: Container(constraints: BoxConstraints(minHeight: 52, minWidth: double.infinity,),decoration: BoxDecoration(color: Colors.black),),value: Themes.black,),
            PopupMenuItem(child: Container(constraints: BoxConstraints(minHeight: 52, minWidth: double.infinity,),decoration: BoxDecoration(color: Color.fromRGBO(45, 58, 75, 1)),),value: Themes.white,),
            PopupMenuItem(child: Container(constraints: BoxConstraints(minHeight: 52, minWidth: double.infinity,),decoration: BoxDecoration(color: Colors.green),),value: Themes.green,),
          ];
        },
        onSelected: (object) {
          if (object == Themes.yellow){
            Get.changeTheme(Themes.yellow);
          }else if (object == Themes.red){
            Get.changeTheme(Themes.red);
          }else if (object == Themes.black){
            Get.changeTheme(ThemeData.dark());
          }else if (object == Themes.white){
            Get.changeTheme(Themes.white);
          }else {
            Get.changeTheme(Themes.green);
          }
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(
            width: 3,
            color: Colors.black,
            style: BorderStyle.solid,
          ),
        ),
      ),
      Text(
        'title'.tr,
        softWrap: true,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 30,
        ),
      ),
      PopupMenuButton(
        icon: Icon(Icons.translate),
        itemBuilder: (BuildContext context) {
          return[
            PopupMenuItem(child: Text('langZh'.tr),value: 'zh-Cn',),
            PopupMenuItem(child: Text('langEn'.tr),value: 'en-Us',),
          ];
        },
        onSelected: (object) {
          if (object == 'zh-Cn'){
            Get.updateLocale(Locale('zh_Cn'));
          }else {
            Get.updateLocale(Locale('en_Us'));
          }
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(
            width: 3,
            color: Colors.black,
            style: BorderStyle.solid,
          ),
        ),
      )
    ],
  );


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          constraints: BoxConstraints.loose(const Size(500, 500)),
          alignment: Alignment.topCenter,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _loginTitle,
              SizedBox(height: 20,),
              Obx(() =>Container(
                decoration: ShapeDecoration(shape: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5)),borderSide: BorderSide(color: Colors.blue)),),
                child: TextField(
                  onChanged: (value)=> controller.verifyUserName(value),
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(icon: const Icon(Icons.person) ,hintText: 'userName'.tr,border: InputBorder.none,errorText: controller.regUserName.value ? '' : 'userNameFormatError'.tr),
                  controller: controller.adminNameController,
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Obx(() =>Container(
                decoration: ShapeDecoration(shape: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5)),borderSide: BorderSide(color: Colors.blue)),),
                child: TextField(
                  onChanged: (value) => controller.verifyUserPwd(value),
                  obscureText: controller.eyeState.value,
                  textAlign: TextAlign.left,
                  controller: controller.adminPwdController,
                  decoration: InputDecoration(
                    icon: const Icon(Icons.lock),
                    hintText: 'userPassword'.tr,
                    border: InputBorder.none,
                    errorText: controller.regUserPwd.value ? '' : 'userPasswordFormatError'.tr,
                    suffixIcon:  IconButton(
                      icon: controller.eyeState.value ? Icon(Icons.remove_red_eye_outlined) : Icon(Icons.remove_red_eye),
                      onPressed: ()=>controller.changeEye(),),),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Container(
                alignment: Alignment.center,
                decoration: ShapeDecoration(color: Colors.blue,shape: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5)),borderSide: BorderSide(color: Colors.blue)),),
                child: TextButton(
                    child: Text('singIn'.tr,style: TextStyle(color: Colors.white),),
                    onPressed: () => controller.mockLogin(),
                ),
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text('userNameHint'.tr),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text('userPasswordHint'.tr),
                        ),
                      ],
                    ),
                  ),
                  Container(
                      decoration: ShapeDecoration(color: Colors.blue,shape: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5)),borderSide: BorderSide(color: Colors.blue)),),
                      child: TextButton(
                        child: Text('otherLogin'.tr,style: TextStyle(color: Colors.white),),
                        onPressed: () => controller.mockGoLogin(),
                      )
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
