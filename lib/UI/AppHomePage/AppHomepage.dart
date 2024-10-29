import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:com.zat.linedup/Components/BackButtonWidget/BackButtonWidget.dart';
import 'package:com.zat.linedup/Components/CacheNetworkImage/CacheNetworkImage.dart';
import 'package:com.zat.linedup/Components/CustomOutlineTextField/CustomOutlineTextField.dart';
import 'package:com.zat.linedup/Components/Extentions/PaddingExtentions.dart';
import 'package:com.zat.linedup/Components/PromotionContainer/PromotionContainer.dart';
import 'package:com.zat.linedup/Components/ScaffoldMessageWidget/ScaffoldMessageWidget.dart';
import 'package:com.zat.linedup/Components/StaticTextStyle/StaticTextStyle.dart';
import 'package:com.zat.linedup/Controllers/AllBarsService/AllBarsService.dart';
import 'package:com.zat.linedup/Controllers/HomeSearchController/HomeSearchController.dart';
import 'package:com.zat.linedup/Controllers/UserProfileService/UserProfileService.dart';
import 'package:com.zat.linedup/Providers/AllBarsProvider/AllBarsProvider.dart';
import 'package:com.zat.linedup/Providers/NotificationsProvider/NotificationsProvider.dart';
import 'package:com.zat.linedup/Providers/UserProfileProvider/UserProfileProvider.dart';
import 'package:com.zat.linedup/Utils/Constants/AssetConstants/AssetConstants.dart';
import 'package:com.zat.linedup/Utils/Constants/ColorConstants/ColorConstants.dart';
import 'package:com.zat.linedup/Utils/Constants/RouteConstants/RouteConstants.dart';
import 'package:provider/provider.dart';
import 'package:super_tooltip/super_tooltip.dart';
import '../../Components/TooltipContent/DistanceTooltipContent.dart';
import '../../Controllers/AllNotificationsService/AllNotificationsService.dart';

class AppHomePage extends StatefulWidget {
  const AppHomePage({super.key});

  @override
  State<AppHomePage> createState() => _AppHomePageState();
}

class _AppHomePageState extends State<AppHomePage>
    with SingleTickerProviderStateMixin {
  AnimationController? animationController;
  AllBarsService allBarsService = AllBarsService();
  UserProfileService userProfileService = UserProfileService();
  Completer<GoogleMapController> _controller = Completer();
  final tooltipController = SuperTooltipController();

  static const LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }
  bool? loading = true;

TextEditingController searchController = TextEditingController();

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }
  Uint8List? markerIcon;
  var coverImage;
  var barId;
  Future<void> handleRefresh()async {
    Future.delayed(Duration(seconds: 1),()async{
     await userProfileService.getUserProfile(context);
     await  allBarsService.fetchAllBars(context);
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPicture();

    animationController = BottomSheet.createAnimationController(this);
    animationController!.duration = Duration(seconds: 1);
    userProfileService.getUserProfile(context);
    allBarsService.fetchAllBars(context);
    AllNotificationsService().getAllNotifications(context);

  }
 getPicture()async{
    markerIcon = await getBytesFromAsset("assets/Images/location_pic.png",80);
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    animationController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
     onTap: (){
       FocusScope.of(context).unfocus();
     },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Consumer3<AllBarsProvider, UserProfileProvider,NotificationsProvider>(
            builder: (context, allBarsProvider, userProfileProvider,notificationsProvider, _) {
           var  bars = allBarsProvider.allBarsResponseModel;



          var profileData = userProfileProvider.userProfileResponseModel?.data;
          return bars?.barData == null
              ? Center(
                  child: CircularProgressIndicator(
                  color: ColorConstants.appPrimaryColor,
                ))
              : SingleChildScrollView(
                child: Column(
                    children: [
                      Stack(
                        children: [
                          ImageWidget(
                            imageUrl: bars?.barData![0].barInfo?.last,
                            height: 297.sp,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            blendColor: ColorConstants.blackColor.withOpacity(0.3),
                            blendMode: BlendMode.colorBurn,
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                top: 40.sp, left: 16.sp, right: 20.sp),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Current Location",
                                            style: StaticTextStyle()
                                                .regular
                                                .copyWith(fontSize: 12.sp),
                                          ),
                                          Text(
                                            userProfileProvider
                                                    .userProfileResponseModel
                                                    ?.data!
                                                    .location ??
                                                "",
                                            style: StaticTextStyle()
                                                .regular
                                                .copyWith(fontSize: 16.sp),
                                          ),
                                        ],
                                      ),
                                    ),
                                    BackButtonWidget(
                                      onPress: () {
                                        Navigator.of(context).pushNamed(
                                            RouteConstants.notificationsPageRoute);
                                      },
                                      imageWidget: Stack(
                                        children: [
                                          Center(
                                            child: SvgPicture.asset(
                                              AssetConstants.notificationsIcon,

                                            ),
                                          ),
                                          // Container(
                                          //   margin: EdgeInsets.only(left: 8.sp,top: 5.sp),
                                          //   child: Align(
                                          //     alignment: Alignment.topCenter,
                                          //     child: SvgPicture.asset(
                                          //       AssetConstants.notificationAlertDot,
                                          //       height: 8.sp,
                                          //       width: 8.sp,
                                          //     ),
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                      containerColor: ColorConstants.whiteColor
                                          .withOpacity(0.4),
                                      leftPadding: 0.sp,
                                      topPadding: 2.sp,
                                      borderRadius: 8.sp,
                                    )
                                  ],
                                ),
                                // Padding(
                                //   padding: EdgeInsets.symmetric(vertical: 10.sp),
                                //   child: BackButtonWidget(
                                //     onPress: () {
                                //       nearbyModelBottomSheet(context,allBarsProvider);
                                //     },
                                //     imageWidget: Text(
                                //       "Nearby Bars",
                                //       style: StaticTextStyle().regular.copyWith(fontSize: 18.sp,color: ColorConstants.blackColor),
                                //     ),
                                //     borderColor: ColorConstants.whiteColor.withOpacity(0.0),
                                //     containerColor: ColorConstants.appPrimaryColor,
                                //     height: 44.sp,
                                //     width: 126.sp,
                                //     borderRadius: 10.sp,
                                //     leftPadding: 1.sp,
                                //   ),
                                // ),
                                SizedBox(
                                  height: 60.sp,
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
                                        controller: searchController,
                                        textInputAction: TextInputAction.search,
                                        contentPadding: EdgeInsets.only(
                                            left: 24.sp, top: 10.sp, bottom: 10.sp),
                                        onFieldSubmitted: (value)async{
                                          var response = await HomeSearchService().search(context, searchController.text);
                                          print(response);

                                          searchController.clear();

                                          if(response?.responseData?.success==true){
                                            ShowMessage().showMessage(context, "${response?.responseData?.message}", ColorConstants.appPrimaryColor);
                                            FocusScope.of(context).unfocus();
                                            Navigator.of(context).pushNamed(RouteConstants.searchedResultsRoute);

                                          }else{
                                            ShowMessage().showMessage(context, "${response?.responseData?.message}", ColorConstants.redColor);

                                          }
                                        },
                                        onChanged: (value){
                                          if(value.isNotEmpty){
                                            allBarsProvider.homeSearchResponseModel?.searchData?.where((element)=>element.venue!.toLowerCase().contains(searchController.text)).toList();

                                          }
                                        },
                                        suffixIcon:  InkWell(
                                          onTap: ()async{

                                            var response = await HomeSearchService().search(context, searchController.text);
                                            print(response);

                                            searchController.clear();

                                            if(response?.responseData?.success==true){
                                              ShowMessage().showMessage(context, "${response?.responseData?.message}", ColorConstants.appPrimaryColor);
                                              FocusScope.of(context).unfocus();
                                              Navigator.of(context).pushNamed(RouteConstants.searchedResultsRoute);

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
                                      ),
                                    ),
                                    SizedBox(
                                      width: 40.sp,
                                    ),
                                    // InkWell(
                                    //   onTap: () {
                                    //     tooltipController.showTooltip();
                                    //   },
                                    //   child: SuperTooltip(
                                    //     arrowLength: 8.51.sp,
                                    //     arrowTipDistance: 18.sp,
                                    //     minimumOutsideMargin: 14.w,
                                    //     borderColor: Colors.transparent,
                                    //     shadowColor: ColorConstants.blackColor
                                    //         .withOpacity(0.12),
                                    //     barrierColor: Colors.transparent,
                                    //     controller: tooltipController,
                                    //     content: DistanceTooltipContent(),
                                    //     child: BackButtonWidget(
                                    //       imageWidget: SvgPicture.asset(
                                    //         AssetConstants.distanceFilterIcon,
                                    //         height: 20.sp,
                                    //         width: 16.sp,
                                    //       ),
                                    //       containerColor: ColorConstants.whiteColor
                                    //           .withOpacity(0.4),
                                    //       leftPadding: 2.sp,
                                    //       topPadding: 2.sp,
                                    //       borderRadius: 8.sp,
                                    //       height: 45.sp,
                                    //       width: 45.sp,
                                    //       borderColor: ColorConstants.whiteColor
                                    //           .withOpacity(0.0),
                                    //     ),
                                    //   ),
                                    // )
                                  ],
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.3),
                            height: MediaQuery.of(context).size.height * 0.615,
                            width: double.infinity,
                            padding: EdgeInsets.only(
                                top: 16.sp, left: 16.sp, right: 16.sp),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20.sp),
                                  topRight: Radius.circular(20.sp),
                                ),
                                color: ColorConstants.whiteColor),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "LOCATION",
                                      style: StaticTextStyle().boldTextStyle.copyWith(
                                          fontSize: 13.sp,
                                          color: ColorConstants.blackColor,
                                          letterSpacing: 1.sp),
                                    ),

                                  ],
                                ),
                               Container(
                                  height: 200.sp,
                                  child: GoogleMap(
                                    myLocationButtonEnabled: true,
                                    minMaxZoomPreference: MinMaxZoomPreference.unbounded,
                                    myLocationEnabled: true,
                                    zoomControlsEnabled: false,
                                    onMapCreated: _onMapCreated,
                                    initialCameraPosition: CameraPosition(
                                      target: profileData?.latitude!=null && profileData?.longitude!=null? LatLng(
                                          double.parse(profileData!.latitude.toString()),
                                          double.parse(profileData.longitude.toString())):LatLng(0.0, 0.0),
                                      zoom: 11.0,

                                    ),
                                      gestureRecognizers: Set()
                                        ..add(Factory<TapGestureRecognizer>(() => TapGestureRecognizer())),
                                    markers: Set<Marker>.of(List.generate(
                                        bars!.barData!.length, (index) {
                                      return Marker(
                                          markerId: MarkerId(
                                            bars.barData![index].id.toString(),
                                          ),
                                          icon:  markerIcon!=null? BitmapDescriptor.fromBytes(markerIcon!):BitmapDescriptor.defaultMarker,
                                          infoWindow: InfoWindow(
                                              title: bars.barData![index].venue),
                                          onTap: () {
                                            Navigator.of(context).pushNamed(
                                                RouteConstants.eventPageRoute,
                                                arguments: {
                                                  "eventId":bars.barData![index].id,
                                                  "lat":bars.barData![index].latitude,
                                                  "long":bars.barData![index].longitude
                                                });
                                          },
                                          position: bars.barData![index].latitude !=
                                              null &&
                                              bars.barData![index].longitude !=
                                                  null
                                              ? LatLng(
                                              double.parse(
                                                  "${bars.barData![index].latitude}"),
                                              double.parse(
                                                  "${bars.barData![index].longitude}"))
                                              : LatLng(0.0, 0.0));
                                    })),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    nearbyModelBottomSheet(
                                        context, allBarsProvider);
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "BARS NEAR ME",
                                        style: StaticTextStyle().boldTextStyle.copyWith(
                                              fontSize: 18.sp,
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
                                  child: RefreshIndicator(
                                    onRefresh: handleRefresh,
                                    color: ColorConstants.appPrimaryColor,
                                    child: GridView.builder(
                                        itemCount: bars!.barData!.length,
                                        physics: const BouncingScrollPhysics(),
                                        padding: EdgeInsets.zero,
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 3,
                                                crossAxisSpacing: 5.sp,
                                                mainAxisSpacing: 10.sp,
                                                childAspectRatio: 2 / 3),
                                        itemBuilder: (context, index) {
                                          var bar = bars.barData![index];
                                          return InkWell(
                                            onTap: (){
                                              Navigator.of(context).pushNamed(
                                                  RouteConstants.barDetailPage,
                                                  arguments: bar.id);
                                            },
                                            child: Stack(
                                              children: [
                                                ImageWidget(
                                                  imageUrl: bar.coverImage,
                                                  height: 250.sp,
                                                  width: 145.sp,
                                                  borderRadius:
                                                      BorderRadius.circular(20.sp),
                                                  fit: BoxFit.cover,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.sp)),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      Container(
                                                        width: 100.sp,
                                                        child: Text(
                                                          bar.venue.toString() ?? "",
                                                          style: StaticTextStyle()
                                                              .boldTextStyle
                                                              .copyWith(
                                                                fontSize: 12.sp,
                                                              ),
                                                          overflow: TextOverflow.ellipsis,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets.symmetric(
                                                            vertical: 5),
                                                        child: Text(
                                                          bar.address.toString() ?? "",
                                                          style: StaticTextStyle()
                                                              .regular
                                                              .copyWith(
                                                                  fontSize: 12.sp,
                                                                  fontFamily:
                                                                      englishItalic),
                                                          overflow: TextOverflow.ellipsis,

                                                        ),
                                                      ),
                                                      Text(
                                                        "Opening \n${bar.startTime}-${bar.endTime}" ??
                                                            "",
                                                        style: StaticTextStyle()
                                                            .regular
                                                            .copyWith(
                                                                fontSize: 12.sp,
                                                                fontFamily:
                                                                    englishItalic),
                                                        overflow: TextOverflow.ellipsis,

                                                      ),
                                                      bar.havePromotion == false
                                                          ? SizedBox()
                                                          : PromotionContainer(
                                                              title: "Promotions",
                                                              containerColor:
                                                                  ColorConstants
                                                                      .appPrimaryColor,
                                                            ),

                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        }),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
              );
        }),
      ),
    );
  }

  void nearbyModelBottomSheet(
      BuildContext context, AllBarsProvider allBarProvider) {
    var bar = allBarProvider.allBarsResponseModel?.barData;
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20.sp),
                topLeft: Radius.circular(20.sp))),
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
                      child:CustomOutlineTextFormField(
                        hintText: "Search",
                        filled: true,
                        filledColor: ColorConstants.whiteColor,
                        borderSideColor: ColorConstants.whiteColor,
                        cursorColor: ColorConstants.blackColor,
                        borderRadius: 30.sp,
                        controller: searchController,
                        textInputAction: TextInputAction.search,
                        contentPadding: EdgeInsets.only(
                            left: 24.sp, top: 10.sp, bottom: 10.sp),
                        onFieldSubmitted: (value)async{
                          var response = await HomeSearchService().search(context, searchController.text);
                          print(response);

                          searchController.clear();

                          if(response?.responseData?.success==true){
                            ShowMessage().showMessage(context, "${response?.responseData?.message}", ColorConstants.appPrimaryColor);
                            FocusScope.of(context).unfocus();
                            Navigator.of(context).pushNamed(RouteConstants.searchedResultsRoute);

                          }else{
                            ShowMessage().showMessage(context, "${response?.responseData?.message}", ColorConstants.redColor);

                          }
                        },

                        onChanged: (value){
                          if(value.isNotEmpty){
                            allBarProvider.homeSearchResponseModel?.searchData?.where((element)=>element.venue!.toLowerCase().contains(searchController.text)).toList();

                          }
                        },
                        suffixIcon:  InkWell(
                          onTap: ()async{

                            var response = await HomeSearchService().search(context, searchController.text);
                            print(response);

                            searchController.clear();

                            if(response?.responseData?.success==true){
                              ShowMessage().showMessage(context, "${response?.responseData?.message}", ColorConstants.appPrimaryColor);
                              FocusScope.of(context).unfocus();
                              Navigator.of(context).pushNamed(RouteConstants.searchedResultsRoute);

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
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: PaddingExtensions.screenVerticalPadding),
                  child: Text(
                    "Nearby bars",
                    style: StaticTextStyle().regular.copyWith(
                        fontSize: 19.sp, color: ColorConstants.blackColor),
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
                            InkWell(
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                    RouteConstants.barDetailPage,
                                    arguments: bar[index].id);
                              },
                              child: ImageWidget(
                                imageUrl: bar[index].coverImage,
                                height: 250.sp,
                                width: 145.sp,
                                borderRadius: BorderRadius.circular(20.sp),
                                fit: BoxFit.cover,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.sp)),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    bar[index].venue.toString() ?? "",
                                    style: StaticTextStyle()
                                        .boldTextStyle
                                        .copyWith(
                                          fontSize: 12.sp,
                                        ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 5),
                                    child: Text(
                                      bar[index].address.toString() ?? "",
                                      style: StaticTextStyle().regular.copyWith(
                                          fontSize: 12.sp,
                                          fontFamily: englishItalic),
                                      overflow: TextOverflow.ellipsis,

                                    ),
                                  ),
                                  Text(
                                    "Opening \n${bar[index].startTime}-${bar[index].endTime}",
                                    style: StaticTextStyle().regular.copyWith(
                                        fontSize: 12.sp,
                                        fontFamily: englishItalic),
                                  ),
                                  bar[index].havePromotion == false
                                      ? SizedBox()
                                      : InkWell(
                                          onTap: () {
                                            Navigator.of(context).pushNamed(
                                                RouteConstants
                                                    .promotionsPageRoute,
                                                arguments: {
                                                  "barId": bar[index].id,
                                                  "coverImage":
                                                      bar[index].barInfo!.first
                                                });
                                          },
                                          child: PromotionContainer(
                                            title: "Promotions",
                                            containerColor:
                                                ColorConstants.appPrimaryColor,
                                          ),
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
  _showDialog(BuildContext context){
    showDialog(context: context, builder: (context){
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.sp),
        ),
        insetPadding: EdgeInsets.only(left: 16, right: 16.sp, top: 16.sp),
        child: Container(
          padding: EdgeInsets.all(12.sp),
          height: 100.sp,
          child: Column(
            children: [
              Row(
                children: [
                  CircularProgressIndicator(
                    color: ColorConstants.appPrimaryColor,
                  ),
                  Expanded(child: Text(
                    "Fetching search results",
                    style: StaticTextStyle().regular,
                  ))
                ],
              )
            ],
          ),
        ),
      );
    });
  }
  
}
