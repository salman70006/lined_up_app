import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:linedup_app/Components/CustomAppButton/CustomAppButton.dart';
import 'package:linedup_app/Components/PromotionContainer/PromotionContainer.dart';
import 'package:linedup_app/Controllers/BarEventDetailService/BarEventDetailService.dart';
import 'package:linedup_app/Providers/BarEventDetailProvider/BarEventDetailProvider.dart';
import 'package:linedup_app/Utils/Constants/AssetConstants/AssetConstants.dart';
import 'package:provider/provider.dart';

import '../../Components/BackButtonWidget/BackButtonWidget.dart';
import '../../Components/CacheNetworkImage/CacheNetworkImage.dart';
import '../../Components/Extentions/PaddingExtentions.dart';
import '../../Components/StaticTextStyle/StaticTextStyle.dart';
import '../../Utils/Constants/ColorConstants/ColorConstants.dart';

class EventDetailScreen extends StatefulWidget {
  var eventId;
   EventDetailScreen({this.eventId});

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
    barEventDetailService.getEventsDetail(context, widget.eventId);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Consumer<EventDetailProvider>(
        builder: (context, eventProvider,_) {
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
                      color: ColorConstants.blackColor.withOpacity(0.5)
                    ),
                    ),
                    Text(
                      "\$${barDetail?.price??""}/person",
                      style: StaticTextStyle().boldTextStyle.copyWith(
                        fontSize: 18.sp,
                        color: ColorConstants.blackColor
                      ),
                    ),
                  ],
                ),
                CustomAppButton(
                  title: "BUY A TICKET",
                  width: 175.sp,
                  height: 52.sp,
                  btnRadius: 15.sp,
                  onPress: (){},
                  imageButtonIcon: SvgPicture.asset(AssetConstants.ticketIcon),
                )
              ],
            ),
          );
        }
      ),
      body: Consumer<EventDetailProvider>(
        builder: (context, eventDetailProvider,_) {
        var  eventDetail = eventDetailProvider.barEventDetailResponseModel;
          return eventDetail?.data==null?Center(
            child: CircularProgressIndicator(
              color: ColorConstants.appPrimaryColor,
            ),
          ): Column(
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
                      padding:  EdgeInsets.only(left:16.sp,top: 40.sp,bottom: 10.sp,right: 16.sp),
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
                            containerColor: ColorConstants.whiteColor.withOpacity(0.3),
                            borderColor: ColorConstants.whiteColor.withOpacity(0.0),
                            borderRadius: 15.sp,
                            onPress: (){
                              Navigator.of(context).pop();
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                eventDetail.data?.title.toString()??"",
                                style: StaticTextStyle().boldTextStyle.copyWith(
                                    fontSize: 28.sp,
                                    color: ColorConstants.aboutBlackColor
                                ),
                              ),
                              PromotionContainer(
                                height: 60.sp,
                                width: 60.sp,
                                borderRadius: 15.sp,
                                colors: ColorConstants.eventDateGradient,
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                padding: 8.sp,
                                title: formattedDate.format(DateTime.parse(eventDetail.data?.date.toString()??"")),
                                detail: "",

                                style: StaticTextStyle().regular.copyWith(
                                  fontSize: 13.sp,
                                  letterSpacing: 2.sp
                                ),
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
                    padding:  EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Padding(
                          padding:  EdgeInsets.symmetric(
                              vertical: 15.sp
                          ),
                          child: PromotionContainer(
                            height: 32.sp,
                            width: 76.sp,
                            borderRadius: 10.sp,
                            containerColor: ColorConstants.aboutBlackColor,
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            padding: 8.sp,
                            title: "ABOUT",

                            style: StaticTextStyle().regular.copyWith(
                                fontSize: 13.sp,
                                letterSpacing: 2.sp
                            ),
                          ),
                        ),
                        SizedBox(
                          child: Text(
                              eventDetail.data?.about.toString()??"",
                            style: StaticTextStyle().regular.copyWith(
                              color: ColorConstants.blackColor
                            ),
                          ),
                        ),
                        Padding(
                          padding:  EdgeInsets.only(top: 20.sp),
                          child: Text(
                            "Location",
                            style: StaticTextStyle()
                                .boldTextStyle
                                .copyWith(fontSize: 13.sp, color: ColorConstants.blackColor, letterSpacing: 1.sp),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: PaddingExtensions.screenVerticalPadding),
                          child: Container(
                            height: 200.sp,
                            child: GoogleMap(
                              onMapCreated: _onMapCreated,
                              initialCameraPosition: CameraPosition(
                                target: _center,
                                zoom: 11.0,
                              ),
                            ),
                          )
                        ),
                      ],
                    ),
                  ),
                ),
              ),

            ],
          );
        }
      ),
    );
  }
}
