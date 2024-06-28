import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:linedup_app/Components/CustomAppButton/CustomAppButton.dart';
import 'package:linedup_app/Components/Extentions/PaddingExtentions.dart';
import 'package:linedup_app/Components/PromotionContainer/PromotionContainer.dart';
import 'package:linedup_app/Components/ScaffoldMessageWidget/ScaffoldMessageWidget.dart';
import 'package:linedup_app/Components/ratingWidget/ratingWidget.dart';
import 'package:linedup_app/Controllers/ReservationDetailService/ReservationDetailService.dart';
import 'package:linedup_app/Controllers/ReviewService/ReviewService.dart';
import 'package:linedup_app/Providers/AllReservationProvider/AllReservationProvider.dart';
import 'package:linedup_app/Providers/ReservationsDetailProvider/ReservationDetailProvider.dart';
import 'package:linedup_app/Utils/Constants/AssetConstants/AssetConstants.dart';
import 'package:linedup_app/Utils/Constants/RouteConstants/RouteConstants.dart';
import 'package:provider/provider.dart';

import '../../Components/StaticTextStyle/StaticTextStyle.dart';
import '../../Utils/Constants/ColorConstants/ColorConstants.dart';

class ReservationDetailPage extends StatefulWidget {

  var detailId;
   ReservationDetailPage({ this.detailId});

  @override
  State<ReservationDetailPage> createState() => _ReservationDetailPageState();
}

class _ReservationDetailPageState extends State<ReservationDetailPage> {
  double? submittedRating;
  ReservationDetailService reservationDetailService = ReservationDetailService();
  bool? isLoadingShow=true;
  getDetailsData()async{
    await Future.delayed(Duration(seconds: 1),()async{
      await reservationDetailService.getAllReservationsDetail(context, widget.detailId.toString());
      isLoadingShow=false;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDetailsData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    height: 330.sp,width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 20.sp),
                      child: Image.asset(AssetConstants.googleMapImage,height: 330.sp,width: double.infinity.sp,fit: BoxFit.cover,)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(myReservation!.data!.getBarEvent?.title.toString()??"",style: StaticTextStyle().boldTextStyle.copyWith(
                        fontSize: 16.sp,
                        color: ColorConstants.blackColor
                      ),),
                      PromotionContainer(
                        height: 18.sp,
                        width: 111.sp,
                        fontSize: 10.sp,
                        colors: myReservation.data?.type=="Reservation"?ColorConstants.reservationButtonColor: myReservation.data?.type=="Event Ticket"?ColorConstants.reservationGradientWhiteColorContainer:ColorConstants.expressReservationButtonColor,
                        title: myReservation.data?.type=="Reservation"? "Reservations": myReservation.data?.type=="Event Ticket"?"Event Ticket":"Express reservation",
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
                          title: "Give review",
                          borderRadius: 8.sp,
                          padding: 5.sp,
                          containerColor: ColorConstants.appPrimaryColor,
                          height: 28.sp,
                          width: 100.sp,
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10.sp,top: 17.sp,bottom: 17.sp,right: 10.sp),
                    margin: EdgeInsets.symmetric(vertical: 10.sp),
                    decoration: BoxDecoration(
                      color: ColorConstants.dailyPromotionContainerColor,
                      borderRadius: BorderRadius.circular(8.sp)
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start  ,
                      children: [
                       Text.rich(
                         TextSpan(
                           text: "Rules:",
                           style: StaticTextStyle().regular.copyWith(
                               fontSize: 12.sp,
                               color: ColorConstants.blackColor
                           ),
                           children: [
                             TextSpan(
                               text:" Venenatis pulvinar a amet in, suspendisse vitae,posuere eu tortor et. Und commodo, fermentum,mauris leo eget.",
                               style: StaticTextStyle().regular.copyWith(
                                   fontSize: 12.sp,
                                   fontWeight: FontWeight.w300,
                                   color: ColorConstants.blackColor
                               ),
                             )
                           ]
                         ),

                       ),


                      ],
                    ),
                  ),
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
                  myReservation.data?.type=="Reservation" || myReservation.data?.type=="Event Ticket"?   Padding(
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
                    "${myReservation.data!.totalMembers} members",
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
    );
  }
}
