import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:com.zat.linedup/Components/BackButtonWidget/BackButtonWidget.dart';
import 'package:com.zat.linedup/Components/Extentions/PaddingExtentions.dart';
import 'package:com.zat.linedup/Components/StaticTextStyle/StaticTextStyle.dart';
import 'package:com.zat.linedup/Controllers/PrivacyPolicyAndTermsService/PrivacyPolicyAndTermsService.dart';
import 'package:com.zat.linedup/Providers/privacyPolicyProvider/PrivacyPolicyProvider.dart';
import 'package:provider/provider.dart';

import '../../Utils/Constants/ColorConstants/ColorConstants.dart';

class AppTermsAndConditions extends StatefulWidget {
  const AppTermsAndConditions({super.key});

  @override
  State<AppTermsAndConditions> createState() => _AppTermsAndConditionsState();
}

class _AppTermsAndConditionsState extends State<AppTermsAndConditions> {
  PrivacyPolicyAndTermsService policyAndTermsService = PrivacyPolicyAndTermsService();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    policyAndTermsService.getPrivacyAndTerms(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<PrivacyPolicyAndTcProvider>(
        builder: (context, termsAndConditionsProvider,_) {
          var terms = termsAndConditionsProvider.policyAndTCResponseModel;
          return terms?.termAndCondition==null ? Center(child: CircularProgressIndicator(color: ColorConstants.appPrimaryColor,)):SingleChildScrollView(
            child: Padding(
              padding:  EdgeInsets.only(top: PaddingExtensions.screenTopPadding,left: 22.sp,right: 22.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BackButtonWidget(
                    icon: Icons.arrow_back_ios,
                    iconSize: 15.sp,
                    onPress: (){
                      Navigator.of(context).pop();
                    },
                  ),
                  Padding(
                    padding:  EdgeInsets.symmetric(vertical: 15.sp),
                    child: Text(
                      "Terms & conditions",
                      style: StaticTextStyle().boldTextStyle.copyWith(
                          fontSize: 30.sp,
                          color: ColorConstants.blackColor
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(22.sp),
                    margin: EdgeInsets.only(bottom: 15.sp,top: 20.sp),
                    decoration: BoxDecoration(
                        color: ColorConstants.whiteColor,
                        borderRadius: BorderRadius.circular(16.sp),
                        boxShadow: [
                          BoxShadow(
                              spreadRadius: 0.sp,
                              blurRadius: 0.6.sp,
                              color: ColorConstants.blackColor.withOpacity(0.2.sp)
                          ),
                        ]
                    ),
                    child:
                    Html(
                      data: terms?.termAndCondition.toString()??"",
                      style: {
                        "body": Style(
                          padding: HtmlPaddings.zero,
                          fontSize: FontSize(12.sp,),
                          margin: Margins.zero,
                          textAlign: TextAlign.justify,
                          fontWeight: FontWeight.w300,
                          lineHeight: LineHeight(1.5.sp)
                        ),
                      },
                    ),
                    // Text(
                    //   terms?.termAndCondition.toString()??"",
                    //   style: StaticTextStyle().regular.copyWith(
                    //       fontSize: 12.sp,
                    //       color: ColorConstants.textGreyColor
                    //   ),
                    //   textAlign: TextAlign.justify,
                    // ),
                  )
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}
