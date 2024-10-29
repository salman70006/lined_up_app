import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:com.zat.linedup/Components/ScaffoldMessageWidget/ScaffoldMessageWidget.dart';
import 'package:com.zat.linedup/Components/StaticTextStyle/StaticTextStyle.dart';
import 'package:com.zat.linedup/Controllers/RedeemTicketService/RedeemTicketService.dart';
import 'package:com.zat.linedup/Providers/ReservationsDetailProvider/ReservationDetailProvider.dart';
import 'package:com.zat.linedup/Utils/Constants/AssetConstants/AssetConstants.dart';
import 'package:com.zat.linedup/Utils/Constants/ColorConstants/ColorConstants.dart';
import 'package:com.zat.linedup/Utils/Constants/RouteConstants/RouteConstants.dart';
import 'package:provider/provider.dart';

import '../../Components/CustomAppButton/CustomAppButton.dart';
import '../../Components/Extentions/PaddingExtentions.dart';

class ViewTicketPage extends StatefulWidget {
  var ticketType;

  ViewTicketPage({this.ticketType});

  @override
  State<ViewTicketPage> createState() => _ViewTicketPageState();
}

class _ViewTicketPageState extends State<ViewTicketPage> {
  bool isRedeem = false;
  bool? isLoading = true;
  DateTime dateTime = DateTime.now();
  final timeFormat = DateFormat("H:MM:ss");

  void _getTime() {
    final DateTime now = DateTime.now();
    final String formattedDateTime = _formatDateTime(now);
    setState(() {
      _timeString = formattedDateTime;
    });
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('hh:mm:ss').format(dateTime);
  }

  String? _timeString;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _timeString = _formatDateTime(DateTime.now());
    Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
    print(widget.ticketType);
    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ReservationDetailProvider>(
          builder: (context, reservationDetail, _) {
        var ticketDetails = reservationDetail.reservationsDetailResponseModel;
        return isLoading!
            ? Center(
                child: CircularProgressIndicator(
                  color: ColorConstants.appPrimaryColor,
                ),
              )
            : SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(
                      top: PaddingExtensions.screenTopPadding.sp,
                      left: 20.sp,
                      right: 20.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          InkWell(
                              onTap: () {
                                Navigator.of(context)
                                  ..pop()
                                  ..pop();
                              },
                              child: Icon(
                                Icons.arrow_back,
                                size: 20.sp,
                                color: ColorConstants.blackColor,
                              )),
                          SizedBox(
                            width: 10.sp,
                          ),
                          Text(
                            'Tickets',
                            style: StaticTextStyle().boldTextStyle.copyWith(
                                fontSize: 24.sp,
                                color: ColorConstants.blackColor),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 40.sp, bottom: 15.sp),
                        child: Text(
                          "Current Time: ${_timeString}",
                          style: StaticTextStyle().boldTextStyle.copyWith(
                              fontSize: 24.sp,
                              color: ColorConstants.blackColor),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 10.sp, bottom: 0.sp),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.sp),
                          border: Border.all(
                              color: widget.ticketType == "Reservation"
                                  ? ColorConstants.blackColor
                                  : ColorConstants.appPrimaryColor,
                              width: 1.sp),
                          gradient: LinearGradient(
                              colors: widget.ticketType == "Reservation"
                                  ? ColorConstants.simpleReservationGradient
                                  : widget.ticketType == "Event Ticket"
                                      ? ColorConstants.eventTicketColor
                                      : ColorConstants.expressReservationColor,
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                left: 10.sp,
                                right: 10.sp,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    widget.ticketType == "Reservation"
                                        ? "TIME SLOT\n10:30 PM"
                                        : widget.ticketType == "Event Ticket"
                                            ? "Event Ticket"
                                            : "EXPRESS\nRESERVATION",
                                    style: StaticTextStyle()
                                        .boldTextStyle
                                        .copyWith(
                                            fontSize: 20.sp,
                                            color: widget.ticketType ==
                                                    "Event Ticket"
                                                ? ColorConstants.appPrimaryColor
                                                : ColorConstants.whiteColor),
                                  ),
                                  Text(
                                    "PARTY SIZE\n                   ${ticketDetails!.data!.totalMembers}",
                                    style: StaticTextStyle()
                                        .boldTextStyle
                                        .copyWith(
                                            fontSize: 20.sp,
                                            color: widget.ticketType ==
                                                    "Event Ticket"
                                                ? ColorConstants.appPrimaryColor
                                                : ColorConstants.whiteColor),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: 10.sp,
                                right: 10.sp,
                              ),
                              child: Divider(
                                color: widget.ticketType == "Event Ticket"
                                    ? ColorConstants.appPrimaryColor
                                    : ColorConstants.blackColor,
                                thickness: 1.sp,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: 10.sp,
                                right: 10.sp,
                              ),
                              child: Text(
                                "Name",
                                style: StaticTextStyle().regular.copyWith(
                                    color: widget.ticketType == "Event Ticket"
                                        ? ColorConstants.blackColor
                                        : ColorConstants.whiteColor),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: 10.sp,
                                right: 10.sp,
                              ),
                              child: Text(
                                ticketDetails.data!.getUser!.userName
                                        .toString() ??
                                    "",
                                style: StaticTextStyle().regular.copyWith(
                                    fontSize: 16.sp,
                                    color: widget.ticketType == "Event Ticket"
                                        ? ColorConstants.blackColor
                                        : ColorConstants.whiteColor),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: 10.sp,
                                right: 10.sp,
                              ),
                              child: Text(
                                "Bar",
                                style: StaticTextStyle().regular.copyWith(
                                    color: widget.ticketType == "Event Ticket"
                                        ? ColorConstants.blackColor
                                        : ColorConstants.whiteColor),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: 10.sp,
                                right: 10.sp,
                              ),
                              child: Text(
                                "${ticketDetails.data?.getBarDetail!.venue.toString() ?? ""},${ticketDetails.data?.getBarDetail!.address ?? ""}",
                                style: StaticTextStyle().regular.copyWith(
                                    fontSize: 16.sp,
                                    color: widget.ticketType == "Event Ticket"
                                        ? ColorConstants.blackColor
                                        : ColorConstants.whiteColor),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 30.sp, horizontal: 10.sp),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Venue",
                                        style: StaticTextStyle()
                                            .regular
                                            .copyWith(
                                                color: widget.ticketType ==
                                                        "Event Ticket"
                                                    ? ColorConstants.blackColor
                                                    : ColorConstants
                                                        .whiteColor),
                                      ),
                                      SizedBox(
                                        width: 150.sp,
                                        child: Text(
                                          ticketDetails
                                                  .data?.getBarDetail!.venue
                                                  .toString() ??
                                              "",
                                          style: StaticTextStyle()
                                              .regular
                                              .copyWith(
                                                  fontSize: 16.sp,
                                                  color: widget.ticketType ==
                                                          "Event Ticket"
                                                      ? ColorConstants
                                                          .blackColor
                                                      : ColorConstants
                                                          .whiteColor),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Ticket Unique ID",
                                        style: StaticTextStyle()
                                            .regular
                                            .copyWith(
                                                color: widget.ticketType ==
                                                        "Event Ticket"
                                                    ? ColorConstants.blackColor
                                                    : ColorConstants
                                                        .whiteColor),
                                      ),
                                      Text(
                                        ticketDetails.data!.ticketNumber ?? "",
                                        style: StaticTextStyle()
                                            .regular
                                            .copyWith(
                                                fontSize: 16.sp,
                                                color: widget.ticketType ==
                                                        "Event Ticket"
                                                    ? ColorConstants.blackColor
                                                    : ColorConstants
                                                        .whiteColor),
                                        // overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: 10.sp,
                                right: 10.sp,
                              ),
                              child: Text(
                                "Date",
                                style: StaticTextStyle().regular.copyWith(
                                    color: widget.ticketType == "Event Ticket"
                                        ? ColorConstants.blackColor
                                        : ColorConstants.whiteColor),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: 10.sp,
                                right: 10.sp,
                              ),
                              child: Text(
                                ticketDetails.data!.getBarEvent?.date ?? "",
                                style: StaticTextStyle().regular.copyWith(
                                    fontSize: 16.sp,
                                    color: widget.ticketType == "Event Ticket"
                                        ? ColorConstants.blackColor
                                        : ColorConstants.whiteColor),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: 10.sp,
                                bottom: 5.sp
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 110.sp,
                                    height: 22.sp,
                                    margin: EdgeInsets.only(top: 20.sp),
                                    padding:
                                        EdgeInsets.symmetric(vertical: 4.sp),
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(13.sp),
                                      border: Border.all(
                                        color: ColorConstants.appPrimaryColor,
                                      ),
                                      color: ColorConstants.whiteColor
                                          .withOpacity(0.0.sp),
                                    ),
                                    child: Text(
                                      ticketDetails.data?.type ==
                                              "Express Reservation"
                                          ? "Express Reservation"
                                          : ticketDetails.data?.type ==
                                                  "Event Ticket"
                                              ? "Event Ticket"
                                              : "Reservation",
                                      style: StaticTextStyle()
                                          .boldTextStyle
                                          .copyWith(
                                            fontSize: 10.sp,
                                            color: widget.ticketType ==
                                                    "Event Ticket"
                                                ? ColorConstants.blackColor
                                                : ColorConstants.whiteColor,
                                          ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Padding(
                                    padding:  EdgeInsets.only(left: 10.sp),
                                    child: Image.asset(
                                      AssetConstants.ticketViewIcon,
                                      height: 60.sp,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.sp,
                      ),
                      CustomAppButton(
                        title: ticketDetails.data?.isRedeemed == "1"
                            ? "Redeemed"
                            : "Redeem",
                        btnRadius: 10.sp,
                        height: 58.sp,
                        width: 330.sp,
                        onPress: ticketDetails.data?.isRedeemed == "1"
                            ? null
                            : () async {
                                var redeemResponse = await RedeemTicketService()
                                    .redeemTicket(context,
                                        ticketDetails.data!.id.toString());
                                debugPrint(
                                    "Redeem Ticket Response on Button Press $redeemResponse");
                                if (redeemResponse!.responseData?.success ==
                                    true) {
                                  ShowMessage().showMessage(
                                      context,
                                      "Ticket Redeemed!",
                                      ColorConstants.appPrimaryColor);
                                  Navigator.of(context)
                                    ..pop()
                                    ..pop();
                                } else {
                                  ShowMessage().showMessage(
                                      context,
                                      "Internal server Error!",
                                      ColorConstants.redColor);
                                }
                              },
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 10.sp, horizontal: 20.sp),
                        child: Text(
                          "Note: Once tickets are redeemed they will be rendered useless. Please be sure the doorman is watching you redeem!",
                          style: StaticTextStyle().regular.copyWith(
                              fontSize: 16.sp,
                              color: ColorConstants.blackColor),
                        ),
                      ),
                      widget.ticketType == "Event Ticket"
                          ? Padding(
                              padding: EdgeInsets.symmetric(vertical: 20.sp),
                              child: CustomAppButton(
                                title: "Transfer",
                                btnRadius: 10.sp,
                                height: 58.sp,
                                width: 330.sp,
                                onPress: () {
                                  Navigator.of(context).pushNamed(
                                      RouteConstants.transferTicketPageRoute,
                                      arguments: ticketDetails.data?.id);
                                },
                              ),
                            )
                          : SizedBox(),
                    ],
                  ),
                ),
              );
      }),
    );
  }
}
