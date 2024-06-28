import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:linedup_app/Components/ScaffoldMessageWidget/ScaffoldMessageWidget.dart';
import 'package:linedup_app/Components/StaticTextStyle/StaticTextStyle.dart';
import 'package:linedup_app/Controllers/RedeemTicketService/RedeemTicketService.dart';
import 'package:linedup_app/Providers/ReservationsDetailProvider/ReservationDetailProvider.dart';
import 'package:linedup_app/Utils/Constants/AssetConstants/AssetConstants.dart';
import 'package:linedup_app/Utils/Constants/ColorConstants/ColorConstants.dart';
import 'package:linedup_app/Utils/Constants/RouteConstants/RouteConstants.dart';
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
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.ticketType);
   isLoading=false;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ReservationDetailProvider>(
        builder: (context, reservationDetail,_) {
          var ticketDetails = reservationDetail.reservationsDetailResponseModel;
          return isLoading!? Center(
            child: CircularProgressIndicator(
              color: ColorConstants.appPrimaryColor,
            ),
          ):SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: PaddingExtensions.screenTopPadding.sp, left: 20.sp, right: 20.sp),
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
                        style: StaticTextStyle()
                            .boldTextStyle
                            .copyWith(fontSize: 24.sp, color: ColorConstants.blackColor),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 40.sp, bottom: 15.sp),
                    child: Text(
                      "Current Time: ${timeFormat.format(DateTime.parse(dateTime.toString()))}",
                      style: StaticTextStyle()
                          .boldTextStyle
                          .copyWith(fontSize: 24.sp, color: ColorConstants.blackColor),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 26.sp, top: 10.sp, right: 26.sp, bottom: 10.sp),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.sp),
                      border: Border.all(
                          color: widget.ticketType == "Reservation"
                              ? ColorConstants.blackColor
                              : ColorConstants.appPrimaryColor,
                          width: 1.sp),
                      gradient: LinearGradient(
                          colors: widget.ticketType  == "Reservation"
                              ?
                          ColorConstants.simpleReservationGradient
                              : widget.ticketType == "Event Ticket"
                                  ?ColorConstants.eventTicketColor
                              : ColorConstants.expressReservationColor,
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.ticketType == "Reservation"
                                  ? "TIME SLOT\n10:30 PM"
                                  : widget.ticketType == "Event Ticket"
                                      ? "Event Ticket"
                                      : "EXPRESS\nRESERVATION",
                              style: StaticTextStyle().boldTextStyle.copyWith(
                                  fontSize: 22.sp,
                                  color: widget.ticketType == "Event Ticket"
                                      ? ColorConstants.appPrimaryColor
                                      : ColorConstants.whiteColor),
                            ),
                            Text(
                              "PARTY SIZE\n                   ${ticketDetails!.data!.totalMembers}",
                              style: StaticTextStyle().boldTextStyle.copyWith(
                                  fontSize: 24.sp,
                                  color: widget.ticketType == "Event Ticket"
                                      ? ColorConstants.appPrimaryColor
                                      : ColorConstants.whiteColor),
                            ),
                          ],
                        ),
                        Divider(
                          color: widget.ticketType == "Event Ticket"
                              ? ColorConstants.appPrimaryColor
                              : ColorConstants.blackColor,
                          thickness: 1.sp,
                        ),
                        Text(
                          "Name",
                          style: StaticTextStyle().regular.copyWith(
                              color: widget.ticketType == "Event Ticket"
                                  ? ColorConstants.blackColor
                                  : ColorConstants.whiteColor),
                        ),
                        Text(
                          ticketDetails.data!.getUser!.userName.toString()??"",
                          style: StaticTextStyle().regular.copyWith(
                              fontSize: 16.sp,
                              color:widget.ticketType == "Event Ticket"
                                  ? ColorConstants.blackColor
                                  : ColorConstants.whiteColor),
                        ),
                        Text(
                          "Bar",
                          style: StaticTextStyle().regular.copyWith(
                              color: widget.ticketType == "Event Ticket"
                                  ? ColorConstants.blackColor
                                  : ColorConstants.whiteColor),
                        ),
                        Text(
                          "${ticketDetails.data?.getBarDetail!.venue.toString()??""},${ticketDetails.data?.getBarDetail!.address??""}",
                          style: StaticTextStyle().regular.copyWith(
                              fontSize: 16.sp,
                              color: widget.ticketType == "Event Ticket"
                                  ? ColorConstants.blackColor
                                  : ColorConstants.whiteColor),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 30.sp),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "City",
                                    style: StaticTextStyle().regular.copyWith(
                                        color: widget.ticketType == "Event Ticket"
                                            ? ColorConstants.blackColor
                                            : ColorConstants.whiteColor),
                                  ),
                                  Text(
                                    ticketDetails.data?.getBarDetail!.venue.toString()??"",
                                    style: StaticTextStyle().regular.copyWith(
                                        fontSize: 16.sp,
                                        color: widget.ticketType == "Event Ticket"
                                            ? ColorConstants.blackColor
                                            : ColorConstants.whiteColor),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Ticket Unique ID",
                                    style: StaticTextStyle().regular.copyWith(
                                        color: widget.ticketType == "Event Ticket"
                                            ? ColorConstants.blackColor
                                            : ColorConstants.whiteColor),
                                  ),
                                  Text(
                                    ticketDetails.data!.ticketNumber??"",
                                    style: StaticTextStyle().regular.copyWith(
                                        fontSize: 16.sp,
                                        color: widget.ticketType == "Event Ticket"
                                            ? ColorConstants.blackColor
                                            : ColorConstants.whiteColor),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "Date",
                          style: StaticTextStyle().regular.copyWith(
                              color: widget.ticketType == "Event Ticket"
                                  ? ColorConstants.blackColor
                                  : ColorConstants.whiteColor),
                        ),
                        Text(
                          "December 16, 2024",
                          style: StaticTextStyle().regular.copyWith(
                              fontSize: 16.sp,
                              color:widget.ticketType == "Event Ticket"
                                  ? ColorConstants.blackColor
                                  : ColorConstants.whiteColor),
                        ),
                        SizedBox(
                          height: 15.sp,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 110.sp,
                              height: 22.sp,
                              padding: EdgeInsets.symmetric(vertical: 4.sp),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(13.sp),
                                border: Border.all(
                                  color: ColorConstants.appPrimaryColor,
                                ),
                                color: ColorConstants.whiteColor.withOpacity(0.0.sp),
                              ),
                              child: Text(
                                "Express Reservation",
                                style: StaticTextStyle().boldTextStyle.copyWith(
                                      fontSize: 10.sp,
                                      color: widget.ticketType == "Event Ticket"
                                          ? ColorConstants.blackColor
                                          : ColorConstants.whiteColor,
                                    ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Image.asset(
                              AssetConstants.logoBgRemove,
                              height: 80.sp,
                              width: 110.sp,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.sp,
                  ),
                  CustomAppButton(
                    title: ticketDetails.data?.isRedeemed =="1" ? "Redeemed" : "Redeem",
                    btnRadius: 10.sp,
                    height: 58.sp,
                    width: 330.sp,
                    onPress: ticketDetails.data?.isRedeemed=="1"
                        ? null
                        : ()async {
                      var redeemResponse = await RedeemTicketService().redeemTicket(context, ticketDetails.data!.id.toString());
                      debugPrint("Redeem Ticket Response on Button Press $redeemResponse");
                      if(redeemResponse!.responseData?.success==true){
                        ShowMessage().showMessage(context, "Ticket Redeemed!",ColorConstants.appPrimaryColor);
                        Navigator.of(context)..pop()..pop();
                      }else{
                        ShowMessage().showMessage(context, "Internal server Error!",ColorConstants.redColor);

                      }

                          },
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.sp, horizontal: 20.sp),
                    child: Text(
                      "Note: Once tickets are redeemed they will be rendered useless. Please be sure the doorman is watching you redeem!",
                      style:
                          StaticTextStyle().regular.copyWith(fontSize: 16.sp, color: ColorConstants.blackColor),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.sp),
                    child: CustomAppButton(
                      title: "Transfer",
                      btnRadius: 10.sp,
                      height: 58.sp,
                      width: 330.sp,
                      onPress: () {
                        Navigator.of(context).pushNamed(RouteConstants.transferTicketPageRoute,arguments: ticketDetails.data?.id);
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}
