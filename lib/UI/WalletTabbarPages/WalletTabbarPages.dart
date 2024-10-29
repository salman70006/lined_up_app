import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:custom_date_range_picker/custom_date_range_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:com.zat.linedup/Components/CustomAppButton/CustomAppButton.dart';
import 'package:com.zat.linedup/Components/EventTicketWidget/EventTicketWidget.dart';
import 'package:com.zat.linedup/Components/ExpressReservationWidget/ExpressReservartionWidget.dart';
import 'package:com.zat.linedup/Components/Extentions/PaddingExtentions.dart';
import 'package:com.zat.linedup/Components/ReservationWidget/ReservationWidget.dart';
import 'package:com.zat.linedup/Components/StaticTextStyle/StaticTextStyle.dart';
import 'package:com.zat.linedup/Controllers/AllReservationService/AllReservationsService.dart';
import 'package:com.zat.linedup/Providers/AllReservationProvider/AllReservationProvider.dart';
import 'package:com.zat.linedup/Utils/Constants/AssetConstants/AssetConstants.dart';
import 'package:com.zat.linedup/Utils/Constants/ColorConstants/ColorConstants.dart';
import 'package:com.zat.linedup/Utils/Constants/RouteConstants/RouteConstants.dart';
import 'package:com.zat.linedup/globals.dart';
import 'package:provider/provider.dart';
import 'package:super_tooltip/super_tooltip.dart';
import '../../Components/CacheNetworkImage/CacheNetworkImage.dart';
import '../../Components/CustomOutlineTextField/CustomOutlineTextField.dart';
import '../../Components/ScaffoldMessageWidget/ScaffoldMessageWidget.dart';
import '../../Components/TooltipContent/ReservationFilterContent.dart';

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
 DateTime? startDate;
 DateTime? endDate;
 final formattedEndDate = DateFormat('yyyy-MM-d');
 final formattedStartDate = DateFormat('yyyy-MM-d');

 final tooltipController = SuperTooltipController();
  List<DateTime>? dateTime= [];
TextEditingController searchController = TextEditingController();
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    AllReservationsService().getAllReservations(context);
    startDate = DateTime.now();
    endDate = DateTime.now();
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Icon(Icons.arrow_back_ios,size: 20.sp,),
                    Text(
                        "Wallet",
                    style: StaticTextStyle().boldTextStyle.copyWith(
                      fontSize: 16.sp,
                      color: ColorConstants.blackColor
                    ),
                    ),
                    // SvgPicture.asset(AssetConstants.locationOutLineIcon,height: 22.sp,),
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
                            controller: searchController,
                            cursorColor: ColorConstants.blackColor,
                            filledColor: ColorConstants.eventsContainerColor,
                            borderSideColor: ColorConstants.whiteColor.withOpacity(0.sp),
                            textInputAction: TextInputAction.search,
                            borderRadius: 30.sp,
                            contentPadding: EdgeInsets.only(left: 24.sp, top: 10.sp, bottom: 10.sp),
                            onFieldSubmitted: (value)async{
                              var response  = await AllReservationsService().applyFilter(context, "", searchController.text, "", "");
                              if(response?.responseData?.success==true){
                                ShowMessage().showMessage(context, "${response?.responseData?.message}", ColorConstants.appPrimaryColor);
                                FocusScope.of(context).unfocus();
                                Navigator.of(context).pushNamed(RouteConstants.reservationSearchRoute);
                              }else{
                                ShowMessage().showMessage(context, "${response?.responseData?.message}", ColorConstants.redColor);

                              }
                            },
                            suffixIcon: InkWell(
                              onTap: ()async{
                                var response  = await AllReservationsService().applyFilter(context, "", searchController.text, "", "");
                                if(response?.responseData?.success==true){
                                  ShowMessage().showMessage(context, "${response?.responseData?.message}", ColorConstants.appPrimaryColor);
                                  FocusScope.of(context).unfocus();
                                  Navigator.of(context).pushNamed(RouteConstants.reservationSearchRoute);
                                }else{
                                  ShowMessage().showMessage(context, "${response?.responseData?.message}", ColorConstants.redColor);

                                }
                              },
                              child: Icon(
                                Icons.search,
                                size: 20.sp,
                                color: ColorConstants.textGreyColor,
                              ),
                            ),
                            onChanged: (value){
                              if(value.isNotEmpty){
                                reservationProvider.filterResponseModel?.filterReservationData?.where((element)=>element.getBarEvent!.title!.toLowerCase().contains(searchController.text)).toList();

                              }
                            },
                          ),

                      ),
                      SizedBox(
                        width: 10.sp,
                      ),
                      InkWell(
                          onTap: ()async{
                            // var results = await showCalendarDatePicker2Dialog(
                            //   context: context,
                            //   config: CalendarDatePicker2WithActionButtonsConfig(
                            //       calendarType: CalendarDatePicker2Type.range,
                            //     disableMonthPicker: true,
                            //     disableModePicker: true,
                            //     centerAlignModePicker: true,
                            //     allowSameValueSelection: true,
                            //     okButton: CustomAppButton(
                            //       title: "Submit",
                            //       height: 20.sp,
                            //       width: 50.sp,
                            //       onPress: (){},
                            //     ),
                            //     calendarViewScrollPhysics: PageScrollPhysics(),
                            //     disabledDayTextStyle: StaticTextStyle().regular.copyWith(
                            //       fontSize: 12.sp,
                            //       color: ColorConstants.blackColor
                            //     ),
                            //     lastMonthIcon:Icon(Icons.arrow_back_ios,size: 15.sp,),
                            //     nextMonthIcon:Icon(Icons.arrow_forward_ios,size: 15.sp,) ,
                            //     calendarViewMode:CalendarDatePicker2Mode.day,
                            //     selectedDayHighlightColor: ColorConstants.appPrimaryColor,
                            //     selectedDayTextStyle: StaticTextStyle().regular.copyWith(
                            //       color: ColorConstants.whiteColor,
                            //     ),
                            //     dayTextStyle: StaticTextStyle().regular.copyWith(
                            //       fontSize: 12.sp,
                            //       color: ColorConstants.blackColor
                            //     ),
                            //     weekdayLabelTextStyle: StaticTextStyle().regular.copyWith(
                            //       color: ColorConstants.blackColor
                            //     ),
                            //     weekdayLabels: weekDayLabels!
                            //   ),
                            //   dialogSize:  Size.copy(Size(330.sp, 400.sp)),
                            //   value: dateTime!,
                            //
                            // );
                            showCustomDateRangePicker(
                              context,
                              dismissible: true,
                              minimumDate: DateTime.now().subtract(const Duration(days: 30)),
                              maximumDate: DateTime.now().add(const Duration(days: 30)),
                              endDate: endDate,
                              startDate: startDate,
                              backgroundColor: Colors.white,
                              fontFamily: englishMedium,
                              primaryColor: ColorConstants.appPrimaryColor,
                              onApplyClick: (start, end) {
                                setState(() async{
                                  endDate = end;
                                  startDate = start;
                                 var selectedStartDate = formattedStartDate.format(DateTime.parse(startDate.toString()));
                                 var selectedEndDate = formattedEndDate.format(DateTime.parse(endDate.toString()));
                                 print(selectedStartDate);
                                  var response  = await AllReservationsService().applyFilter(context, "",  "", selectedStartDate.toString(),selectedEndDate.toString());
                                  if(response?.responseData?.success==true){
                                    ShowMessage().showMessage(context, "${response?.responseData?.message}", ColorConstants.appPrimaryColor);
                                    FocusScope.of(context).unfocus();
                                    Navigator.of(context).pushNamed(RouteConstants.reservationSearchRoute);
                                  }else{
                                    ShowMessage().showMessage(context, "${response?.responseData?.message}", ColorConstants.redColor);

                                  }
                                });
                              },
                              onCancelClick: () {
                                setState(() {
                                  endDate = null;
                                  startDate = null;
                                });
                              },
                            );
                          },
                          child: SvgPicture.asset(AssetConstants.filterCalendar,color: ColorConstants.appPrimaryColor,))
                    ],
                  ),
                ),
                InkWell(
                  onTap: (){
                    tooltipController.showTooltip();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "All Reservations",
                        style: StaticTextStyle().boldTextStyle.copyWith(fontSize: 16.sp, color: ColorConstants.blackColor),
                      ),
                      SuperTooltip(
                        arrowLength: 0,
                        arrowTipDistance: 18.sp,
                        minimumOutsideMargin: 14.w,
                        borderColor: Colors.transparent,
                        shadowColor: ColorConstants.blackColor.withOpacity(0.12),
                        barrierColor: Colors.transparent,
                        controller: tooltipController,
                        content: ReservationFiltersContent(),
                        child: Row(
                          children: [
                            Text(
                              "Filter",
                              style: StaticTextStyle().boldTextStyle.copyWith(fontSize: 11.sp, color: ColorConstants.blackColor),
                            ),
                            Icon(
                                Icons.arrow_drop_down_sharp,
                                size: 25.sp
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
                Expanded(
                    child: reservationProvider.filterType[0]=="Reservation" && reservationProvider.isCheckedList[0]? ReservationWidget()
                   : reservationProvider.filterType[1]=="Express Reservation" && reservationProvider.isCheckedList[1]?
                      ExpressReservationWidget():reservationProvider.filterType[2]=="Event Ticket" && reservationProvider.isCheckedList[2]? EventTicketWidget() :reservation!.data!.isEmpty?Center(child: Text("No Reservations or Tickets purchased!")) :ListView.builder(
                        itemCount: reservation.data!.length,
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
                                                          "${myReservations.getBarDetail?.venue.toString()??""} , ${myReservations.getBarDetail?.address}",
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
          );
        }
      ),
    );
  }
}
