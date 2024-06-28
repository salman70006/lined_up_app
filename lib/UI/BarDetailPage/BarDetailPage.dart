import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:linedup_app/Components/ratingWidget/ratingWidget.dart';
import 'package:linedup_app/Controllers/BarDetailService/BarDetailService.dart';
import 'package:linedup_app/Providers/BarDetailProvider/BarDetailProvider.dart';
import 'package:linedup_app/UI/EventsTabPage/EventsTabPage.dart';
import 'package:linedup_app/UI/ReservationTabPage/ReservationTabPage.dart';
import 'package:provider/provider.dart';

import '../../Components/BackButtonWidget/BackButtonWidget.dart';
import '../../Components/CacheNetworkImage/CacheNetworkImage.dart';
import '../../Components/CustomAppButton/CustomAppButton.dart';
import '../../Components/StaticTextStyle/StaticTextStyle.dart';
import '../../Utils/Constants/AssetConstants/AssetConstants.dart';
import '../../Utils/Constants/ColorConstants/ColorConstants.dart';

class BarDetailPage extends StatefulWidget {
  var barId;
   BarDetailPage({this.barId});

  @override
  State<BarDetailPage> createState() => _BarDetailPageState();
}

class _BarDetailPageState extends State<BarDetailPage> with SingleTickerProviderStateMixin{
  TabController? _controller;
BarDetailService barDetailService = BarDetailService();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TabController(length: 2, vsync: this);
    barDetailService.barDetail(context, widget.barId);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Consumer<BarDetailProvider>(
        builder: (context, barDetailProvider,_) {
         var barData = barDetailProvider.barDetailsResponseModel;

          return barData?.data==null?Center(
            child: CircularProgressIndicator(
              color: ColorConstants.appPrimaryColor,
            ),
          ): Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    Stack(
                      children: [
                        ImageWidget(
                          imageUrl: barData!.data!.barDetails?.coverImage,
                          imageHeight: 370.sp,
                          imageWidth: double.infinity,
                          fit: BoxFit.cover,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20.sp), bottomRight: Radius.circular(20.sp)),
                        ),
                        Container(
                          height: 370.sp,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20.sp), bottomRight: Radius.circular(20.sp)),
                            gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [
                              const Color(0xff000000).withOpacity(0.sp),
                              const Color(0xff000000).withOpacity(0.5.sp),
                            ]),
                          ),
                        ),
                        Container(
                          height: 370.sp,
                          width: double.infinity,
                          padding: EdgeInsets.only(left: 15.sp, top: 40.sp, bottom: 10.sp, right: 15.sp),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      BackButtonWidget(
                                        height: 40.sp,
                                        width: 40.sp,
                                        icon: Icons.arrow_back_ios,
                                        iconSize: 18.sp,
                                        leftPadding: 8.sp,
                                        iconColor: ColorConstants.whiteColor,
                                        containerColor: ColorConstants.whiteColor.withOpacity(0.4),
                                        borderColor: ColorConstants.whiteColor.withOpacity(0.0),
                                        borderRadius: 8.sp,
                                        onPress: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      Column(
                                        children: [
                                          BackButtonWidget(
                                            height: 40.sp,
                                            width: 40.sp,
                                            imageWidget: SvgPicture.asset(
                                              AssetConstants.favouriteIcon,
                                              color: ColorConstants.whiteColor,
                                            ),
                                            containerColor: ColorConstants.whiteColor.withOpacity(0.3),
                                            borderColor: ColorConstants.whiteColor.withOpacity(0.sp),
                                            borderRadius: 8.sp,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        barData.data?.barDetails?.venue.toString()??"",
                                        style: StaticTextStyle()
                                            .regular
                                            .copyWith(fontSize: 24.sp, letterSpacing: 1.sp, fontFamily: abelBold),
                                      ),
                                      Container(
                                        height: 200.sp.sp,
                                        width: 50.sp,
                                        margin: EdgeInsets.only(top: 80.sp),
                                        alignment: AlignmentDirectional.bottomEnd,
                                        child: ListView.builder(
                                            itemCount: barData.data!.barDetails!.barInfo!.length,
                                            shrinkWrap: true,
                                            physics: NeverScrollableScrollPhysics(),
                                            padding: EdgeInsets.zero,
                                            scrollDirection: Axis.vertical,
                                            itemBuilder: (context, index) {
                                             var detail = barData.data!.barDetails!.barInfo![index];
                                              return Column(
                                                children: [
                                                  ImageWidget(
                                                    imageUrl:detail,
                                                    height: 50.sp,
                                                    width: 50.sp,
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(8.sp),
                                                        border:
                                                        Border.all(color: ColorConstants.whiteColor, width: 2.sp)),
                                                    borderRadius: BorderRadius.circular(8.sp),
                                                    fit: BoxFit.cover,
                                                  ),
                                                  SizedBox(height: 10.sp)
                                                ],
                                              );
                                            }),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),

                  Padding(
                    padding:  EdgeInsets.only(left: 16.sp,right: 16.sp),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.sp),
                          child: Text(
                            "About Us",
                            style: StaticTextStyle()
                                .regular
                                .copyWith(fontSize: 16.sp, fontFamily: abelBold, color: ColorConstants.blackColor),
                          ),
                        ),
                        Text(
                          barData.data?.barDetails?.aboutUs.toString()??"",
                          style: StaticTextStyle()
                              .regular
                              .copyWith(fontSize: 12.sp, fontFamily: abelBold, color: ColorConstants.textGreyColor),
                        ),
                        Padding(
                          padding:  EdgeInsets.symmetric(vertical: 10.sp),
                          child: RatingWidget(
                            initialRating: double.parse(barData.data!.review!.rating.toString()),
                            ignoreGestures: true,
                          ),
                        ),
                        Row(
                          children: [
                            SvgPicture.asset(AssetConstants.locationIcon),
                            SizedBox(
                              width: 5.sp,
                            ),
                            SizedBox(
                              width: 300.sp,
                              child: Text(
                                barData.data?.barDetails?.address.toString()??"",
                                style: StaticTextStyle().regular.copyWith(
                                    fontSize: 12.sp,
                                    color: ColorConstants.blackColor,
                                    fontFamily: abelBold
                                ),
                              ),
                            ),
                          ],
                        ),

                        Padding(
                          padding:  EdgeInsets.symmetric(vertical: 15.sp),
                          child: Text(
                            "You cannot cancel/refund any purchases. If there is an issue please contact LinedUp’s support team. Thank you.",
                            style: StaticTextStyle().regular.copyWith(
                                fontSize: 12.sp,
                                color: ColorConstants.blackColor,
                                fontFamily: abelBold
                            ),
                          ),
                        ),
                        TabBar(
                          controller: _controller,
                          labelColor: ColorConstants.blackColor,
                          unselectedLabelColor: ColorConstants.tabUnselectedColor,
                          indicatorSize: TabBarIndicatorSize.tab,
                          indicatorColor: ColorConstants.appPrimaryColor,
                          labelStyle: StaticTextStyle().regular.copyWith(
                            fontSize: 12.sp,
                          ),
                          padding: EdgeInsets.zero,
                          labelPadding: EdgeInsets.zero,
                          tabAlignment: TabAlignment.fill,
                          overlayColor: MaterialStatePropertyAll(ColorConstants.whiteColor),
                          tabs: [
                            Tab(
                              text: "Reservations",
                            ),

                            Tab(
                              text: "Events",
                            ),
                          ],
                        ),
                        Container(
                          height:600.sp,
                          child: TabBarView(
                            controller: _controller,
                            children: [
                              ReservationTabPage(),
                              EventsTabPage()
                            ],
                          ),
                        ),
                      ],
                    ),
                  )

                  ],
                ),
              ),


            ],
          );
        }
      ),
    );
  }
}
