import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:linedup_app/Components/CacheNetworkImage/CacheNetworkImage.dart';
import 'package:linedup_app/Components/StaticTextStyle/StaticTextStyle.dart';
import 'package:linedup_app/Providers/BarDetailProvider/BarDetailProvider.dart';
import 'package:linedup_app/Providers/BeachBarDetailProvider/BeachBarDetailProvider.dart';
import 'package:linedup_app/Utils/Constants/AssetConstants/AssetConstants.dart';
import 'package:linedup_app/Utils/Constants/ColorConstants/ColorConstants.dart';
import 'package:provider/provider.dart';

import '../../Components/CustomAppButton/CustomAppButton.dart';

class EventsTabPage extends StatefulWidget {
  const EventsTabPage({super.key});

  @override
  State<EventsTabPage> createState() => _EventsTabPageState();
}

class _EventsTabPageState extends State<EventsTabPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Consumer<BarDetailProvider>(
        builder: (context, barDetailProvider,_) {
          String? price;
          barDetailProvider.barDetailsResponseModel?.data?.barEvents?.forEach((e){
             price = e.price;
          });
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
                        "\$${price}",
                        style: StaticTextStyle().regular.copyWith(
                            fontSize: 18.sp,
                            color: ColorConstants.blackColor,
                            fontFamily: abelBold
                        ),
                      ),
                    ),
                  ],
                ),
                CustomAppButton(
                  title: "BUY TICKET",
                  width: 160.sp,
                  height: 52.sp,
                  btnRadius: 12.sp,
                  onPress: (){},
                  imageButtonIcon: SvgPicture.asset(AssetConstants.ticketIcon),
                )
              ],
            ),
          );
        }
      ),
      body: Consumer2<BeachBarDetailProvider,BarDetailProvider>(
        builder: (context, beachBarProvider,barDetailProvider,_) {
          return ListView.builder(
              itemCount: barDetailProvider.barDetailsResponseModel!.data!.barEvents!.length,
              padding: EdgeInsets.zero,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context,index){
                var event =  barDetailProvider.barDetailsResponseModel!.data!.barEvents![index];
            return Container(
              padding: EdgeInsets.all(12.sp),
              margin: EdgeInsets.only(top: 15.sp),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.sp),
                color: ColorConstants.eventsContainerColor
              ),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ImageWidget(
                        imageUrl: AssetConstants.partyImage,
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
                              event.title??"",
                              style: StaticTextStyle().boldTextStyle.copyWith(
                                  color: ColorConstants.blackColor,
                                  fontSize: 16.sp,
                                  decoration: TextDecoration.underline,
                                  decorationColor: ColorConstants.blackColor
                              ),
                            ),
                            SizedBox(
                              height: 10.sp,
                            ),
                            Text(
                              event.startTime??"",
                              style: StaticTextStyle().regular.copyWith(
                                  fontSize: 12.sp,
                                  fontFamily: englishMedium,
                                  color: ColorConstants.textGreyColor
                              ),
                            ),
                            Text(
                              event.endTime??"",
                              style: StaticTextStyle().regular.copyWith(
                                  fontSize: 12.sp,
                                  fontFamily: englishMedium,
                                  color: ColorConstants.textGreyColor
                              ),
                            ),
                            SizedBox(
                              height: 10.sp,
                            ),
                            Text(
                              event.about??"",
                              style: StaticTextStyle().regular.copyWith(
                                  fontSize: 12.sp,
                                  color: ColorConstants.blackColor
                              ),
                            )

                          ],
                        ),
                      ),
                      Checkbox(
                          activeColor: ColorConstants.appPrimaryColor,
                          side: const BorderSide(
                            color: ColorConstants.appPrimaryColor,
                          ),
                          splashRadius: 0.sp,
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          visualDensity: VisualDensity.compact,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(3.sp)
                          ),
                          value:barDetailProvider.isCheck , onChanged: barDetailProvider.setValue),

                    ],
                  ),

                ],
              ),
            );
          });
        }
      ),
    );
  }
}
