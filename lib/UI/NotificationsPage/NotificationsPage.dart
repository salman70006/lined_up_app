import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:linedup_app/Components/StaticTextStyle/StaticTextStyle.dart';

import '../../Components/Extentions/PaddingExtentions.dart';
import '../../Utils/Constants/ColorConstants/ColorConstants.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: PaddingExtensions.screenTopPadding, left: 22.sp, right: 22.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  height: 46.sp,
                  width: 46.sp,
                  decoration: BoxDecoration(shape: BoxShape.circle, color: ColorConstants.whiteColor),
                  child: Padding(
                    padding: EdgeInsets.only(left: 6.sp),
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 20.sp,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.sp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Notification",
                      style: StaticTextStyle()
                          .boldTextStyle
                          .copyWith(fontSize: 24.sp, color: ColorConstants.blackColor),
                    ),
                    Text(
                      "Clear All",
                      style: StaticTextStyle()
                          .boldTextStyle
                          .copyWith(fontSize: 14.sp, color: ColorConstants.appPrimaryColor),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.sp),
                child: Text(
                  "Today",
                  style: StaticTextStyle()
                      .boldTextStyle
                      .copyWith(fontSize: 18.sp, color: ColorConstants.blackColor),
                ),
              ),
              ListView.builder(
                  itemCount: 2,
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.all(16.sp),
                      margin: EdgeInsets.only(bottom: 10.sp),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.sp), color: ColorConstants.whiteColor),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Booking Reminder",
                            style: StaticTextStyle()
                                .boldTextStyle
                                .copyWith(fontSize: 18.sp, color: ColorConstants.blackColor),
                          ),
                          SizedBox(
                            height: 10.sp,
                          ),
                          Text(
                            "Your booking will starts in 10 minutes",
                            style: StaticTextStyle().regular.copyWith(
                                fontSize: 14.sp,
                                fontFamily: englishMedium,
                                fontWeight: FontWeight.w500,
                                color: ColorConstants.notificationTextColor),
                          )
                        ],
                      ),
                    );
                  }),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.sp),
                child: Text(
                  "Yesterday",
                  style: StaticTextStyle()
                      .boldTextStyle
                      .copyWith(fontSize: 18.sp, color: ColorConstants.blackColor),
                ),
              ),
              ListView.builder(
                  itemCount: 8,
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.all(16.sp),
                      margin: EdgeInsets.only(bottom: 10.sp),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.sp), color: ColorConstants.whiteColor),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Payment",
                            style: StaticTextStyle()
                                .boldTextStyle
                                .copyWith(fontSize: 18.sp, color: ColorConstants.blackColor),
                          ),
                          SizedBox(
                            height: 10.sp,
                          ),
                          Text(
                            "Payment Successful",
                            style: StaticTextStyle().regular.copyWith(
                                fontSize: 14.sp,
                                fontFamily: englishMedium,
                                fontWeight: FontWeight.w500,
                                color: ColorConstants.notificationTextColor),
                          )
                        ],
                      ),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
