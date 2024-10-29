import 'package:com.zat.linedup/Service/NotificationsService/NotificationsService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:com.zat.linedup/Components/ScaffoldMessageWidget/ScaffoldMessageWidget.dart';
import 'package:com.zat.linedup/Components/StaticTextStyle/StaticTextStyle.dart';
import 'package:com.zat.linedup/Providers/AllBarsProvider/AllBarsProvider.dart';
import 'package:provider/provider.dart';

import '../../Components/Extentions/PaddingExtentions.dart';
import '../../Controllers/AllNotificationsService/AllNotificationsService.dart';
import '../../Providers/NotificationsProvider/NotificationsProvider.dart';
import '../../Utils/Constants/ColorConstants/ColorConstants.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage>{
updateNotificationData(BuildContext context){
  WidgetsBinding.instance
      .addPostFrameCallback((_) => AllNotificationsService().getAllNotifications(context));

}

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AllNotificationsService().getAllNotifications(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<NotificationsProvider>(
          builder: (context, notificationsProvider, _) {
        var notificationData =
            notificationsProvider.getAllNotificationsResponseModel;
        return notificationData?.notificationsData == null
            ? Center(
                child: CircularProgressIndicator(
                color: ColorConstants.appPrimaryColor,
              ))
            : SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(
                      top: PaddingExtensions.screenTopPadding,
                      left: 22.sp,
                      right: 22.sp),
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
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: ColorConstants.whiteColor),
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
                              style: StaticTextStyle().boldTextStyle.copyWith(
                                  fontSize: 24.sp,
                                  color: ColorConstants.blackColor),
                            ),
                            InkWell(
                              onTap: ()async{
                               var response = await AllNotificationsService().deleteAll(context);
                               if(response?.responseData?.success==true){
                                 ShowMessage().showMessage(context, response!.responseData!.message.toString(), ColorConstants.redColor);

                               }
                              },
                              child: Text(
                                "Clear All",
                                style: StaticTextStyle().boldTextStyle.copyWith(
                                    fontSize: 14.sp,
                                    color: ColorConstants.appPrimaryColor),
                              ),
                            )
                          ],
                        ),
                      ),

                      notificationData!.notificationsData ==[] || notificationData!.notificationsData!.isEmpty
                          ?
                           Center(child: Text("No Notifications!",style: TextStyle(color: ColorConstants.blackColor),)):
                      ListView.builder(
                          itemCount:
                          notificationData.notificationsData!.length,
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            var notification =
                            notificationData.notificationsData![index];
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                index ==0?  Padding(
                                  padding: EdgeInsets.symmetric(vertical: 20.sp),
                                  child: Text(
                                    "Today",
                                    style: StaticTextStyle().boldTextStyle.copyWith(
                                        fontSize: 18.sp,
                                        color: ColorConstants.blackColor),
                                  ),
                                ):SizedBox(),
                                Slidable(
                                  startActionPane: ActionPane(motion: BehindMotion(),children: [
                                    SlidableAction(onPressed: (context)async{
                                      var response = await AllNotificationsService().markAsRead(context, notification.id!.toInt());
                                      if(response?.responseData?.success==true){
                                        Future.delayed(Duration(seconds: 1),()async{
                                          if(context.mounted){
                                            await AllNotificationsService().getAllNotifications(context);

                                          }

                                        });

                                      }
                                    },
                                      backgroundColor: ColorConstants.eventsContainerColor,
                                      icon: Icons.mark_chat_read,
                                      label: "Mark as read",
                                    )
                                  ],),
                                  endActionPane: ActionPane(
                                      motion: BehindMotion(),
                                      children: [
                                    SlidableAction(

                                      onPressed: ((context)async{
                                      var response = await AllNotificationsService().deleteSingle(context, notification.id!.toInt());
                                      if(response?.responseData?.success==true){
                                        updateNotificationData(context);
                                      }
                                    }),
                                      backgroundColor: ColorConstants.redColor,
                                      icon: Icons.delete,
                                      label: "Delete",
                                    ),

                                  ]),

                                  child: Container(
                                    padding: EdgeInsets.all(16.sp),
                                    margin: EdgeInsets.only(bottom: 10.sp),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(16.sp),
                                        color: ColorConstants.whiteColor),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          notification.title ?? "",
                                          style: StaticTextStyle()
                                              .boldTextStyle
                                              .copyWith(
                                              fontSize: 18.sp,
                                              color:
                                              ColorConstants.blackColor),
                                        ),
                                        SizedBox(
                                          height: 10.sp,
                                        ),
                                        Text(
                                          notification.description ?? "",
                                          style: StaticTextStyle()
                                              .regular
                                              .copyWith(
                                              fontSize: 14.sp,
                                              fontFamily: englishMedium,
                                              fontWeight: FontWeight.w500,
                                              color: ColorConstants
                                                  .notificationTextColor),
                                        )
                                      ],
                                    ),
                                  ),)
                              ],
                            );
                          })
                      ,
                      // Padding(
                      //   padding: EdgeInsets.symmetric(vertical: 20.sp),
                      //   child: Text(
                      //     "Yesterday",
                      //     style: StaticTextStyle()
                      //         .boldTextStyle
                      //         .copyWith(fontSize: 18.sp, color: ColorConstants.blackColor),
                      //   ),
                      // ),
                      // ListView.builder(
                      //     itemCount: 8,
                      //     physics: NeverScrollableScrollPhysics(),
                      //     padding: EdgeInsets.zero,
                      //     shrinkWrap: true,
                      //     itemBuilder: (context, index) {
                      //       return Container(
                      //         padding: EdgeInsets.all(16.sp),
                      //         margin: EdgeInsets.only(bottom: 10.sp),
                      //         decoration: BoxDecoration(
                      //             borderRadius: BorderRadius.circular(16.sp), color: ColorConstants.whiteColor),
                      //         child: Column(
                      //           crossAxisAlignment: CrossAxisAlignment.start,
                      //           children: [
                      //             Text(
                      //               "Payment",
                      //               style: StaticTextStyle()
                      //                   .boldTextStyle
                      //                   .copyWith(fontSize: 18.sp, color: ColorConstants.blackColor),
                      //             ),
                      //             SizedBox(
                      //               height: 10.sp,
                      //             ),
                      //             Text(
                      //               "Payment Successful",
                      //               style: StaticTextStyle().regular.copyWith(
                      //                   fontSize: 14.sp,
                      //                   fontFamily: englishMedium,
                      //                   fontWeight: FontWeight.w500,
                      //                   color: ColorConstants.notificationTextColor),
                      //             )
                      //           ],
                      //         ),
                      //       );
                      //     })
                    ],
                  ),
                ),
              );
      }),
    );
  }
}
