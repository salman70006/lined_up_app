import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:com.zat.linedup/Providers/AllReservationProvider/AllReservationProvider.dart';
import 'package:provider/provider.dart';

import '../../Utils/Constants/AssetConstants/AssetConstants.dart';
import '../../Utils/Constants/ColorConstants/ColorConstants.dart';
import '../../Utils/Constants/RouteConstants/RouteConstants.dart';
import '../CacheNetworkImage/CacheNetworkImage.dart';
import '../StaticTextStyle/StaticTextStyle.dart';

class ReservationWidget extends StatefulWidget {
  const ReservationWidget({super.key});

  @override
  State<ReservationWidget> createState() => _ReservationWidgetState();
}

class _ReservationWidgetState extends State<ReservationWidget> {

  @override
  Widget build(BuildContext context) {
    return Consumer<AllReservationProvider>(
      builder: (context, allReservationProvider,_) {
        var reservation = allReservationProvider.filterResponseModel;

        return Container(
          child: reservation?.filterReservationData==null? Center(child: Text("No bars")):ListView.builder(
              itemCount: reservation?.filterReservationData?.length,
              itemBuilder: (context,index){
                var myReservations = reservation?.filterReservationData![index];

            return InkWell(
              onTap: (){
                Navigator.of(context).pushNamed(RouteConstants.reservationDetailPage,arguments:myReservations?.id);


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
                            colors:   ColorConstants.simpleReservationGradient
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
                                  color:ColorConstants.appPrimaryColor,
                                ),
                                color:  ColorConstants.whiteColor.withOpacity(0.0.sp),
                              ),
                              child:
                              Text(
                                "Reservation",
                                style: StaticTextStyle().boldTextStyle.copyWith(
                                  fontSize: 10.sp,
                                  color: ColorConstants.whiteColor,
                                ),
                                textAlign: TextAlign.center,
                              )

                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ImageWidget(
                              imageUrl: myReservations?.getBarDetail?.coverImage,
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
                                    "Beach Concert",
                                    style: StaticTextStyle().boldTextStyle.copyWith(
                                        fontSize: 16.sp,
                                        color:ColorConstants.whiteColor
                                    ),
                                  ),

                                  Padding(
                                    padding:  EdgeInsets.symmetric(vertical: 5.sp),
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(AssetConstants.locationOutLineIcon,color:ColorConstants.whiteColor,height: 18.sp,),
                                        SizedBox(
                                          width: 5.sp,
                                        ),
                                        Container(
                                          width: 100.sp,
                                          child: Text(
                                            "${myReservations?.getBarDetail?.venue.toString()??""} , ${myReservations?.getBarDetail?.address}",
                                            style: StaticTextStyle().boldTextStyle.copyWith(
                                                fontSize: 12.sp,
                                                color: ColorConstants.whiteColor
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      SvgPicture.asset(AssetConstants.calendarOutline,color: ColorConstants.whiteColor,),
                                      SizedBox(
                                        width: 5.sp,
                                      ),
                                      Text(
                                        "03:35 PM - 3 October 2022",
                                        style: StaticTextStyle().boldTextStyle.copyWith(
                                            fontSize: 12.sp,
                                            fontFamily: arimoBold,
                                            color:ColorConstants.whiteColor
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
                            myReservations?.isRedeemed=="0"?"Status: Not-Redeemed" :"Status: Redeemed",
                            style: StaticTextStyle().boldTextStyle.copyWith(
                                fontSize: 10.sp,
                                color:ColorConstants.appPrimaryColor
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
          }),
        );
      }
    );
  }
}