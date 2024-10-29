import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:com.zat.linedup/Components/StaticTextStyle/StaticTextStyle.dart';
import 'package:com.zat.linedup/Providers/AllReservationProvider/AllReservationProvider.dart';
import 'package:provider/provider.dart';

import '../../Components/BackButtonWidget/BackButtonWidget.dart';
import '../../Components/CacheNetworkImage/CacheNetworkImage.dart';
import '../../Components/Extentions/PaddingExtentions.dart';
import '../../Utils/Constants/AssetConstants/AssetConstants.dart';
import '../../Utils/Constants/ColorConstants/ColorConstants.dart';
import '../../Utils/Constants/RouteConstants/RouteConstants.dart';

class ReservationsSearchPage extends StatefulWidget {
  const ReservationsSearchPage({super.key});

  @override
  State<ReservationsSearchPage> createState() => _ReservationsSearchPageState();
}

class _ReservationsSearchPageState extends State<ReservationsSearchPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AllReservationProvider>(
      builder: (context, reservationProvider,_) {
        var reservation = reservationProvider.filterResponseModel;
        return Scaffold(
          body: Padding(
            padding:  EdgeInsets.only(top: PaddingExtensions.screenTopPadding,left: 16.sp,right: 16.sp),

            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BackButtonWidget(
                      icon: Icons.arrow_back_ios,
                      onPress: () => Navigator.of(context).pop(),
                    ),
                    Text("Searched Results",style: StaticTextStyle().boldTextStyle.copyWith(
                        fontSize: 18.sp,
                        color: ColorConstants.blackColor
                    ),),
                    SizedBox(width: 30.sp,),
                  ],
                ),

                Expanded(
                    child: ListView.builder(
                        itemCount: reservation!.filterReservationData!.length,
                        physics: BouncingScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemBuilder: (context,index){
                          var myReservations = reservation.filterReservationData![index];
                          return InkWell(
                            onTap: (){
                              if(myReservations.type=="Reservation"){
                                Navigator.of(context).pushNamed(RouteConstants.reservationDetailPage,arguments:myReservations.id
                                );
                              }
                              else if(myReservations.type=="Event Ticket"){
                                Navigator.of(context).pushNamed(RouteConstants.reservationDetailPage,arguments: myReservations.id
                                );

                              }else{
                                Navigator.of(context).pushNamed(RouteConstants.reservationDetailPage,arguments: myReservations.id);

                              }
                            },
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(8.sp),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.sp),
                                      gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: myReservations.type=="Reservation"?  ColorConstants.simpleReservationGradient: myReservations.type=="Event Ticket"?
                                          ColorConstants.reservationGradientWhiteColorContainer:ColorConstants.expressReservationColor
                                      )
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: Container(
                                            width: 110.sp,
                                            height: 22.sp,
                                            padding: EdgeInsets.symmetric(vertical: 4.sp),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(13.sp),
                                              border: Border.all(
                                                color: myReservations.type=="Event Ticket" || myReservations.type=="Reservation"? ColorConstants.appPrimaryColor: ColorConstants.whiteColor.withOpacity(0.1),
                                              ),
                                              color:  ColorConstants.whiteColor.withOpacity(0.0.sp),
                                            ),
                                            child:
                                            Text(
                                              myReservations.type.toString()??"",
                                              style: StaticTextStyle().boldTextStyle.copyWith(
                                                fontSize: 10.sp,
                                                color: myReservations.type=="Event Ticket"? ColorConstants.blackColor:ColorConstants.whiteColor,
                                              ),
                                              textAlign: TextAlign.center,
                                            )

                                        ),
                                      ),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          ImageWidget(
                                            imageUrl: myReservations.getBarDetail?.coverImage,
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
                                                  myReservations.getBarEvent?.title.toString()?? myReservations.getBarDetail?.venue.toString()??"",
                                                  style: StaticTextStyle().boldTextStyle.copyWith(
                                                      fontSize: 16.sp,
                                                      color:myReservations.type=="Event Ticket" ?ColorConstants.blackColor:ColorConstants.whiteColor
                                                  ),
                                                ),

                                                Padding(
                                                  padding:  EdgeInsets.symmetric(vertical: 5.sp),
                                                  child: Row(
                                                    children: [
                                                      SvgPicture.asset(AssetConstants.locationOutLineIcon,color:myReservations.type=="Event Ticket" ?ColorConstants.blackColor:ColorConstants.whiteColor,height: 18.sp,),
                                                      SizedBox(
                                                        width: 5.sp,
                                                      ),
                                                      Container(
                                                        width: 100.sp,
                                                        child: Text(
                                                          "${myReservations.getBarDetail!.venue.toString()??""} , ${myReservations.getBarDetail!.address}",
                                                          style: StaticTextStyle().boldTextStyle.copyWith(
                                                              fontSize: 12.sp,
                                                              color: myReservations.type=="Event Ticket"? ColorConstants.blackColor:ColorConstants.whiteColor
                                                          ),
                                                          overflow: TextOverflow.ellipsis,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    SvgPicture.asset(AssetConstants.calendarOutline,color: myReservations.type=="Event Ticket"?ColorConstants.blackColor:ColorConstants.whiteColor,),
                                                    SizedBox(
                                                      width: 5.sp,
                                                    ),
                                                    Text(
                                                      "03:35 PM - 3 October 2022",
                                                      style: StaticTextStyle().boldTextStyle.copyWith(
                                                          fontSize: 12.sp,
                                                          fontFamily: arimoBold,
                                                          color: myReservations.type=="Event Ticket" ?ColorConstants.blackColor:ColorConstants.whiteColor
                                                      ),
                                                    ),
                                                  ],
                                                ),

                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child:
                                        Text(
                                          myReservations.isRedeemed=="0"?"Status: Not-Redeemed" :"Status: Redeemed",
                                          style: StaticTextStyle().boldTextStyle.copyWith(
                                              fontSize: 10.sp,
                                              color: myReservations.type=="Event Ticket" || myReservations.type=="Reservation" ?ColorConstants.appPrimaryColor :ColorConstants.whiteColor
                                          ),),
                                      )
                                    ],
                                  ),
                                ),

                                Padding(
                                  padding:  EdgeInsets.symmetric(vertical: 10.sp),
                                  child: Text(
                                    "The doorman must watch you redeem the reservation or you will forfeit your rights of your reservation.",
                                    style: StaticTextStyle().regular.copyWith(
                                        fontSize: 10.sp,
                                        color: ColorConstants.blackColor
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          );
                        }))

              ],
            ),
          ),
        );
      }
    );
  }
}
