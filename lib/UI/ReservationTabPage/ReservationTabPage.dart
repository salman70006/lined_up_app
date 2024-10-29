import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:com.zat.linedup/Components/CustomAppButton/CustomAppButton.dart';
import 'package:com.zat.linedup/Components/ScaffoldMessageWidget/ScaffoldMessageWidget.dart';
import 'package:com.zat.linedup/Components/StaticTextStyle/StaticTextStyle.dart';
import 'package:com.zat.linedup/Controllers/BarDetailService/BarDetailService.dart';
import 'package:com.zat.linedup/Providers/BarDetailProvider/BarDetailProvider.dart';
import 'package:com.zat.linedup/Providers/BeachBarDetailProvider/BeachBarDetailProvider.dart';
import 'package:com.zat.linedup/Utils/Constants/AssetConstants/AssetConstants.dart';
import 'package:com.zat.linedup/Utils/Constants/ColorConstants/ColorConstants.dart';
import 'package:com.zat.linedup/Utils/Constants/RouteConstants/RouteConstants.dart';
import 'package:provider/provider.dart';

class ReservationTabPage extends StatefulWidget {
  ReservationTabPage({this.barId});

  String? barId;

  @override
  State<ReservationTabPage> createState() => _ReservationTabPageState();
}

class _ReservationTabPageState extends State<ReservationTabPage> {
  String? peakPrice;
  String? nonPeakPrice;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.barId);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<BeachBarDetailProvider, BarDetailProvider>(
        builder: (context, beachBarDetailProvider, barDetailProvider, _) {
      var applyReservation = barDetailProvider.reservationBookingResponseModel;
      return Scaffold(
        body: Consumer<BarDetailProvider>(
            builder: (context, barDetailProvider, _) {
          var applyReservation = barDetailProvider.barDetailsResponseModel;
          return applyReservation?.data == null
              ? Center(
                  child: CircularProgressIndicator(
                  color: ColorConstants.appPrimaryColor,
                ))
              : SingleChildScrollView(
                  child: Padding(
                    padding:  EdgeInsets.only(right:12.0),
                    child: Column(

                      children: [
                        SizedBox(
                          height: 20.sp,
                        ),
                        Text(
                          "When you reserve a time slot you must show the doorman the reservation between 5 minutes before your reserved time, up to 10 minutes after.",
                          style: StaticTextStyle().regular.copyWith(
                              fontFamily: abelBold,
                              fontSize: 12.sp,
                              color: ColorConstants.blackColor),
                        ),
                        Container(
                          height: 55.sp,
                          width: double.infinity,
                          margin: EdgeInsets.only(top: 10.sp),
                          child: ListView.builder(
                              itemCount: barDetailProvider.days.length,
                              physics: BouncingScrollPhysics(),
                              padding: EdgeInsets.zero,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return InkWell(
                                    onTap: () {
                                      barDetailProvider.check(index, context);
                                      barDetailProvider.setPrice(
                                          barDetailProvider.peak![index].price
                                              .toString(),
                                          barDetailProvider.nonPeak![index].price
                                              .toString());
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        barDetailProvider.selectedDay ==
                                                barDetailProvider.days[index]
                                            ? Container(
                                                height: 48.sp,
                                                width: 44.sp,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          16.sp),
                                                  color:
                                                      ColorConstants.dayBoxColor,
                                                ),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    SizedBox(
                                                      height: 10.sp,
                                                    ),
                                                    Text(
                                                      barDetailProvider
                                                          .days[index],
                                                      style: StaticTextStyle()
                                                          .regular
                                                          .copyWith(
                                                            fontSize: 11.sp,
                                                            color: ColorConstants
                                                                .daysTextColor,
                                                          ),
                                                    ),
                                                    Container(
                                                      height: 5.sp,
                                                      width: 5.sp,
                                                      decoration: BoxDecoration(
                                                          shape: BoxShape.circle,
                                                          color: ColorConstants
                                                              .daysDotColor),
                                                    )
                                                  ],
                                                ),
                                              )
                                            : Text(
                                                barDetailProvider.days[index],
                                                style: StaticTextStyle()
                                                    .regular
                                                    .copyWith(
                                                      fontSize: 11.sp,
                                                      color: barDetailProvider
                                                                  .selectedDay ==
                                                              barDetailProvider
                                                                  .days[index]
                                                          ? ColorConstants
                                                              .appPrimaryColor
                                                          : ColorConstants
                                                              .daysTextColor,
                                                    ),
                                              ),
                                        SizedBox(
                                          width: 35.sp,
                                        ),
                                      ],
                                    ));
                              }),
                        ),
                        Column(
                          children: [
                            Text(
                              "Non Peak",
                              style: StaticTextStyle().regular.copyWith(
                                  color: ColorConstants.aboutBlackColor,
                                  fontFamily: abelBold,
                                  fontSize: 12.sp),
                            ),
                            Container(
                              height: 2.sp,
                              width: 166.sp,
                              margin: EdgeInsets.symmetric(vertical: 10.sp),
                              color: ColorConstants.appPrimaryColor,
                            )
                          ],
                        ),
                        Row(
                          children: [
                            SvgPicture.asset(AssetConstants.timeslotIcon),
                            SizedBox(
                              width: 5.sp,
                            ),
                            Text(
                              "Choose time-slot for booking",
                              style: StaticTextStyle().regular.copyWith(
                                  fontSize: 12.sp,
                                  fontFamily: abelBold,
                                  color: ColorConstants.textGreyColor),
                            ),
                          ],
                        ),
                        Container(
                          height: 120.sp,
                          margin: EdgeInsets.only(top: 5.sp),
                          child: barDetailProvider.nonPeakReservation!.isEmpty
                              ? GridView.builder(
                                  itemCount: 8,
                                  physics: NeverScrollableScrollPhysics(),
                                  padding: EdgeInsets.zero,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 4,
                                          crossAxisSpacing: 5.sp,
                                          mainAxisSpacing: 5.sp,
                                          childAspectRatio: 2.3 / 1.7),
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        InkWell(
                                          onTap: () {},
                                          child: Container(
                                            width: 80.sp,
                                            height: Platform.isIOS?40.sp:35.sp,
                                            padding: EdgeInsets.all(10.sp),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8.sp),
                                                color: ColorConstants
                                                    .notAvailableColor

                                                // ColorConstants.notAvailableColor,
                                                ),
                                            child: Text(
                                              "N/A",
                                              style: StaticTextStyle()
                                                  .regular
                                                  .copyWith(fontFamily: abelBold),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          "0 left",
                                          style: StaticTextStyle()
                                              .regular
                                              .copyWith(
                                                  fontFamily: abelBold,
                                                  fontSize: 12.sp,
                                                  color:
                                                      ColorConstants.blackColor),
                                        )
                                      ],
                                    );
                                  })
                              : GridView.builder(
                                  itemCount: barDetailProvider
                                      .nonPeakReservation!.length,
                                  physics: NeverScrollableScrollPhysics(),
                                  padding: EdgeInsets.zero,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 4,
                                          crossAxisSpacing: 5.sp,
                                          mainAxisSpacing: 5.sp,
                                          childAspectRatio: 2.3 / 1.7),
                                  itemBuilder: (context, index) {
                                    var nonPeak = barDetailProvider
                                        .nonPeakReservation![index];
                                    nonPeakPrice = nonPeak.price;
                                    return Column(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            barDetailProvider
                                                .nonPeakSlot(nonPeak.id!);
                                            _showMembersDialog(context);
                                          },
                                          child: Container(
                                            width: 80.sp,
                                            height: 40.sp,
                                            padding: EdgeInsets.all(10.sp),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8.sp),
                                                color: barDetailProvider
                                                        .selectedNonPeakTime
                                                        .contains(nonPeak.id)
                                                    ? ColorConstants
                                                        .notAvailableColor
                                                    : ColorConstants
                                                        .appPrimaryColor
                                                // ColorConstants.notAvailableColor,
                                                ),
                                            child: Text(
                                              nonPeak?.time ?? "N/A",
                                              style: StaticTextStyle()
                                                  .regular
                                                  .copyWith(fontFamily: abelBold),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          "${nonPeak?.noOfPersons ?? "0"} left",
                                          style: StaticTextStyle()
                                              .regular
                                              .copyWith(
                                                  fontFamily: abelBold,
                                                  fontSize: 12.sp,
                                                  color:
                                                      ColorConstants.blackColor),
                                        )
                                      ],
                                    );
                                  }),
                        ),
                        Column(
                          children: [
                            Text(
                              "Peak",
                              style: StaticTextStyle().regular.copyWith(
                                  color: ColorConstants.aboutBlackColor,
                                  fontFamily: abelBold,
                                  fontSize: 12.sp),
                            ),
                            Container(
                              height: 2.sp,
                              width: 166.sp,
                              margin: EdgeInsets.symmetric(vertical: 10.sp),
                              color: ColorConstants.appPrimaryColor,
                            )
                          ],
                        ),
                        Container(
                          height: 115.sp,
                          child: barDetailProvider.peakReservation!.isEmpty
                              ? GridView.builder(
                                  itemCount: 8,
                                  physics: NeverScrollableScrollPhysics(),
                                  padding: EdgeInsets.zero,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 4,
                                          crossAxisSpacing: 5.sp,
                                          mainAxisSpacing: 5.sp,
                                          childAspectRatio: 2.3 / 1.7),
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        InkWell(
                                          onTap: () {},
                                          child: Container(
                                            width: 80.sp,
                                            height: Platform.isIOS? 40.sp:35.sp,
                                            padding: EdgeInsets.all(10.sp),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8.sp),
                                                color: ColorConstants
                                                    .notAvailableColor

                                                // ColorConstants.notAvailableColor,
                                                ),
                                            child: Text(
                                              "N/A",
                                              style: StaticTextStyle()
                                                  .regular
                                                  .copyWith(fontFamily: abelBold),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          "0 left",
                                          style: StaticTextStyle()
                                              .regular
                                              .copyWith(
                                                  fontFamily: abelBold,
                                                  fontSize: 12.sp,
                                                  color:
                                                      ColorConstants.blackColor),
                                        )
                                      ],
                                    );
                                  })
                              : GridView.builder(
                                  itemCount:
                                      barDetailProvider.peakReservation!.length,
                                  physics: NeverScrollableScrollPhysics(),
                                  padding: EdgeInsets.zero,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 4,
                                          crossAxisSpacing: 5.sp,
                                          mainAxisSpacing: 5.sp,
                                          childAspectRatio: 2.3 / 1.7),
                                  itemBuilder: (context, index) {
                                    var peak =
                                        barDetailProvider.peakReservation![index];
                                    // barDetailProvider.setPrice(peak.price.toString());
                                    return Column(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            barDetailProvider.peakSlot(peak.id!);
                                            _showMembersDialog(context);
                                          },
                                          child: Container(
                                            width: 80.sp,
                                            height: Platform.isIOS? 40.sp:35.sp,
                                            padding: EdgeInsets.all(10.sp),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8.sp),
                                              color: barDetailProvider
                                                      .selectedPeakTime
                                                      .contains(peak.id)
                                                  ? ColorConstants
                                                      .notAvailableColor
                                                  : ColorConstants
                                                      .appPrimaryColor,
                                            ),
                                            child: Text(
                                              peak.time ?? "N/A",
                                              style: StaticTextStyle()
                                                  .regular
                                                  .copyWith(fontFamily: abelBold),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          "${peak?.noOfPersons ?? "0"} left",
                                          style: StaticTextStyle()
                                              .regular
                                              .copyWith(
                                                  fontFamily: abelBold,
                                                  fontSize: 12.sp,
                                                  color:
                                                      ColorConstants.blackColor),
                                        )
                                      ],
                                    );
                                  }),
                        ),
                        SizedBox(
                          height: 10.sp,
                        ),
                        Row(
                          children: [
                            Text(
                              "\$${barDetailProvider.nonPeakPrice ?? "0"}",
                              style: StaticTextStyle().regular.copyWith(
                                  fontSize: 18.sp,
                                  fontFamily: abelBold,
                                  color: ColorConstants.appPrimaryColor),
                            ),
                            Text(
                              "/Non-Peak",
                              style: StaticTextStyle().regular.copyWith(
                                  fontSize: 12.sp,
                                  fontFamily: abelBold,
                                  color: ColorConstants.textGreyColor),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "\$${barDetailProvider.peakPrice ?? "0"}",
                              style: StaticTextStyle().regular.copyWith(
                                  fontSize: 18.sp,
                                  fontFamily: abelBold,
                                  color: ColorConstants.appPrimaryColor),
                            ),
                            Text(
                              "/Peak",
                              style: StaticTextStyle().regular.copyWith(
                                  fontSize: 12.sp,
                                  fontFamily: abelBold,
                                  color: ColorConstants.textGreyColor),
                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 5.sp),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Note:",
                                style: StaticTextStyle().regular.copyWith(
                                    fontSize: 16.sp,
                                    fontFamily: abelBold,
                                    color: ColorConstants.blackColor),
                              ),
                              Container(
                                width: Platform.isIOS?280.sp:275.sp,
                                padding: EdgeInsets.only(top: 2.sp, left: 5.sp),
                                child: Text(
                                  "Maximum 10 members per ticket, all members of the party must be present at the time of redemption.",
                                  style: StaticTextStyle().regular.copyWith(
                                      fontSize: 12.sp,
                                      fontFamily: abelBold,
                                      color: ColorConstants.blackColor),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          thickness: 1.sp,
                          color: ColorConstants.textGreyColor,
                        ),
                        Text(
                          "Don’t worry about rushing to the bar for a specific time. Express Reservations can be used at any time throughout the night! Walk up to the doorman, show them your express reservation,  and start your night without the wait!",
                          style: StaticTextStyle().regular.copyWith(
                              fontSize: 12.sp, color: ColorConstants.blackColor),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.sp),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: CustomAppButton(
                                  title: "Purchase Express Reservation",
                                  fontFamily: abelBold,
                                  width: 225.sp,
                                  height: 50.sp,
                                  onPress: () async {
                                    _showMembersDialog(context);
                                  },
                                ),
                              ),
                              Text(
                                "${applyReservation!.data?.expressReservation?.availability ?? "0"} Remaining!",
                                style: StaticTextStyle().regular.copyWith(
                                    fontSize: 12.sp,
                                    fontFamily: abelBold,
                                    color: ColorConstants.blackColor),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 15.sp),
                          child: Row(
                            children: [
                              Text(
                                "\$${applyReservation.data?.expressReservation?.price ?? "0"}",
                                style: StaticTextStyle().regular.copyWith(
                                    fontSize: 18.sp,
                                    fontFamily: abelBold,
                                    color: ColorConstants.appPrimaryColor),
                              ),
                              Text(
                                "/Express Reservation",
                                style: StaticTextStyle().regular.copyWith(
                                    fontSize: 12.sp,
                                    fontFamily: abelBold,
                                    color: ColorConstants.textGreyColor),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 5.sp),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Note:",
                                style: StaticTextStyle().regular.copyWith(
                                    fontSize: 16.sp,
                                    fontFamily: abelBold,
                                    color: ColorConstants.blackColor),
                              ),
                              Container(
                                width: Platform.isIOS?280.sp:275.sp,
                                padding: EdgeInsets.only(top: 2.sp, left: 5.sp),
                                child: Text(
                                  "Maximum 10 members per ticket, all members of the party must be present at the time of redemption.",
                                  style: StaticTextStyle().regular.copyWith(
                                      fontSize: 12.sp,
                                      fontFamily: abelBold,
                                      color: ColorConstants.blackColor),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
        }),
      );
    });
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
                        var total = double.parse(
                            "${barDetailProvider.barDetailsResponseModel?.data?.expressReservation?.price}") *
                            (barDetailProvider.selectedMember!.toInt());
                        // barDetailProvider.barDetailsResponseModel?.data?.reservation?.peak?.forEach((e){
                        //   e.reservationId;
                        //   print(e.reservationId![0]);
                        // });
                        print(barDetailProvider.selectedPeakTime);
                        if (barDetailProvider.selectedPeakTime!=null && barDetailProvider.selectedPeakTime.isNotEmpty && barDetailProvider.selectedPeakTime!=[]) {
                          var total = double.parse(
                                  "${barDetailProvider.barDetailsResponseModel!.data?.reservation!.peak![0].price}") *
                              (barDetailProvider.selectedMember!.toInt());
                          print(total);
                          print("if me aa gya hon");
                          // print(barDetailProvider.barDetailsResponseModel?.data?.barDetails?.id);
                          String selectedCommaSeparatedValues =
                              barDetailProvider.selectedPeakTime.join(",");
                          print(selectedCommaSeparatedValues);
                          var response = await BarDetailService()
                              .reservationBooking(
                                  context,
                                  "${barDetailProvider.barDetailsResponseModel?.data?.reservation?.peak![0].reservationId}",
                                  null,
                                  null,
                                  barDetailProvider.selectedMember.toString(),
                                  widget.barId!,
                                  "Reservation",
                                  selectedCommaSeparatedValues,
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
                            ShowMessage().showMessage(
                                context,
                                response!.message.toString(),
                                ColorConstants.redColor);
                          }
                        }
                        else if (barDetailProvider
                                .selectedNonPeakTime.isNotEmpty) {
                          print(barDetailProvider.selectedNonPeakTime);
                          var total = double.parse(
                                  "${barDetailProvider.barDetailsResponseModel!.data!.reservation!.nonPeak![0].price}") *
                              (barDetailProvider.selectedMember!.toInt());
                          print(total);
                          print("Non peak me hon");
                          // print(barDetailProvider.barDetailsResponseModel?.data?.barDetails?.id);
                          String selectedCommaSeparatedValues =
                              barDetailProvider.selectedNonPeakTime.join(",");
                          print(selectedCommaSeparatedValues);
                          var response = await BarDetailService()
                              .reservationBooking(
                                  context,
                                  "${barDetailProvider.barDetailsResponseModel?.data?.reservation?.nonPeak![0].reservationId}",
                                  null,
                                  null,
                                  barDetailProvider.selectedMember.toString(),
                                  widget.barId!,
                                  "Reservation",
                                  "",
                                  selectedCommaSeparatedValues,
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
                            ShowMessage().showMessage(
                                context,
                                response!.message.toString(),
                                ColorConstants.redColor);
                          }
                        }
                        else {

                        print(total);

                          var response = await BarDetailService()
                              .reservationBooking(
                                  context,
                                  null,
                                  null,
                                  barDetailProvider.barDetailsResponseModel!
                                      .data!.expressReservation!.id!,
                                  barDetailProvider.selectedMember.toString(),
                                  barDetailProvider.barDetailsResponseModel!
                                      .data!.expressReservation!.barId
                                      .toString(),
                                  "Express Reservation",
                                  null,
                                  null,
                                  total);
                          print(response);
                          if (response?.responseData?.success == true) {
                            BarDetailService().barDetail(
                                context,
                                barDetailProvider.barDetailsResponseModel!.data!
                                    .expressReservation!.barId
                                    .toString());
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
                            ShowMessage().showMessage(
                                context,
                                response!.message.toString(),
                                ColorConstants.redColor);
                          }
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
                          barDetailProvider.reset();
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
