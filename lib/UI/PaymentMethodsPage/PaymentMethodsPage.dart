import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:linedup_app/Components/CustomAppButton/CustomAppButton.dart';
import 'package:linedup_app/Components/StaticTextStyle/StaticTextStyle.dart';
import 'package:linedup_app/Utils/Constants/AssetConstants/AssetConstants.dart';
import 'package:linedup_app/Utils/Constants/ColorConstants/ColorConstants.dart';

class PaymentMethodsPage extends StatefulWidget {
  const PaymentMethodsPage({super.key});

  @override
  State<PaymentMethodsPage> createState() => _PaymentMethodsPageState();
}

class _PaymentMethodsPageState extends State<PaymentMethodsPage> {
  List paymentMethods = [
    {"image": AssetConstants.payPalIcon, "name": "payPal", "value": "1", "id": "0"},
    {"image": AssetConstants.googleIcon, "name": "Google Play", "value": "2", "id": "1"},
    {"image": AssetConstants.appleIcon, "name": "Apple Pay", "value": "3", "id": "2"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 118.sp,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(24.sp),
              topLeft: Radius.circular(24.sp),
            ),
            color: ColorConstants.whiteColor),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomAppButton(
              title: "Continue",
              btnRadius: 10.sp,
              height: 58.sp,
              width: 330.sp,
              onPress: () {
                Navigator.of(context)..pop()..pop();
                _showBookingSuccessMessageDialog(context);
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 40.sp, left: 20.sp, right: 20.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.arrow_back_ios,
              size: 20.sp,
              color: ColorConstants.blackColor,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.sp),
              child: Text(
                "Payment",
                style: StaticTextStyle()
                    .boldTextStyle
                    .copyWith(fontSize: 24.sp, color: ColorConstants.blackColor),
              ),
            ),
            Text(
              "Choose Payment Methods",
              style:
                  StaticTextStyle().boldTextStyle.copyWith(fontSize: 18.sp, color: ColorConstants.blackColor),
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: paymentMethods.length,
                    itemBuilder: (context, index) {
                      return Container(
                        height: 80.sp,
                        width: double.infinity,
                        margin: EdgeInsets.only(bottom: 10.sp),
                        padding: EdgeInsets.all(16.sp),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.sp),
                            border: Border.all(
                                color: paymentMethods[index]["value"].contains(paymentMethods[index]["id"])
                                    ? ColorConstants.appPrimaryColor
                                    : ColorConstants.whiteColor),
                            color: ColorConstants.whiteColor),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(paymentMethods[index]["image"]),
                                SizedBox(
                                  width: 15.sp,
                                ),
                                Text(
                                  paymentMethods[index]["name"],
                                  style: StaticTextStyle()
                                      .boldTextStyle
                                      .copyWith(fontSize: 18.sp, color: ColorConstants.blackColor),
                                ),
                              ],
                            ),
                            Radio(
                                activeColor: ColorConstants.appPrimaryColor,
                                value: paymentMethods[index]["id"],
                                groupValue: paymentMethods[index]["value"],
                                onChanged: (value) {
                                  setState(() {
                                    paymentMethods[index]["value"] = value;
                                  });
                                })
                          ],
                        ),
                      );
                    }))
          ],
        ),
      ),
    );
  }

  void _showBookingSuccessMessageDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.sp),
              ),
              insetPadding: EdgeInsets.only(left: 16, right: 16.sp, top: 16.sp),
              child: Container(
                  padding: EdgeInsets.only(left: 25.sp, right: 25.sp,top: 20.sp),
                  height: 260.sp,
                  width: double.infinity,
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Center(
                      child: Text(
                        "Successful!",
                        style: StaticTextStyle()
                            .boldTextStyle
                            .copyWith(fontSize: 24.sp, color: ColorConstants.appPrimaryColor),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 15.sp),
                      child: Center(
                        child: SizedBox(
                          child: Text(
                            "Your booking can’t be canceled/refunded. Thank you for using LinedUp!",
                            textAlign: TextAlign.center,
                            style: StaticTextStyle().regular.copyWith(
                                  fontSize: 14.sp,
                                  color: ColorConstants.blackColor,
                                ),
                          ),
                        ),
                      ),
                    ),
                    CustomAppButton(
                      title: "Okay",
                      onPress: () {},
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.sp),
                      child: CustomAppButton(
                        title: "Cancel",
                        textColor: ColorConstants.blackColor,
                        btnColor: ColorConstants.cancelButtonColor,
                        onPress: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    )
                  ])));
        });
  }
}
