import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:com.zat.linedup/Components/CacheNetworkImage/CacheNetworkImage.dart';
import 'package:com.zat.linedup/Components/StaticTextStyle/StaticTextStyle.dart';
import 'package:com.zat.linedup/Providers/BarDetailProvider/BarDetailProvider.dart';
import 'package:com.zat.linedup/Providers/BeachBarDetailProvider/BeachBarDetailProvider.dart';
import 'package:com.zat.linedup/Utils/Constants/AssetConstants/AssetConstants.dart';
import 'package:com.zat.linedup/Utils/Constants/ColorConstants/ColorConstants.dart';
import 'package:provider/provider.dart';

import '../../Components/CustomAppButton/CustomAppButton.dart';
import '../../Components/ScaffoldMessageWidget/ScaffoldMessageWidget.dart';
import '../../Controllers/BarDetailService/BarDetailService.dart';
import '../../Utils/Constants/RouteConstants/RouteConstants.dart';

class EventsTabPage extends StatefulWidget {
  const EventsTabPage({super.key});

  @override
  State<EventsTabPage> createState() => _EventsTabPageState();
}

class _EventsTabPageState extends State<EventsTabPage> {
  String? eventPrice;
  int? eventId;
  int? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:
          Consumer<BarDetailProvider>(builder: (context, barDetailProvider, _) {
        return Container(
          margin: EdgeInsets.only(left: 20.sp),
          color: ColorConstants.whiteColor,
          height: 90.sp,
          padding: EdgeInsets.all(20.sp),
          width: double.infinity,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Total Price",
                    style: StaticTextStyle().regular.copyWith(
                        fontSize: 12.sp,
                        color: ColorConstants.blackColor.withOpacity(0.5),
                        fontFamily: abelBold),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 5.sp),
                    child: Text(
                      "\$${eventPrice}",
                      style: StaticTextStyle().regular.copyWith(
                          fontSize: 18.sp,
                          color: ColorConstants.blackColor,
                          fontFamily: abelBold),
                    ),
                  ),
                ],
              ),
              CustomAppButton(
                title: "BUY TICKET",
                width: 160.sp,
                height: 52.sp,
                btnRadius: 12.sp,
                onPress: () {
                  _showMembersDialog(context);
                },
                imageButtonIcon: SvgPicture.asset(AssetConstants.ticketIcon),
              )
            ],
          ),
        );
      }),
      body:
          Consumer<BarDetailProvider>(builder: (context, barDetailProvider, _) {
        return barDetailProvider.barDetailsResponseModel!.data!.barEvents ==
                null
            ? Center(
                child: Text("No event tickets being offered at this time!"))
            : ListView.builder(
                itemCount: barDetailProvider
                    .barDetailsResponseModel!.data!.barEvents!.length,
                padding: EdgeInsets.zero,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  var event = barDetailProvider
                      .barDetailsResponseModel!.data!.barEvents![index];
                  eventId = event.id;
                  return Container(
                    padding: EdgeInsets.all(12.sp),
                    margin: EdgeInsets.only(top: 15.sp),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.sp),
                        color: ColorConstants.eventsContainerColor),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ImageWidget(
                              imageUrl: event.images?.first,
                              imageWidth: 100.sp,
                              imageHeight: 85.sp,
                              borderRadius: BorderRadius.circular(7.sp),
                              fit: BoxFit.cover,
                            ),
                            SizedBox(
                              width: 10.sp,
                            ),
                            Container(
                              width: 140,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    event.title ?? "",
                                    style: StaticTextStyle()
                                        .boldTextStyle
                                        .copyWith(
                                            color: ColorConstants.blackColor,
                                            fontSize: 16.sp,
                                            decoration:
                                                TextDecoration.underline,
                                            decorationColor:
                                                ColorConstants.blackColor),
                                  ),
                                  SizedBox(
                                    height: 10.sp,
                                  ),
                                  Text(
                                    event.startTime ?? "",
                                    style: StaticTextStyle().regular.copyWith(
                                        fontSize: 12.sp,
                                        fontFamily: englishMedium,
                                        color: ColorConstants.textGreyColor),
                                  ),
                                  Text(
                                    event.endTime ?? "",
                                    style: StaticTextStyle().regular.copyWith(
                                        fontSize: 12.sp,
                                        fontFamily: englishMedium,
                                        color: ColorConstants.textGreyColor),
                                  ),
                                  SizedBox(
                                    height: 10.sp,
                                  ),
                                  Text(
                                    event.about ?? "",
                                    style: StaticTextStyle().regular.copyWith(
                                          fontSize: 12.sp,
                                          color: ColorConstants.blackColor,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                    maxLines: 2,
                                  )
                                ],
                              ),
                            ),
                            Checkbox(
                                activeColor: ColorConstants.appPrimaryColor,
                                side: const BorderSide(
                                  color: ColorConstants.appPrimaryColor,
                                ),
                                splashRadius: 0.sp,
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                visualDensity: VisualDensity.compact,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(3.sp)),
                                value: selectedValue == index,
                                onChanged: (value) {
                                  setState(() {
                                    if (value == true) {
                                      selectedValue = index;
                                      eventPrice = event.price;
                                      print(eventPrice);
                                    }
                                  });
                                }),
                          ],
                        ),
                      ],
                    ),
                  );
                });
      }),
    );
  }

  void _showMembersDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return Consumer<BarDetailProvider>(
              builder: (context, barDetailProvider, _) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.sp),
              ),
              insetPadding: EdgeInsets.only(left: 16, right: 16.sp, top: 16.sp),
              child: Container(
                padding: Platform.isAndroid
                    ? EdgeInsets.only(
                        left: 25.sp,
                        right: 25.sp,
                      )
                    : EdgeInsets.only(
                        left: 25.sp, right: 25.sp, top: 40.sp, bottom: 10.sp),
                height: 600.sp,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      AssetConstants.memberImage,
                      height: 250,
                      width: double.infinity,
                    ),
                    Center(
                      child: Text(
                        "How Many Members?",
                        style: StaticTextStyle().boldTextStyle.copyWith(
                            fontSize: 24.sp,
                            fontFamily: urbanBold,
                            color: ColorConstants.appPrimaryColor),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 15.sp),
                      child: Center(
                        child: SizedBox(
                          width: 200.sp,
                          child: Text(
                            "Choose how many members are apart of your party",
                            textAlign: TextAlign.center,
                            style: StaticTextStyle().regular.copyWith(
                                fontSize: 16.sp,
                                color: ColorConstants.blackColor,
                                fontFamily: urbanRegular),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 15.sp),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              height: 32.sp,
                              width: 32.sp,
                              child: Icon(
                                Icons.arrow_back_ios,
                                color: ColorConstants.blackColor,
                                size: 15.sp,
                              )),
                          Expanded(
                            child: Container(
                              height: 35.sp,
                              child: ListView.builder(
                                  itemCount:
                                      barDetailProvider.memberList.length,
                                  padding: EdgeInsets.zero,
                                  physics: BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        barDetailProvider.selectedMemberId(
                                            barDetailProvider
                                                .memberList[index]);
                                      },
                                      child: Container(
                                        height: 32.sp,
                                        width: 32.sp,
                                        margin: EdgeInsets.only(right: 10.sp),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8.sp),
                                          color: barDetailProvider
                                                      .selectedMember ==
                                                  barDetailProvider
                                                      .memberList[index]
                                              ? ColorConstants.appPrimaryColor
                                              : ColorConstants
                                                  .memberCountBoxColor,
                                        ),
                                        child: Center(
                                          child: Text(
                                            barDetailProvider.memberList[index]
                                                .toString(),
                                            style: StaticTextStyle()
                                                .regular
                                                .copyWith(
                                                    color: barDetailProvider
                                                                .selectedMember ==
                                                            barDetailProvider
                                                                    .memberList[
                                                                index]
                                                        ? ColorConstants
                                                            .whiteColor
                                                        : ColorConstants
                                                            .blackColor),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                          ),
                          Container(
                              height: 32.sp,
                              width: 32.sp,
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: ColorConstants.blackColor,
                                size: 15.sp,
                              ))
                        ],
                      ),
                    ),
                    CustomAppButton(
                      title: "Confirm",
                      onPress: () async {
                        var total = double.parse("${eventPrice}") *
                            (barDetailProvider.selectedMember!.toInt());
                        print(total);
                        // barDetailProvider.barDetailsResponseModel?.data?.reservation?.peak?.forEach((e){
                        //   e.reservationId;
                        //   print(e.reservationId![0]);
                        // });

                        var response = await BarDetailService()
                            .reservationBooking(
                                context,
                                "",
                                eventId!,
                                0,
                                barDetailProvider.selectedMember.toString(),
                                barDetailProvider.barDetailsResponseModel!.data!
                                    .expressReservation!.barId
                                    .toString(),
                                "Event Ticket",
                                "",
                                "",
                                total);
                        print(response);
                        if (response?.responseData?.success == true) {
                          BarDetailService().barDetail(
                              context,
                              barDetailProvider.barDetailsResponseModel!.data!
                                  .expressReservation!.barId
                                  .toString());
                          ShowMessage().showMessage(
                              context,
                              "Your booking can’t be canceled/refunded. Thank you for using LinedUp!",
                              ColorConstants.appPrimaryColor);
                          Navigator.of(context).pushNamed(
                              RouteConstants.paymentMethodsPageRoute,
                              arguments: response?.responseData!.data);
                        } else {
                          ShowMessage().showMessage(context, response!.message!,
                              ColorConstants.redColor);
                        }
                      },
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
                  ],
                ),
              ),
            );
          });
        });
  }
}
