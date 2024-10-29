import 'dart:io';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:com.zat.linedup/Components/ScaffoldMessageWidget/ScaffoldMessageWidget.dart';
import 'package:com.zat.linedup/Components/ratingWidget/ratingWidget.dart';
import 'package:com.zat.linedup/Controllers/AllFavouritesService/AllFavouritesService.dart';
import 'package:com.zat.linedup/Controllers/BarDetailService/BarDetailService.dart';
import 'package:com.zat.linedup/Providers/AllFavouritesProvider/AllFavouritesProvider.dart';
import 'package:com.zat.linedup/Providers/BarDetailProvider/BarDetailProvider.dart';
import 'package:com.zat.linedup/UI/EventsTabPage/EventsTabPage.dart';
import 'package:com.zat.linedup/UI/ReservationTabPage/ReservationTabPage.dart';
import 'package:provider/provider.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import '../../Components/BackButtonWidget/BackButtonWidget.dart';
import '../../Components/CacheNetworkImage/CacheNetworkImage.dart';
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
bool? isShow=true;
getData()async{
  await BarDetailService().barDetail(context,  widget.barId);

  await Future.delayed(Duration(seconds: 1),(){
    setState(() {
      isShow=false;
    });
  });
}
  // final GlobalKey<CarouselSliderState> _sliderKey = GlobalKey();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TabController(length: 2, vsync: this);
    getData();
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        if (details.delta.dx > 0) {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(

        body: Consumer2<BarDetailProvider,AllFavouritesProvider>(
          builder: (context, barDetailProvider,favouritesProvider,_) {
           var barData = barDetailProvider.barDetailsResponseModel;

            return isShow! ? Center(
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
                          Container(
                            height: 370.sp,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20.sp),
                                bottomRight: Radius.circular(20.sp)
                              )
                            ),
                            child:barData==null ?Container(
                              child: Image.asset("assets/Images/place_holder.png"),
                            ) :CarouselSlider.builder(
                                // key: _sliderKey,
                                unlimitedMode: true,
                                autoSliderDelay: Duration(seconds: 5),
                                enableAutoSlider:barData?.data!.barDetails!.barInfo?.length==1?false :true,
                                slideBuilder: (index) {
                                  return Image.network(barData.data!.barDetails!.barInfo![index],fit: BoxFit.cover);
                                },
                                slideTransform: DefaultTransform(),

                                itemCount: barData!.data!.barDetails!.barInfo!.length)
                          ),
                          // barDetailProvider.selectedImage!=null?
                          // ImageWidget(
                          //   imageUrl:barDetailProvider.selectedImage,
                          //   imageHeight: 370.sp,
                          //   imageWidth: double.infinity,
                          //   fit: BoxFit.cover,
                          //   borderRadius: BorderRadius.only(
                          //       bottomLeft: Radius.circular(20.sp), bottomRight: Radius.circular(20.sp)),
                          // ):
                          // ImageWidget(
                          //   imageUrl: barData?.data?.barDetails?.coverImage,
                          //   imageHeight: 370.sp,
                          //   imageWidth: double.infinity,
                          //   fit: BoxFit.cover,
                          //   borderRadius: BorderRadius.only(
                          //       bottomLeft: Radius.circular(20.sp), bottomRight: Radius.circular(20.sp)),
                          // ),
                          Container(
                            height: 370.sp,
                            decoration: BoxDecoration(

                              gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [
                                const Color(0xff000000).withOpacity(0.sp),
                                const Color(0xff000000).withOpacity(0.5.sp),
                              ]),
                            ),
                          ),
                          Container(
                            height:Platform.isIOS? 370.sp:385.sp,
                            width: double.infinity,
                            padding: EdgeInsets.only(left: 15.sp, top: Platform.isIOS?20.sp :40.sp, bottom: 10.sp, right: 15.sp),
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
                                              leftPadding: 0.sp,
                                              imageWidget: SvgPicture.asset(
                                                AssetConstants.favouriteIcon,
                                                color: favouritesProvider.favouriteToggleResponseModel?.data?.isLiked==true?ColorConstants.redColor:ColorConstants.whiteColor,
                                              ),
                                              containerColor: ColorConstants.whiteColor.withOpacity(0.3),
                                              borderColor: ColorConstants.whiteColor.withOpacity(0.sp),
                                              borderRadius: 8.sp,
                                              onPress: ()async{
                                                var response =await AllFavoriteService().toggle(context, barData?.data?.barDetails?.id);
                                                print(response);
                                                if(response?.responseData?.success==true && response?.responseData?.data!=null){
                                                  ShowMessage().showMessage(context, "added bar to Favorites!", ColorConstants.appPrimaryColor);
                                                }else if(response?.responseData?.success==true && response?.responseData?.data==null){
                                                  ShowMessage().showMessage(context, "removed bar from Favorites!", ColorConstants.redColor);

                                                }
                                              },
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: Platform.isAndroid? 200.sp:150.sp,
                                          child: Text(
                                            barData?.data?.barDetails?.venue.toString()??"",
                                            style: StaticTextStyle()
                                                .regular
                                                .copyWith(fontSize: 24.sp, letterSpacing: 1.sp, fontFamily: abelBold),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Container(
                                          height: 200.sp.sp,
                                          width: 50.sp,
                                          margin: EdgeInsets.only(top: 80.sp),
                                          alignment: AlignmentDirectional.bottomEnd,
                                          child: ListView.builder(
                                              itemCount: barData?.data!.barDetails!.barInfo!.length,
                                              shrinkWrap: true,
                                              physics: NeverScrollableScrollPhysics(),
                                              padding: EdgeInsets.zero,
                                              scrollDirection: Axis.vertical,
                                              itemBuilder: (context, index) {
                                               var detail = barData?.data!.barDetails!.barInfo![index];
                                                return Column(
                                                  children: [
                                                    InkWell(
                                                      onTap:(){
                                                        barDetailProvider.showSelectedImage(detail.toString());
                                                      },
                                                      child: ImageWidget(
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
                            barData?.data?.barDetails?.aboutUs.toString()??"",
                            style: StaticTextStyle()
                                .regular
                                .copyWith(fontSize: 12.sp, fontFamily: abelBold, color: ColorConstants.textGreyColor),
                          ),
                          Padding(
                            padding:  EdgeInsets.symmetric(vertical: 10.sp),
                            child: RatingWidget(
                              initialRating: barData?.data!.review?.rating==null?0: double.parse(barData!.data!.review!.rating.toString()),
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
                                  barData?.data?.barDetails?.address.toString()??"",
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
                                ReservationTabPage(
                                  barId: int.parse(widget.barId.toString()).toString(),
                                ),
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
      ),
    );
  }
}
