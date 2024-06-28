import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:linedup_app/Components/Extentions/PaddingExtentions.dart';
import 'package:linedup_app/Components/StaticTextStyle/StaticTextStyle.dart';
import 'package:linedup_app/Controllers/AllReservationService/AllReservationsService.dart';
import 'package:linedup_app/Providers/AllReservationProvider/AllReservationProvider.dart';
import 'package:linedup_app/Utils/Constants/AssetConstants/AssetConstants.dart';
import 'package:linedup_app/Utils/Constants/ColorConstants/ColorConstants.dart';
import 'package:linedup_app/Utils/Constants/RouteConstants/RouteConstants.dart';
import 'package:provider/provider.dart';
import '../../Components/CacheNetworkImage/CacheNetworkImage.dart';
import '../../Components/CustomOutlineTextField/CustomOutlineTextField.dart';

class WalletTabBarPage extends StatefulWidget {
  const WalletTabBarPage({super.key});

  @override
  State<WalletTabBarPage> createState() => _WalletTabBarPageState();
}

class _WalletTabBarPageState extends State<WalletTabBarPage> {
 List<String>? weekDayLabels = [
   "Mo",
   "Tu",
   "We",
   "Th",
   "Fr",
   "Sa",
   "Su"
 ];

  List<DateTime>? dateTime= [];
AllReservationsService allReservationsService = AllReservationsService();
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    allReservationsService.getAllReservations(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AllReservationProvider>(
        builder: (context, reservationProvider,_) {
          var reservation = reservationProvider.allReservationsModel;
          return reservation?.data==null?Center(child: CircularProgressIndicator(
            color: ColorConstants.appPrimaryColor,
          ),) :Padding(
            padding:  EdgeInsets.only(top: PaddingExtensions.screenTopPadding,left: 16.sp,right: 16.sp),
            child: Column(
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
                    SvgPicture.asset(AssetConstants.locationOutLineIcon,height: 22.sp,),
                  ],
                ),
                Padding(
                  padding:  EdgeInsets.symmetric(vertical: 15.sp),
                  child: Row(
                    children: [
                      Expanded(
                          child:
                          CustomOutlineTextFormField(
                            hintText: "Search",
                            filled: true,
                            filledColor: ColorConstants.eventsContainerColor,
                            borderSideColor: ColorConstants.whiteColor.withOpacity(0.sp),
                            borderRadius: 30.sp,
                            contentPadding: EdgeInsets.only(left: 24.sp, top: 10.sp, bottom: 10.sp),
                            suffixIcon: Icon(
                              Icons.search,
                              size: 20.sp,
                              color: ColorConstants.textGreyColor,
                            ),
                          ),

                      ),
                      SizedBox(
                        width: 10.sp,
                      ),
                      InkWell(
                          onTap: ()async{
                            var results = await showCalendarDatePicker2Dialog(
                              context: context,
                              config: CalendarDatePicker2WithActionButtonsConfig(
                                  calendarType: CalendarDatePicker2Type.range,
                                disableMonthPicker: true,
                                disableModePicker: true,
                                centerAlignModePicker: true,
                                allowSameValueSelection: true,
                                calendarViewScrollPhysics: PageScrollPhysics(),
                                disabledDayTextStyle: StaticTextStyle().regular.copyWith(
                                  fontSize: 12.sp,
                                  color: ColorConstants.blackColor
                                ),
                                lastMonthIcon:Icon(Icons.arrow_back_ios,size: 15.sp,),
                                nextMonthIcon:Icon(Icons.arrow_forward_ios,size: 15.sp,) ,
                                calendarViewMode:CalendarDatePicker2Mode.day,
                                selectedDayHighlightColor: ColorConstants.appPrimaryColor,
                                selectedDayTextStyle: StaticTextStyle().regular.copyWith(
                                  color: ColorConstants.whiteColor,
                                ),
                                dayTextStyle: StaticTextStyle().regular.copyWith(
                                  fontSize: 12.sp,
                                  color: ColorConstants.blackColor
                                ),
                                weekdayLabelTextStyle: StaticTextStyle().regular.copyWith(
                                  color: ColorConstants.blackColor
                                ),
                                weekdayLabels: weekDayLabels!
                              ),
                              dialogSize:  Size.copy(Size(330.sp, 400.sp)),
                              value: dateTime!,
                            );
                          },
                          child: SvgPicture.asset(AssetConstants.filterCalendar,color: ColorConstants.appPrimaryColor,))
                    ],
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "All Reservations",
                      style: StaticTextStyle().boldTextStyle.copyWith(
                        fontSize: 16.sp,
                        color: ColorConstants.blackColor
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.sp,
                ),
                Expanded(
                    child: ListView.builder(
                        itemCount: reservation!.data!.length,
                        physics: BouncingScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemBuilder: (context,index){
                          var myReservations = reservation.data![index];
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
                                              color: myReservations.type=="Event Ticket" || myReservations.type=="Reservation"? ColorConstants.appPrimaryColor: ColorConstants.whiteColor,
                                            ),
                                            color:  myReservations.type=="Reservation"? ColorConstants.whiteColor:ColorConstants.whiteColor.withOpacity(0.0.sp),
                                          ),
                                          child:
                                           Text(
                                             myReservations.type.toString()??"",
                                             style: StaticTextStyle().boldTextStyle.copyWith(
                                               fontSize: 10.sp,
                                               color: myReservations.type=="Event Ticket" || myReservations.type=="Reservation"? ColorConstants.blackColor:ColorConstants.whiteColor,
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
                                                  "Beach Concert",
                                                  style: StaticTextStyle().boldTextStyle.copyWith(
                                                      fontSize: 16.sp,
                                                    color:myReservations.type=="Event Ticket" || myReservations.type=="Reservation"?ColorConstants.blackColor:ColorConstants.whiteColor
                                                  ),
                                                ),

                                                Padding(
                                                  padding:  EdgeInsets.symmetric(vertical: 5.sp),
                                                  child: Row(
                                                    children: [
                                                      SvgPicture.asset(AssetConstants.locationOutLineIcon,color:myReservations.type=="Event Ticket" || myReservations.type=="Reservation"?ColorConstants.blackColor:ColorConstants.whiteColor,height: 18.sp,),
                                                      SizedBox(
                                                        width: 5.sp,
                                                      ),
                                                      Text(
                                                        "${myReservations.getBarDetail!.venue.toString()??""} , ${myReservations.getBarDetail!.address}",
                                                        style: StaticTextStyle().regular.copyWith(
                                                            fontSize: 12.sp,
                                                          color: myReservations.type=="Event Ticket" || myReservations.type=="Reservation"? ColorConstants.blackColor:ColorConstants.whiteColor
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    SvgPicture.asset(AssetConstants.calendarOutline,color: myReservations.type=="Event Ticket" || myReservations.type=="Reservation"?ColorConstants.blackColor:ColorConstants.whiteColor,),
                                                    SizedBox(
                                                      width: 5.sp,
                                                    ),
                                                    Text(
                                                      "03:35 PM - 3 October 2022",
                                                      style: StaticTextStyle().regular.copyWith(
                                                          fontSize: 12.sp,
                                                          fontFamily: arimoBold,
                                                        color: myReservations.type=="Event Ticket" || myReservations.type=="Reservation"?ColorConstants.blackColor:ColorConstants.whiteColor
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
                                          myReservations.isRedeemed!=0?"Status: Not-Redeemed" :"Status: Redeemed",
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
          );
        }
      ),
    );
  }
}
