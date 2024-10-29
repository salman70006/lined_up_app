import 'dart:async';
import 'dart:io';
import 'dart:ui'as ui;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:com.zat.linedup/Components/CustomAppButton/CustomAppButton.dart';
import 'package:com.zat.linedup/Components/Extentions/PaddingExtentions.dart';
import 'package:com.zat.linedup/Components/PromotionContainer/PromotionContainer.dart';
import 'package:com.zat.linedup/Components/ScaffoldMessageWidget/ScaffoldMessageWidget.dart';
import 'package:com.zat.linedup/Components/ratingWidget/ratingWidget.dart';
import 'package:com.zat.linedup/Controllers/ReservationDetailService/ReservationDetailService.dart';
import 'package:com.zat.linedup/Controllers/ReviewService/ReviewService.dart';
import 'package:com.zat.linedup/Providers/AllReservationProvider/AllReservationProvider.dart';
import 'package:com.zat.linedup/Providers/ReservationsDetailProvider/ReservationDetailProvider.dart';
import 'package:com.zat.linedup/Utils/Constants/AssetConstants/AssetConstants.dart';
import 'package:com.zat.linedup/Utils/Constants/RouteConstants/RouteConstants.dart';
import 'package:provider/provider.dart';

import '../../Components/ReservationDetailCustomMarker/ReservationDetailCustomMarker.dart';
import '../../Components/StaticTextStyle/StaticTextStyle.dart';
import '../../Utils/Constants/ColorConstants/ColorConstants.dart';

class ReservationDetailPage extends StatefulWidget {

  var detailId;
   ReservationDetailPage({ this.detailId});

  @override
  State<ReservationDetailPage> createState() => _ReservationDetailPageState();
}

class _ReservationDetailPageState extends State<ReservationDetailPage> {
  BitmapDescriptor? customIcon;


  double? submittedRating;
  ReservationDetailService reservationDetailService = ReservationDetailService();
  bool? isLoadingShow=true;
  Completer<GoogleMapController> _controller = Completer();
  static const LatLng _center = const LatLng(45.521563, -122.677433);
  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }
  getDetailsData()async{
    await Future.delayed(Duration(seconds: 1),()async{
      await reservationDetailService.getAllReservationsDetail(context, widget.detailId.toString());
      isLoadingShow=false;
    });
  }
  final GlobalKey markerKey = GlobalKey();

  Future<BitmapDescriptor?> _createCustomMarkerBitmap() async {
    // Ensure that the context and render object are not null


    // Wait for the render object to be available
    await Future.delayed(Duration(milliseconds: 100),()async{
       RenderRepaintBoundary? boundary =
      markerKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;

      // If boundary is null, handle it gracefully


      // Capture the image from the boundary
      final image = await boundary?.toImage();
      final byteData = await image?.toByteData(format: ImageByteFormat.png);
      final bytes = byteData?.buffer.asUint8List();
      return BitmapDescriptor.fromBytes(bytes!);
    });






  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDetailsData();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _createCustomMarkerBitmap();
    });
    _createCustomMarkerIcon();
  }

  Future<void> _createCustomMarkerIcon() async {
    final ImageConfiguration imageConfiguration = ImageConfiguration(size: Size(90, 90));
    BitmapDescriptor.fromAssetImage(imageConfiguration, 'assets/Images/current_location_circle.png')
        .then((icon) {
      setState(() {
        customIcon = icon;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        if (details.delta.dx > 0) {
          Navigator.of(context).pop();
          // print("abck");
        }
      },
      child: Scaffold(
        body: Consumer<ReservationDetailProvider>(
          builder: (context, reservationDetailProvider,_) {
            var myReservation = reservationDetailProvider.reservationsDetailResponseModel;
            return isLoadingShow! ?Center(child: CircularProgressIndicator(
              color: ColorConstants.appPrimaryColor,
            ),) :SingleChildScrollView(
              child: Padding(
                padding:  EdgeInsets.only(top: PaddingExtensions.screenTopPadding.sp,left:20.sp,right: 20.sp ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                            onTap: (){
                              Navigator.of(context).pop();
                            },
                            child: Icon(Icons.arrow_back_ios,size: 20.sp,)),
                        Text(
                          "Wallet",
                          style: StaticTextStyle().boldTextStyle.copyWith(
                              fontSize: 16.sp,
                              color: ColorConstants.blackColor
                          ),
                        ),
                        SizedBox()
                      ],
                    ),

                    Container(
                      height: 200.sp,
                      child: Stack(
                        children: [
                          GoogleMap(
                            myLocationButtonEnabled: true,
                            onMapCreated: _onMapCreated,
                            initialCameraPosition: CameraPosition(
                              target: myReservation?.data?.getBarDetail?.latitude!=null && myReservation?.data?.getBarDetail?.longitude!=null? LatLng(
                                  double.parse(myReservation!.data!.getBarDetail!.latitude.toString()),
                                  double.parse(myReservation.data!.getBarDetail!.longitude.toString())):LatLng(0.0, 0.0),
                              zoom: 11.0,
                            ),
                        markers: {
                          Marker(
                            markerId: MarkerId('customMarker'),
                            position:    LatLng(myReservation?.data?.getBarDetail?.latitude!=null? double.parse(myReservation!.data!.getBarDetail!.latitude.toString()):0.0,myReservation?.data?.getBarDetail?.longitude!=null? double.parse(  myReservation!.data!.getBarDetail!.longitude.toString()):0.0),
                            icon: customIcon!, // Placeholder
                          ),
                        },
                      ),
                          Positioned(
                            top: 90,
                            left: 100,
                            child: RepaintBoundary(
                              key: markerKey,
                              child: CustomMarker(time: "", distance: "${myReservation?.data!.getBarDetail!.distance.toString()} km"),
                            ),
                          ),
                        ],
                      ),
                    ),


                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 150.sp,
                          child: Text(myReservation!.data?.getBarEvent?.title.toString()??myReservation!.data!.getBarDetail!.venue.toString(),style: StaticTextStyle().boldTextStyle.copyWith(
                            fontSize: 16.sp,
                            color: ColorConstants.blackColor
                          ),
                          overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        PromotionContainer(
                          height: 18.sp,
                          width: 111.sp,
                          fontSize: 10.sp,
                          colors: myReservation.data?.type=="Reservation"?ColorConstants.reservationButtonColor: myReservation.data?.type=="Event Ticket"?ColorConstants.reservationGradientWhiteColorContainer:ColorConstants.expressReservationButtonColor,
                          title: myReservation.data?.type=="Reservation"? "Reservations": myReservation.data?.type=="Event Ticket"?"Events Ticket":"Express reservation",
                          textColor:myReservation.data?.type=="Event Ticket"? ColorConstants.blackColor :ColorConstants.whiteColor,
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        )
                      ],
                    ),
                    Padding(
                      padding:  EdgeInsets.symmetric(vertical: 15.sp),
                      child: Container(
                        width: 290.sp,
                        child: Text(
                          "Note: The doorman must watch you redeem the reservation or you will forfeit your ticket.",
                          style: StaticTextStyle().regular.copyWith(
                              fontSize: 12.sp,
                              fontFamily: abelBold,
                              color: ColorConstants.blackColor
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Order Status",
                          style: StaticTextStyle().regular.copyWith(
                            fontSize: 16.sp,
                            color: ColorConstants.blackColor
                          ),
                        ),
                        InkWell(
                          onTap: (){
                            showDialog(context: context, builder: (context){
                              return Dialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.sp),
                                ),
                                insetPadding: EdgeInsets.only(left: 16,right: 16.sp,top: 16.sp),
                                child: Container(
                                  padding: EdgeInsets.only(left: 25.sp,right: 25.sp),
                                  height: 220.sp,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding:  EdgeInsets.symmetric(vertical: 20.sp),
                                        child: RatingWidget(
                                          initialRating: 0,

                                          onRatingUpdate: (rating){
                                            setState(() {
                                              submittedRating = rating;
                                            });
                                          },
                                        ),
                                      ),

                                      CustomAppButton(
                                        title: "Send review",
                                        onPress: ()async{
                                          var response = await ReviewService().giveReview(context, widget.detailId.toString(), double.parse(submittedRating.toString()).toInt());
                                         print("On rating Submit:$response");
                                         if(response?.responseData?.success==true){
                                           ShowMessage().showMessage(context, "Review submitted successfully!", ColorConstants.appPrimaryColor);
                                           Navigator.of(context).pop();

                                         }

                                          // Navigator.of(context).pushNamed(RouteConstants.paymentMethodsPageRoute);
                                        },
                                      ),
                                      Padding(
                                        padding:  EdgeInsets.symmetric(vertical: 10.sp),
                                        child: CustomAppButton(
                                          title: "Cancel",
                                          textColor: ColorConstants.blackColor,
                                          btnColor: ColorConstants.cancelButtonColor,
                                          onPress: (){
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      )

                                    ],
                                  ),
                                ),
                              );
                            }
                              );
                          },
                          child: PromotionContainer(
                            title: "Give reviews",
                            borderRadius: 8.sp,
                            padding: 5.sp,
                            containerColor: ColorConstants.appPrimaryColor,
                            height: 28.sp,
                            width: Platform.isIOS?200.sp :100.sp,
                            fontSize: 14.sp,
                          ),
                        ),
                      ],
                    ),
                    // Container(
                    //   padding: EdgeInsets.only(left: 10.sp,top: 17.sp,bottom: 17.sp,right: 10.sp),
                    //   margin: EdgeInsets.symmetric(vertical: 10.sp),
                    //   decoration: BoxDecoration(
                    //     color: ColorConstants.dailyPromotionContainerColor,
                    //     borderRadius: BorderRadius.circular(8.sp)
                    //   ),
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     mainAxisAlignment: MainAxisAlignment.start  ,
                    //     children: [
                    //      Text.rich(
                    //        TextSpan(
                    //          text: "Rules:",
                    //          style: StaticTextStyle().regular.copyWith(
                    //              fontSize: 12.sp,
                    //              color: ColorConstants.blackColor
                    //          ),
                    //          children: [
                    //            TextSpan(
                    //              text:"Venenatis pulvinar a amet in, suspendisse vitae,posuere eu tortor et. Und commodo, fermentum,mauris leo eget.",
                    //              style: StaticTextStyle().regular.copyWith(
                    //                  fontSize: 12.sp,
                    //                  fontWeight: FontWeight.w300,
                    //                  color: ColorConstants.blackColor
                    //              ),
                    //            )
                    //          ]
                    //        ),
                    //
                    //      ),
                    //
                    //
                    //     ],
                    //   ),
                    // ),
                    Container(
                      padding: EdgeInsets.only(left: 10.sp,top: 17.sp,bottom: 17.sp,right: 10.sp),
                      margin: EdgeInsets.symmetric(vertical: 5.sp),
                      decoration: BoxDecoration(
                        color: ColorConstants.dailyPromotionContainerColor,
                        borderRadius: BorderRadius.circular(8.sp)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween ,
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 32.sp,
                                width: 32.sp,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: ColorConstants.textGreyColor
                                ),
                                child: Center(
                                  child: Text(
                                    "1",
                                    style: StaticTextStyle().boldTextStyle.copyWith(
                                      fontSize: 14.sp,
                                      fontFamily: arimoBold
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 5.sp,
                              ),
                              Text(
                                "Confirmed",
                                style: StaticTextStyle().boldTextStyle.copyWith(
                                  fontSize: 14.sp,
                                  color: ColorConstants.blackColor
                                ),
                              )
                            ],
                          ),
                          Text(
                            "12:00 AM - 6 October 2024",
                            style: StaticTextStyle().regular.copyWith(
                              fontSize: 12.sp,
                              color: ColorConstants.blackColor
                            ),
                          ),

                        ],
                      ),
                    ),
                    myReservation?.data?.type=="Reservation" || myReservation?.data?.type=="Event Ticket"?   Padding(
                      padding:  EdgeInsets.symmetric(vertical: 15.sp),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SvgPicture.asset(AssetConstants.backwardIcon,height: 15.sp,),
                          SvgPicture.asset(AssetConstants.forwardIcon,height: 15.sp,),
                        ],
                      ),
                    ):SizedBox(),
                    Text(
                      "Members:",
                      style: StaticTextStyle().regular.copyWith(
                          fontSize: 16.sp,
                          color: ColorConstants.blackColor
                      ),
                    ),
                    Text(
                      "${myReservation?.data!.totalMembers} members",
                      style: StaticTextStyle().regular.copyWith(
                          fontSize: 14.sp,
                          color: ColorConstants.appPrimaryColor
                      ),
                    ),
                    Padding(
                      padding:  EdgeInsets.symmetric(vertical: 15.sp),
                      child: CustomAppButton(
                        title: myReservation.data?.isRedeemed=="1"?"Redeemed": "View Ticket",
                        fontSize: 16.sp,
                        btnRadius: 10.sp,
                        onPress:myReservation.data?.isRedeemed=="1"? null:(){
                          if(myReservation.data?.type=="Reservation"){
                            Navigator.of(context).pushNamed(RouteConstants.viewTicketPage,arguments: myReservation.data?.type);
                          }else if(myReservation.data?.type=="Event Ticket"){
                            Navigator.of(context).pushNamed(RouteConstants.viewTicketPage,arguments: myReservation.data?.type);

                          }else{
                            Navigator.of(context).pushNamed(RouteConstants.viewTicketPage,);

                          }
                        },
                      ),
                    )
                  ],
                ),

              ),
            );
          }
        ),
      ),
    );
  }
}
