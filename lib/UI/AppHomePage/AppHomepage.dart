import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:linedup_app/Components/BackButtonWidget/BackButtonWidget.dart';
import 'package:linedup_app/Components/CacheNetworkImage/CacheNetworkImage.dart';
import 'package:linedup_app/Components/CustomOutlineTextField/CustomOutlineTextField.dart';
import 'package:linedup_app/Components/Extentions/PaddingExtentions.dart';
import 'package:linedup_app/Components/PromotionContainer/PromotionContainer.dart';
import 'package:linedup_app/Components/StaticTextStyle/StaticTextStyle.dart';
import 'package:linedup_app/Controllers/AllBarsService/AllBarsService.dart';
import 'package:linedup_app/Controllers/UserProfileService/UserProfileService.dart';
import 'package:linedup_app/Providers/AllBarsProvider/AllBarsProvider.dart';
import 'package:linedup_app/Providers/UserProfileProvider/UserProfileProvider.dart';
import 'package:linedup_app/Utils/Constants/AssetConstants/AssetConstants.dart';
import 'package:linedup_app/Utils/Constants/ColorConstants/ColorConstants.dart';
import 'package:linedup_app/Utils/Constants/RouteConstants/RouteConstants.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:super_tooltip/super_tooltip.dart';

import '../../Components/TooltipContents/distanceTooltipContent.dart';

class AppHomePage extends StatefulWidget {
  const AppHomePage({super.key});

  @override
  State<AppHomePage> createState() => _AppHomePageState();
}

class _AppHomePageState extends State<AppHomePage> with SingleTickerProviderStateMixin {
  AnimationController? animationController;
AllBarsService allBarsService = AllBarsService();
UserProfileService userProfileService = UserProfileService();
  Completer<GoogleMapController> _controller = Completer();
  final tooltipController = SuperTooltipController();

  static const LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController = BottomSheet.createAnimationController(this);
    animationController!.duration = Duration(seconds: 1);
    userProfileService.getUserProfile(context);
    allBarsService.fetchAllBars(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    animationController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer2<AllBarsProvider,UserProfileProvider>(
        builder: (context, allBarsProvider,userProfileProvider,_) {
          var bars = allBarsProvider.allBarsResponseModel;
          var coverImage;
          var barId;
          bars?.barData?.forEach((e){
           coverImage = e.coverImage;
           barId = e.id;
          });

          return bars?.barData==null?Center(child: CircularProgressIndicator(color: ColorConstants.appPrimaryColor,)): Column(
            children: [
              Stack(
                children: [
                  ImageWidget(
                    imageUrl: coverImage,
                    height: 297.sp,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    blendColor: ColorConstants.blackColor.withOpacity(0.3),
                    blendMode: BlendMode.colorBurn,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 40.sp, left: 16.sp, right: 20.sp),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Current Location",
                                    style: StaticTextStyle().regular.copyWith(fontSize: 12.sp),
                                  ),
                                  Text(
                                    userProfileProvider.userProfileResponseModel?.data!.location??"",
                                    style: StaticTextStyle().regular.copyWith(fontSize: 16.sp),
                                  ),
                                ],
                              ),
                            ),
                            BackButtonWidget(
                              onPress: () {
                                Navigator.of(context).pushNamed(RouteConstants.notificationsPageRoute);
                              },
                              imageWidget: Stack(
                                alignment: AlignmentDirectional.topEnd,
                                children: [
                                  SvgPicture.asset(
                                    AssetConstants.notificationsIcon,
                                    height: 20.sp,
                                    width: 16.sp,
                                  ),
                                  SvgPicture.asset(
                                    AssetConstants.notificationAlertDot,
                                    height: 8.sp,
                                    width: 8.sp,
                                  ),
                                ],
                              ),
                              containerColor: ColorConstants.whiteColor.withOpacity(0.4),
                              leftPadding: 2.sp,
                              topPadding: 2.sp,
                              borderRadius: 8.sp,
                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.sp),
                          child: BackButtonWidget(
                            onPress: () {
                              nearbyModelBottomSheet(context,allBarsProvider);
                            },
                            imageWidget: Text(
                              "Nearby Bars",
                              style: StaticTextStyle().regular.copyWith(fontSize: 18.sp),
                            ),
                            borderColor: ColorConstants.whiteColor.withOpacity(0.0),
                            containerColor: ColorConstants.whiteColor.withOpacity(0.4),
                            height: 44.sp,
                            width: 126.sp,
                            borderRadius: 10.sp,
                            leftPadding: 1.sp,
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: CustomOutlineTextFormField(
                                hintText: "Search",
                                filled: true,
                                filledColor: ColorConstants.whiteColor,
                                borderSideColor: ColorConstants.whiteColor,
                                cursorColor: ColorConstants.blackColor,
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
                              onTap: (){
                                tooltipController.showTooltip();
                              },
                              child: SuperTooltip(
                                arrowLength: 8.51.sp,
                                arrowTipDistance: 18.sp,
                                minimumOutsideMargin: 14.w,
                                borderColor: Colors.transparent,
                                shadowColor: ColorConstants.blackColor.withOpacity(0.12),
                                barrierColor: Colors.transparent,
                                controller: tooltipController,
                                content: DistanceTooltipContent(),
                                child: BackButtonWidget(
                                  imageWidget: SvgPicture.asset(
                                    AssetConstants.distanceFilterIcon,
                                    height: 20.sp,
                                    width: 16.sp,
                                  ),
                                  containerColor: ColorConstants.whiteColor.withOpacity(0.4),
                                  leftPadding: 2.sp,
                                  topPadding: 2.sp,
                                  borderRadius: 8.sp,
                                  height: 45.sp,
                                  width: 45.sp,
                                  borderColor: ColorConstants.whiteColor.withOpacity(0.0),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.3),
                    height: MediaQuery.of(context).size.height * 0.615,
                    width: double.infinity,
                    padding: EdgeInsets.only(top: 16.sp, left: 16.sp, right: 16.sp),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.sp),
                          topRight: Radius.circular(20.sp),
                        ),
                        color: ColorConstants.whiteColor),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Location",
                          style: StaticTextStyle()
                              .boldTextStyle
                              .copyWith(fontSize: 13.sp, color: ColorConstants.blackColor, letterSpacing: 1.sp),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed(RouteConstants.eventPageRoute,arguments: barId);
                          },
                          child: Container(
                            height: 200.sp,
                            child: GoogleMap(
                              onMapCreated: _onMapCreated,
                              initialCameraPosition: CameraPosition(
                                target: _center,
                                zoom: 11.0,
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            nearbyModelBottomSheet(context,allBarsProvider);

                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Related Bars",
                                style: StaticTextStyle().regular.copyWith(
                                      fontSize: 20.sp,
                                      color: ColorConstants.blackColor,
                                      letterSpacing: 1.sp,
                                    ),
                              ),
                              Text(
                                "View All",
                                style: StaticTextStyle().regular.copyWith(
                                      fontSize: 12.sp,
                                      color: ColorConstants.appPrimaryColor,
                                      letterSpacing: 1.sp,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10.sp),
                        Expanded(
                          child: GridView.builder(
                              itemCount: bars!.barData!.length,
                              physics: const BouncingScrollPhysics(),
                              padding: EdgeInsets.zero,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 5.sp,
                                  mainAxisSpacing: 10.sp,
                                  childAspectRatio: 2 / 3),
                              itemBuilder: (context, index) {
                               var bar = bars.barData![index];
                                return Stack(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.of(context).pushNamed(RouteConstants.barDetailPage,arguments: bar.id);
                                      },
                                      child: ImageWidget(
                                        imageUrl: bar.coverImage,
                                        height: 250.sp,
                                        width: 145.sp,
                                        borderRadius: BorderRadius.circular(20.sp),
                                        fit: BoxFit.cover,
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.sp)),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            bar.venue.toString()??"",
                                            style: StaticTextStyle().boldTextStyle.copyWith(
                                                  fontSize: 12.sp,
                                                ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(vertical: 5),
                                            child: Text(
                                              bar.address.toString()??"",
                                              style: StaticTextStyle()
                                                  .regular
                                                  .copyWith(fontSize: 12.sp, fontFamily: englishItalic),
                                            ),
                                          ),
                                          Text(
                                            "Opening \n${bar.startTime}-${bar.endTime}"??"",
                                            style: StaticTextStyle()
                                                .regular
                                                .copyWith(fontSize: 12.sp, fontFamily: englishItalic),
                                          ),
                                          bar.havePromotion==false? SizedBox():InkWell(
                                            onTap: () {
                                              Navigator.of(context).pushNamed(RouteConstants.promotionsPageRoute,arguments: {
                                                "barId":bar.id,
                                                "coverImage":bar.coverImage
                                              });
                                            },
                                            child: PromotionContainer(
                                              title: "Promotions",
                                              containerColor: ColorConstants.appPrimaryColor,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              }),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          );
        }
      ),
    );
  }

  void nearbyModelBottomSheet(BuildContext context,AllBarsProvider allBarProvider) {
    var bar = allBarProvider.allBarsResponseModel?.barData;
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.only(topRight: Radius.circular(20.sp), topLeft: Radius.circular(20.sp))),
        scrollControlDisabledMaxHeightRatio: 3 / 3.2,
        transitionAnimationController: animationController,
        context: context,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
                left: PaddingExtensions.screenLeftSidePadding,
                right: PaddingExtensions.screenRightSidePadding,
                top: 12.sp,
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: ColorConstants.blackColor,
                        size: 24.sp,
                      ),
                    ),
                    SizedBox(
                      width: 10.sp,
                    ),
                    Expanded(
                      child: CustomOutlineTextFormField(
                        hintText: "Search",
                        filled: true,
                        filledColor: ColorConstants.socialButtonBorderColor,
                        borderSideColor: ColorConstants.whiteColor.withOpacity(0.sp),
                        cursorColor: ColorConstants.blackColor,
                        borderRadius: 30.sp,
                        contentPadding: EdgeInsets.only(left: 24.sp, top: 10.sp, bottom: 10.sp),
                        suffixIcon: Icon(
                          Icons.search,
                          size: 20.sp,
                          color: ColorConstants.textGreyColor,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: PaddingExtensions.screenVerticalPadding),
                  child: Text(
                    "Nearby bars",
                    style:
                        StaticTextStyle().regular.copyWith(fontSize: 19.sp, color: ColorConstants.blackColor),
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                      itemCount: bar!.length,
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.zero,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 5.sp,
                          mainAxisSpacing: 10.sp,
                          childAspectRatio: 2 / 3),
                      itemBuilder: (context, index) {
                        return Stack(
                          children: [
                            ImageWidget(
                              imageUrl: bar[index].coverImage,
                              height: 250.sp,
                              width: 145.sp,
                              borderRadius: BorderRadius.circular(20.sp),
                              fit: BoxFit.cover,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.sp)),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    bar[index].venue.toString()??"",
                                    style: StaticTextStyle().boldTextStyle.copyWith(
                                          fontSize: 12.sp,
                                        ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 5),
                                    child: Text(
                                      bar[index].address.toString()??"",
                                      style: StaticTextStyle()
                                          .regular
                                          .copyWith(fontSize: 12.sp, fontFamily: englishItalic),
                                    ),
                                  ),
                                  Text(
                                    "Opening \n${bar[index].startTime}-${bar[index].endTime}",
                                    style: StaticTextStyle()
                                        .regular
                                        .copyWith(fontSize: 12.sp, fontFamily: englishItalic),
                                  ),
                                bar[index].havePromotion==false?SizedBox():  PromotionContainer(
                                    title: "Promotions",
                                    containerColor: ColorConstants.appPrimaryColor,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }),
                ),
              ],
            ),
          );
        });
  }
}
