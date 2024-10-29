import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:com.zat.linedup/API/api_response.dart';
import 'package:com.zat.linedup/Components/BackButtonWidget/BackButtonWidget.dart';
import 'package:com.zat.linedup/Components/CustomAppButton/CustomAppButton.dart';
import 'package:com.zat.linedup/Components/CustomOutlineTextField/CustomOutlineTextField.dart';
import 'package:com.zat.linedup/Components/Extentions/PaddingExtentions.dart';
import 'package:com.zat.linedup/Components/ScaffoldMessageWidget/ScaffoldMessageWidget.dart';
import 'package:com.zat.linedup/Components/StaticTextStyle/StaticTextStyle.dart';
import 'package:com.zat.linedup/Controllers/HelpService/HelpService.dart';
import 'package:com.zat.linedup/Models/HelpResponseModel/HelpResponseModel.dart';
import 'package:com.zat.linedup/Utils/Constants/ColorConstants/ColorConstants.dart';

class HelpAndSupportPage extends StatefulWidget {
  const HelpAndSupportPage({super.key});

  @override
  State<HelpAndSupportPage> createState() => _HelpAndSupportPageState();
}

class _HelpAndSupportPageState extends State<HelpAndSupportPage> {
  final GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.only(top: PaddingExtensions.screenTopPadding,left: 22.sp,right: 22.sp),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BackButtonWidget(
                  icon: Icons.arrow_back_ios,
                  iconSize: 15.sp,
                  onPress: (){
                    Navigator.pop(context);
                  },
                ),
                Padding(
                  padding:  EdgeInsets.symmetric(vertical: 15.sp),
                  child: Text(
                    "Send Support\nRequest",
                    style: StaticTextStyle().boldTextStyle.copyWith(
                      fontSize: 30.sp,
                      color: ColorConstants.blackColor
                    ),
                  ),
                ),
                CustomOutlineTextFormField(
                  hintText: "Title",
                  filled: true,
                  controller: titleController,
                  validator: (value){
                    if(value!.isEmpty){
                      return "The title field is required.";
                    }
                  },
                  filledColor: ColorConstants.supportFieldsColor,
                  borderSideColor: ColorConstants.supportFieldsBorderColor,
                  cursorColor: ColorConstants.blackColor,
                ),
        
                Padding(
                  padding:  EdgeInsets.symmetric(vertical: 15.sp),
                  child: CustomOutlineTextFormField(
                    hintText: "Description",
                    maxLines: 10,
                    filled: true,
                    controller: descriptionController,
                    validator: (value){
                      if(value!.isEmpty){
                        return "The description field is required.";
                      }
                    },
                    filledColor: ColorConstants.supportFieldsColor,
                    borderSideColor: ColorConstants.supportFieldsBorderColor,
                    cursorColor: ColorConstants.blackColor,
                  ),
                ),
                CustomAppButton(
                  title: "Send",
                  onPress: ()async{
                    if(formKey.currentState!.validate()){
                      ApiResponse<HelpResponseModel>? sendHelpResponse = await HelpService().sendHelp(context, titleController.text, descriptionController.text);
                      debugPrint("on Button Response:$sendHelpResponse");
                      if(sendHelpResponse!.responseData?.success==true){
                        ShowMessage().showMessage(context, "Your request has been sent to Admin", ColorConstants.appPrimaryColor);
                        Navigator.of(context).pop();
        
                      }else{
                        ShowMessage().showMessage(context, "Something went wrong", ColorConstants.redColor);
        
                      }
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
