import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:com.zat.linedup/Components/CustomAppButton/CustomAppButton.dart';
import 'package:com.zat.linedup/Components/PromotionContainer/PromotionContainer.dart';
import 'package:com.zat.linedup/Controllers/BarEventDetailService/BarEventDetailService.dart';
import 'package:com.zat.linedup/Providers/BarEventDetailProvider/BarEventDetailProvider.dart';
import 'package:com.zat.linedup/Providers/UserProfileProvider/UserProfileProvider.dart';
import 'package:com.zat.linedup/Utils/Constants/AssetConstants/AssetConstants.dart';
import 'package:provider/provider.dart';
import '../../Components/BackButtonWidget/BackButtonWidget.dart';
import '../../Components/CacheNetworkImage/CacheNetworkImage.dart';
import '../../Components/Extentions/PaddingExtentions.dart';
import '../../Components/ScaffoldMessageWidget/ScaffoldMessageWidget.dart';
import '../../Components/StaticTextStyle/StaticTextStyle.dart';
import '../../Controllers/BarDetailService/BarDetailService.dart';
import '../../Providers/BarDetailProvider/BarDetailProvider.dart';
import '../../Utils/Constants/ColorConstants/ColorConstants.dart';
import '../../Utils/Constants/RouteConstants/RouteConstants.dart';

class EventDetailScreen extends StatefulWidget {
  var data;

  EventDetailScreen({this.data});

  @override
  State<EventDetailScreen> createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
  BarEventDetailService barEventDetailService = BarEventDetailService();
  DateTime? dateTime;
  final formattedDate = DateFormat('MMMdd');
  Completer<GoogleMapController> _controller = Completer();

  static const LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    barEventDetailService.getEventsDetail(context, widget.data["eventId"]);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        if (details.delta.dx > 0) {
          Navigator.of(context).pop();
          print("abck");
        }
      },
      child: Scaffold(
        bottomNavigationBar:
            Consumer<EventDetailProvider>(builder: (context, eventProvider, _) {
          var barDetail = eventProvider.barEventDetailResponseModel?.data;
          return Container(
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
                      "PRICE",
                      style: StaticTextStyle().regular.copyWith(
                          fontSize: 13.sp,
                          color: ColorConstants.blackColor.withOpacity(0.5)),
                    ),
                    Text(
                      "\$${barDetail?.price ?? ""}/person",
                      style: StaticTextStyle().boldTextStyle.copyWith(
                          fontSize: 18.sp, color: ColorConstants.blackColor),
                    ),
                  ],
                ),
                CustomAppButton(
                  title: "BUY A TICKET",
                  width: 175.sp,
                  height: 52.sp,
                  btnRadius: 15.sp,
                  onPress: () {
                    _showMembersDialog(context);
                  },
                  imageButtonIcon: SvgPicture.asset(AssetConstants.ticketIcon),
                )
              ],
            ),
          );
        }),
        body: Consumer2<EventDetailProvider, UserProfileProvider>(
            builder: (context, eventDetailProvider, userProfileProvider, _) {
          var eventDetail = eventDetailProvider.barEventDetailResponseModel;
          var profileData = userProfileProvider.userProfileResponseModel?.data;
          return eventDetail?.data == null
              ? Center(
                  child: CircularProgressIndicator(
                    color: ColorConstants.appPrimaryColor,
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        ImageWidget(
                          imageUrl: eventDetail!.data!.images!.first,
                          height: 370.sp,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                        Container(
                          height: 370.sp,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  const Color(0xffFFFFFF).withOpacity(0.sp),
                                  const Color(0xffFEFEFEE0).withOpacity(0.6.sp),
                                  const Color(0xffFFFFFF).withOpacity(0.6.sp),
                                ]),
                          ),
                        ),
                        Container(
                          height: 370.sp,
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 16.sp,
                                top: 40.sp,
                                bottom: 10.sp,
                                right: 16.sp),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                BackButtonWidget(
                                  height: 40.sp,
                                  width: 50.sp,
                                  icon: Icons.arrow_back,
                                  iconSize: 24.sp,
                                  leftPadding: 2.sp,
                                  iconColor: ColorConstants.whiteColor,
                                  containerColor: ColorConstants.whiteColor
                                      .withOpacity(0.3),
                                  borderColor: ColorConstants.whiteColor
                                      .withOpacity(0.0),
                                  borderRadius: 15.sp,
                                  onPress: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      eventDetail.data?.title.toString() ?? "",
                                      style: StaticTextStyle()
                                          .boldTextStyle
                                          .copyWith(
                                              fontSize: 28.sp,
                                              color: ColorConstants
                                                  .aboutBlackColor),
                                    ),
                                    PromotionContainer(
                                      height: 60.sp,
                                      width: 60.sp,
                                      borderRadius: 15.sp,
                                      colors: ColorConstants.eventDateGradient,
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      padding: 8.sp,
                                      title: formattedDate.format(
                                          DateTime.parse(eventDetail.data?.date
                                                  .toString() ??
                                              "")),
                                      detail: "",
                                      style: StaticTextStyle().regular.copyWith(
                                          fontSize: 13.sp, letterSpacing: 2.sp),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 15.sp),
                                child: PromotionContainer(
                                  height: 32.sp,
                                  width: 76.sp,
                                  borderRadius: 10.sp,
                                  containerColor:
                                      ColorConstants.aboutBlackColor,
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  padding: 8.sp,
                                  title: "ABOUT",
                                  style: StaticTextStyle().regular.copyWith(
                                      fontSize: 13.sp, letterSpacing: 2.sp),
                                ),
                              ),
                              SizedBox(
                                child: Text(
                                  eventDetail.data?.about.toString() ?? "",
                                  style: StaticTextStyle().regular.copyWith(
                                      color: ColorConstants.blackColor),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 20.sp),
                                child: Text(
                                  "Location",
                                  style: StaticTextStyle()
                                      .boldTextStyle
                                      .copyWith(
                                          fontSize: 13.sp,
                                          color: ColorConstants.blackColor,
                                          letterSpacing: 1.sp),
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: PaddingExtensions
                                          .screenVerticalPadding),
                                  child: Container(
                                    height: 200.sp,
                                    child: GoogleMap(
                                        mapToolbarEnabled: true,
                                        onMapCreated: _onMapCreated,
                                        initialCameraPosition: CameraPosition(
                                          target: LatLng(
                                              double.parse(
                                                  profileData!.latitude!),
                                              double.parse(
                                                  profileData.longitude!)),
                                          zoom: 11.0,
                                        ),
                                        markers: {
                                          Marker(
                                              markerId: MarkerId(eventDetail
                                                  .data!.id
                                                  .toString()),
                                              position: LatLng(
                                                  double.parse(
                                                      widget.data["lat"]),
                                                  double.parse(
                                                      widget.data["long"])),
                                              infoWindow: InfoWindow(
                                                  title: eventDetail.data
                                                      ?.getBarInfo!.venue!)),
                                        }),
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
        }),
      ),
    );
  }

  void _showMembersDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return Consumer2<BarDetailProvider, EventDetailProvider>(
              builder: (context, barDetailProvider, eventDetailProvider, _) {
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
                                "${eventDetailProvider.barEventDetailResponseModel!.data!.price}") *
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
                                eventDetailProvider
                                    .barEventDetailResponseModel!.data!.id!
                                    .toInt(),
                                0,
                                barDetailProvider.selectedMember.toString(),
                                eventDetailProvider.barEventDetailResponseModel!
                                    .data!.getBarInfo!.id
                                    .toString(),
                                "Event Ticket",
                                "",
                                "",
                                total);
                        print(response);
                        if (response?.responseData?.success == true) {
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
