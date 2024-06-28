import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:linedup_app/Components/BackButtonWidget/BackButtonWidget.dart';
import 'package:linedup_app/Components/CacheNetworkImage/CacheNetworkImage.dart';
import 'package:linedup_app/Components/DailyPromotionWidget/DailyPromotionWidget.dart';
import 'package:linedup_app/Components/StaticTextStyle/StaticTextStyle.dart';
import 'package:linedup_app/Controllers/BarsPromotionsService/BarsPromotionService.dart';
import 'package:linedup_app/Utils/Constants/ColorConstants/ColorConstants.dart';

class PromotionsPage extends StatefulWidget {
  var barId;
  var coverImage;
   PromotionsPage({this.barId,this.coverImage});

  @override
  State<PromotionsPage> createState() => _PromotionsPageState();
}

class _PromotionsPageState extends State<PromotionsPage> with SingleTickerProviderStateMixin {
  TabController? _controller;
  BarsPromotionService barsPromotionService = BarsPromotionService();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TabController(length: 2, vsync: this);
    barsPromotionService.fetchPromotions(context, int.parse(widget.barId["barId"].toString()).toString());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              ImageWidget(
                imageUrl: widget.coverImage["coverImage"],
                height: 370.sp,
                fit: BoxFit.cover,
                width: double.infinity,

              ),
              Container(
                height: 370.sp,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          const Color(0xffFFFFFF).withOpacity(0.sp),
                          const Color(0xffFEFEFEE0).withOpacity(0.6.sp),
                          const Color(0xffFFFFFF).withOpacity(0.6.sp),
                        ]),
                ),
              ),
              Container(
                height: 370.sp,
                child: Padding(
                  padding:  EdgeInsets.only(left:16.sp,top: 40.sp,bottom: 10.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BackButtonWidget(
                        height: 40.sp,
                        width: 50.sp,
                        icon: Icons.arrow_back,
                        iconSize: 24.sp,
                        leftPadding: 2.sp,
                        iconColor: ColorConstants.whiteColor,
                        containerColor: ColorConstants.whiteColor.withOpacity(0.3),
                        borderColor: ColorConstants.whiteColor.withOpacity(0.0),
                        borderRadius: 15.sp,
                        onPress: (){
                          Navigator.of(context).pop();
                        },
                      ),
                      Text(
                        "Promotions",
                        style: StaticTextStyle().boldTextStyle.copyWith(
                          fontSize: 28.sp,
                          color: ColorConstants.aboutBlackColor
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          StreamBuilder<Object>(
            stream: null,
            builder: (context, snapshot) {
              return TabBar(
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
                    text: "Daily",
                  ),

                  Tab(
                    text: "Weekly",
                  ),
                ],
              );
            }
          ),
          Expanded(child: TabBarView(
            controller: _controller,
            children: [
              DailyPromotionWidget(promotionType: "daily",),
              DailyPromotionWidget(promotionType: "weekly"),
            ],
          ))
        ],
      ),
    );
  }
}
