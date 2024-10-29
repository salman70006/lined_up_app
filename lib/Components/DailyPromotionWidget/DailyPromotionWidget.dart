import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:com.zat.linedup/Components/StaticTextStyle/StaticTextStyle.dart';
import 'package:com.zat.linedup/Providers/AllPromotionsProvider/AllPromotionsProvider.dart';
import 'package:com.zat.linedup/Utils/Constants/ColorConstants/ColorConstants.dart';
import 'package:provider/provider.dart';

class DailyPromotionWidget extends StatefulWidget {
  var promotionType;
   DailyPromotionWidget({this.promotionType});

  @override
  State<DailyPromotionWidget> createState() => _DailyPromotionWidgetState();
}

class _DailyPromotionWidgetState extends State<DailyPromotionWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(
      widget.promotionType
    );
  }
  @override
  Widget build(BuildContext context) {
    return widget.promotionType=="daily"? Consumer<AllPromotionsProvider>(
      builder: (context,promotionsProvider,_) {
        var promotionsData = promotionsProvider.getBarPromotionsResponseModel;
        return promotionsData?.data==null && promotionsData?.data!.daily==null?Center(
          child: CircularProgressIndicator(
            color: ColorConstants.appPrimaryColor,
          ),
        ) :ListView.builder(
          itemCount:  promotionsData!.data!.daily!.length,
            physics: BouncingScrollPhysics(),
            itemBuilder: (context,index){
            var dailyPromotion = promotionsData.data!.daily![index];
            return Container(
              padding: EdgeInsets.all(12.sp),
              margin: EdgeInsets.only(left: 12.sp,right: 12.sp,bottom: 10.sp),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.sp),
                color: ColorConstants.dailyPromotionContainerColor
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      dailyPromotion.itemType.toString()??"",
                    style: StaticTextStyle().boldTextStyle.copyWith(
                      fontSize: 16.sp,
                      color: ColorConstants.blackColor
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.symmetric(vertical: 10.sp),
                    child: Text(
                      "\$${dailyPromotion.itemPrice} ${dailyPromotion.itemName}",
                      style: StaticTextStyle().regular.copyWith(
                        fontSize: 12.sp,
                        color: ColorConstants.blackColor,
                        fontFamily: arimoBold
                      ),
                    ),
                  ),
                  SizedBox(
                    child: Text(
                        dailyPromotion.description.toString()??"",
                        style: StaticTextStyle().regular.copyWith(
                        fontSize: 12.sp,
                        color: ColorConstants.blackColor,),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),

                ],
              ),
            );
            } );
      }
    ):
    Consumer<AllPromotionsProvider>(
        builder: (context,promotionsProvider,_) {
          var promotionsData = promotionsProvider.getBarPromotionsResponseModel;
          return promotionsData?.data==null && promotionsData?.data!.weekly==null?Center(
            child: CircularProgressIndicator(
              color: ColorConstants.appPrimaryColor,
            ),
          ) :ListView.builder(
              itemCount:  promotionsData!.data!.weekly!.length,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context,index){
                var dailyPromotion = promotionsData.data!.weekly![index];
                return Container(
                  padding: EdgeInsets.all(12.sp),
                  margin: EdgeInsets.only(left: 12.sp,right: 12.sp,bottom: 10.sp),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.sp),
                      color: ColorConstants.dailyPromotionContainerColor
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        dailyPromotion.itemType.toString()??"",
                        style: StaticTextStyle().boldTextStyle.copyWith(
                            fontSize: 16.sp,
                            color: ColorConstants.blackColor
                        ),
                      ),
                      Padding(
                        padding:  EdgeInsets.symmetric(vertical: 10.sp),
                        child: Text(
                          "\$${dailyPromotion.itemPrice} ${dailyPromotion.itemName}",
                          style: StaticTextStyle().regular.copyWith(
                              fontSize: 12.sp,
                              color: ColorConstants.blackColor,
                              fontFamily: arimoBold
                          ),
                        ),
                      ),
                      SizedBox(
                        child: Text(
                          dailyPromotion.description.toString()??"",
                          style: StaticTextStyle().regular.copyWith(
                            fontSize: 12.sp,
                            color: ColorConstants.blackColor,),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),

                      ),

                    ],
                  ),
                );
              } );
        }
    )
    ;
  }
}
