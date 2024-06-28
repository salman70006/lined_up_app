import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:linedup_app/Components/CustomAppButton/CustomAppButton.dart';
import 'package:linedup_app/Components/StaticTextStyle/StaticTextStyle.dart';
import 'package:linedup_app/Controllers/BarDetailService/BarDetailService.dart';
import 'package:linedup_app/Providers/BarDetailProvider/BarDetailProvider.dart';
import 'package:linedup_app/Providers/BeachBarDetailProvider/BeachBarDetailProvider.dart';
import 'package:linedup_app/Utils/Constants/AssetConstants/AssetConstants.dart';
import 'package:linedup_app/Utils/Constants/ColorConstants/ColorConstants.dart';
import 'package:linedup_app/Utils/Constants/RouteConstants/RouteConstants.dart';
import 'package:provider/provider.dart';

class ReservationTabPage extends StatefulWidget {
  const ReservationTabPage({super.key});

  @override
  State<ReservationTabPage> createState() => _ReservationTabPageState();
}

class _ReservationTabPageState extends State<ReservationTabPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<BeachBarDetailProvider,BarDetailProvider>(
      builder: (context, beachBarDetailProvider,barDetailProvider,_) {
       var applyReservation = barDetailProvider.reservationBookingResponseModel;
        return Scaffold(
          bottomNavigationBar: Container(
            color: ColorConstants.whiteColor,
            height: 110.sp,
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
                      "Total Price",
                      style: StaticTextStyle().regular.copyWith(
                          fontSize: 12.sp,
                          color: ColorConstants.blackColor.withOpacity(0.5),
                          fontFamily: abelBold
                      ),
                    ),
                    Padding(
                      padding:  EdgeInsets.symmetric(vertical: 5.sp),
                      child: Text(
                        "\$480",
                        style: StaticTextStyle().regular.copyWith(
                            fontSize: 18.sp,
                            color: ColorConstants.blackColor,
                            fontFamily: abelBold
                        ),
                      ),
                    ),
                    Text(
                      "Members 5",
                      style: StaticTextStyle().regular.copyWith(
                          fontSize: 18.sp,
                          color: ColorConstants.blackColor,
                          fontFamily: abelBold
                      ),
                    ),
                  ],
                ),
                CustomAppButton(
                  title: "Reserve Now",
                  width: 145.sp,
                  height: 45.sp,
                  btnRadius: 12.sp,
                  textColor:ColorConstants.whiteColor,
                  onPress: (){
                    _showMembersDialog(context);
                  },
                )
              ],
            ),
          ),

          body: Consumer<BarDetailProvider>(
            builder: (context, barDetailProvider,_) {
              var applyReservation = barDetailProvider.barDetailsResponseModel;
              return applyReservation?.data==null?Center(child: CircularProgressIndicator(color: ColorConstants.appPrimaryColor,)) :SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 20.sp,
                    ),
                    Text(
                      "When you reserve atime slot you must show the doorman the reservation between 5 minutes before your reserved time, up to 10 minutes after.",
                      style: StaticTextStyle().regular.copyWith(
                        fontFamily: abelBold,
                        fontSize: 12.sp,
                        color: ColorConstants.blackColor
                      ),
                    ),
                    Container(
                      height: 55.sp,
                      width: double.infinity,
                      margin: EdgeInsets.only(top: 10.sp),
                      child: ListView.builder(
                          itemCount: beachBarDetailProvider.days.length,
                          physics: BouncingScrollPhysics(),
                          padding: EdgeInsets.zero,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context,index){
                            return beachBarDetailProvider.selectedDay.contains(beachBarDetailProvider.days[index])? Row(
                              children: [
                                Container(
                                  height: 48.sp,
                                  width: 44.sp,
                                  margin: EdgeInsets.only(right:beachBarDetailProvider.selectedDay.contains(beachBarDetailProvider.days[index])? 10.sp:0.sp),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16.sp),
                                    color: ColorConstants.dayBoxColor
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        beachBarDetailProvider.days[index],
                                        style: StaticTextStyle().regular.copyWith(
                                          fontSize: 11.sp,
                                          color: ColorConstants.daysTextColor,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      Container(
                                        height: 5.sp,
                                        width: 5.sp,
                                        margin: EdgeInsets.symmetric(vertical:10.sp),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: ColorConstants.daysDotColor
                                        ),
                                      )
                                    ],
                                  ),
                                ),

                              ],
                            ):
                            InkWell(
                              onTap: (){
                                beachBarDetailProvider.check(beachBarDetailProvider.days[index]);
                              },
                              child:  Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    beachBarDetailProvider.days[index],
                                    style: StaticTextStyle().regular.copyWith(
                                      fontSize: 11.sp,
                                      color: ColorConstants.daysTextColor,
                                    ),
                                  ),
                                  SizedBox(width: 35.sp,),

                                ],
                              )
                            )
                            ;

                          }),
                    ),
                    Column(
                      children: [
                        Text(
                          "Non Peak",
                          style: StaticTextStyle().regular.copyWith(
                            color: ColorConstants.aboutBlackColor,
                            fontFamily: abelBold,
                            fontSize:12.sp
                          ),
                        ),
                        Container(
                          height: 2.sp,
                          width: 166.sp,
                          margin: EdgeInsets.symmetric(vertical: 10.sp),
                          color: ColorConstants.appPrimaryColor,
                        )
                      ],
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(AssetConstants.timeslotIcon),
                        SizedBox(width: 5.sp,),
                        Text(
                            "Choose time-slot for booking",
                        style: StaticTextStyle().regular.copyWith(
                          fontSize: 12.sp,
                          fontFamily: abelBold,
                          color: ColorConstants.textGreyColor
                        ),
                        ),
                      ],
                    ),
                    Container(
                      height: 120.sp,
                      margin: EdgeInsets.only(top:5.sp),
                      child: GridView.builder(
                          itemCount: beachBarDetailProvider.timeSlots.length,
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              crossAxisSpacing: 5.sp,
                              mainAxisSpacing: 5.sp,
                              childAspectRatio: 2.3 / 1.7),
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                InkWell(
                                  onTap: (){
                                    beachBarDetailProvider.checkTime(beachBarDetailProvider.timeSlots[index]);
                                  },
                                  child: Container(
                                    width: 80.sp,
                                    height: 40.sp,
                                    padding: EdgeInsets.all(10.sp),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.sp),
                                      color: beachBarDetailProvider.selectedTime.contains(beachBarDetailProvider.timeSlots[index]) && beachBarDetailProvider.timeSlots[index]!="N/A"?ColorConstants.appPrimaryColor:ColorConstants.notAvailableColor,
                                    ),
                                    child: Text(
                                      beachBarDetailProvider.timeSlots[index],
                                    style: StaticTextStyle().regular.copyWith(
                                      fontFamily: abelBold
                                    ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                Text("4 left", style: StaticTextStyle().regular.copyWith(
                                    fontFamily: abelBold,
                                  fontSize: 12.sp,
                                  color: ColorConstants.blackColor
                                ),)
                              ],
                            );
                          }),
                    ),
                    Column(
                      children: [
                        Text(
                          "Peak",
                          style: StaticTextStyle().regular.copyWith(
                              color: ColorConstants.aboutBlackColor,
                              fontFamily: abelBold,
                              fontSize:12.sp
                          ),
                        ),
                        Container(
                          height: 2.sp,
                          width: 166.sp,
                          margin: EdgeInsets.symmetric(vertical: 10.sp),
                          color: ColorConstants.appPrimaryColor,
                        )
                      ],
                    ),
                    Container(
                      height: 115.sp,
                      child: GridView.builder(
                          itemCount: beachBarDetailProvider.timeSlots.length,
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              crossAxisSpacing: 5.sp,
                              mainAxisSpacing: 5.sp,
                              childAspectRatio: 2.3 / 1.7),
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Container(
                                  width: 80.sp,
                                  height: 40.sp,
                                  padding: EdgeInsets.all(10.sp),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.sp),
                                    color: beachBarDetailProvider.selectedTime.contains(beachBarDetailProvider.timeSlots[index]) && beachBarDetailProvider.timeSlots[index]!="N/A"? ColorConstants.appPrimaryColor:ColorConstants.notAvailableColor,
                                  ),
                                  child: Text(
                                    beachBarDetailProvider.timeSlots[index],
                                    style: StaticTextStyle().regular.copyWith(
                                        fontFamily: abelBold
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Text("4 left", style: StaticTextStyle().regular.copyWith(
                                    fontFamily: abelBold,
                                    fontSize: 12.sp,
                                    color: ColorConstants.blackColor
                                ),)
                              ],
                            );
                          }),
                    ),
                  SizedBox(
                    height: 10.sp,
                  ),
                  Row(
                    children: [
                      Text("\$5",
                      style: StaticTextStyle().regular.copyWith(
                        fontSize: 18.sp,
                        fontFamily: abelBold,
                        color: ColorConstants.appPrimaryColor
                      ),),
                      Text("/Non-Peak",
                        style: StaticTextStyle().regular.copyWith(
                            fontSize: 12.sp,
                            fontFamily: abelBold,
                            color: ColorConstants.textGreyColor
                        ),)
                    ],
                  ),
                  Row(
                    children: [
                      Text("\$10",
                      style: StaticTextStyle().regular.copyWith(
                        fontSize: 18.sp,
                        fontFamily: abelBold,
                        color: ColorConstants.appPrimaryColor
                      ),),
                      Text("/Peak",
                        style: StaticTextStyle().regular.copyWith(
                            fontSize: 12.sp,
                            fontFamily: abelBold,
                            color: ColorConstants.textGreyColor
                        ),)
                    ],
                  ),
                    Padding(
                      padding:  EdgeInsets.symmetric(vertical: 5.sp),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Note:",
                            style: StaticTextStyle().regular.copyWith(
                              fontSize: 16.sp,
                              fontFamily: abelBold,
                              color: ColorConstants.blackColor
                            ),
                          ),
                          Container(
                            width: 290.sp,
                            padding: EdgeInsets.only(top: 2.sp,left: 5.sp),
                            child: Text(
                              "Maximum 10 members per ticket, all members of the party must be present at the time of redemption.",
                              style: StaticTextStyle().regular.copyWith(
                                  fontSize: 12.sp,
                                  fontFamily: abelBold,
                                  color: ColorConstants.blackColor
                              ),
                              textAlign: TextAlign.justify,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      thickness: 1.sp,
                      color: ColorConstants.textGreyColor,
                    ),
                    Text(
                      "Don’t worry about rushing to the bar for a specific time. Express Reservations can be used at any time throughout the night! Walk up to thedoorman, show them your express reservation,  and start your night without the wait!",
                      style: StaticTextStyle().regular.copyWith(
                        fontSize: 12.sp,
                        color: ColorConstants.blackColor
                      ),
                    ),
                    Padding(
                      padding:  EdgeInsets.symmetric(vertical: 10.sp),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: CustomAppButton(
                              title: "Purchase Express Reservation",
                              fontFamily: abelBold,
                              width: 225.sp,
                              height: 50.sp,
                              onPress: ()async{
                                // var total = applyReservation!.data!.expressReservation?.price * beachBarDetailProvider.selectedMember[0]  ;
                                var response = await BarDetailService().reservationBooking(context, applyReservation!.data!.barDetails!.id.toString(), "Express Reservation", beachBarDetailProvider.selectedMember, "", "", "", "", applyReservation.data!.expressReservation!.id, "");
                              },
                            ),
                          ),
                          Text("50 Remaining!",style: StaticTextStyle().regular.copyWith(
                            fontSize: 12.sp,
                            fontFamily: abelBold,
                            color: ColorConstants.blackColor
                          ),)
                        ],
                      ),
                    ),
                    Padding(
                      padding:  EdgeInsets.symmetric(vertical: 15.sp),
                      child: Row(
                        children: [
                          Text("\$25",
                            style: StaticTextStyle().regular.copyWith(
                                fontSize: 18.sp,
                                fontFamily: abelBold,
                                color: ColorConstants.appPrimaryColor
                            ),),
                          Text("/Express Reservation",
                            style: StaticTextStyle().regular.copyWith(
                                fontSize: 12.sp,
                                fontFamily: abelBold,
                                color: ColorConstants.textGreyColor
                            ),)
                        ],
                      ),
                    ),
                    Padding(
                      padding:  EdgeInsets.symmetric(vertical: 5.sp),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Note:",
                            style: StaticTextStyle().regular.copyWith(
                                fontSize: 16.sp,
                                fontFamily: abelBold,
                                color: ColorConstants.blackColor
                            ),
                          ),
                          Container(
                            width: 290.sp,
                            padding: EdgeInsets.only(top: 2.sp,left: 5.sp),
                            child: Text(
                              "Maximum 10 members per ticket, all members of the party must be present at the time of redemption.",
                              style: StaticTextStyle().regular.copyWith(
                                  fontSize: 12.sp,
                                  fontFamily: abelBold,
                                  color: ColorConstants.blackColor
                              ),
                              textAlign: TextAlign.justify,
                            ),
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              );
            }
          ),
        );
      }
    );
  }
  void _showMembersDialog(BuildContext context){
    showDialog(context: context, builder: (context){
      return Consumer<BeachBarDetailProvider>(
        builder: (context, beachBarDetailProvider,_) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.sp),
            ),
            insetPadding: EdgeInsets.only(left: 16,right: 16.sp,top: 16.sp),
            child: Container(
              padding: EdgeInsets.only(left: 25.sp,right: 25.sp),
              height: 600.sp,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(AssetConstants.memberImage,height: 250,width: double.infinity,),
                  Center(
                    child: Text(
                      "How Many Members?",
                    style: StaticTextStyle().boldTextStyle.copyWith(
                      fontSize: 24.sp,
                      fontFamily: urbanBold,
                      color: ColorConstants.appPrimaryColor
                    ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.symmetric(vertical: 15.sp),
                    child: Center(
                      child: SizedBox(
                        width: 200.sp,
                        child: Text(
                          "Choose how many members are apart of your party",
                          textAlign: TextAlign.center,
                          style: StaticTextStyle().regular.copyWith(
                            fontSize: 16.sp,
                            color: ColorConstants.blackColor,
                            fontFamily: urbanRegular
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.symmetric(vertical: 15.sp),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            height: 32.sp,
                            width: 32.sp,
                            child: Icon(Icons.arrow_back_ios,color: ColorConstants.blackColor,size: 15.sp,)),
                        Expanded(
                          child: Container(
                            height:35.sp,
                            child: ListView.builder(
                                itemCount: beachBarDetailProvider.memberList.length,
                                padding: EdgeInsets.zero,
                                physics: BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context,index){
                                  return InkWell(
                                    onTap: (){
                                      beachBarDetailProvider.memberCount(beachBarDetailProvider.memberList[index]);
                                    },
                                    child: Container(
                                      height: 32.sp,
                                      width: 32.sp,
                                      margin: EdgeInsets.only(right: 10.sp),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8.sp),
                                        color: beachBarDetailProvider.selectedMember.contains(beachBarDetailProvider.memberList[index])? ColorConstants.appPrimaryColor:ColorConstants.memberCountBoxColor,
                                      ),
                                      child: Center(
                                        child: Text(
                                          beachBarDetailProvider.memberList[index],
                                          style: StaticTextStyle().regular.copyWith(
                                            color: beachBarDetailProvider.selectedMember.contains(beachBarDetailProvider.memberList[index])?ColorConstants.whiteColor:ColorConstants.blackColor
                                          ),
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
                            child: Icon(Icons.arrow_forward_ios,color: ColorConstants.blackColor,size: 15.sp,))
                      ],
                    ),
                  ),
                  CustomAppButton(
                    title: "Confirm",
                    onPress: (){
                      Navigator.of(context).pushNamed(RouteConstants.paymentMethodsPageRoute);
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
    });

  }

}
