import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:com.zat.linedup/Components/BackButtonWidget/BackButtonWidget.dart';
import 'package:com.zat.linedup/Providers/AllBarsProvider/AllBarsProvider.dart';
import 'package:com.zat.linedup/Providers/AllFavouritesProvider/AllFavouritesProvider.dart';
import 'package:provider/provider.dart';

import '../../Components/CacheNetworkImage/CacheNetworkImage.dart';
import '../../Components/PromotionContainer/PromotionContainer.dart';
import '../../Components/ScaffoldMessageWidget/ScaffoldMessageWidget.dart';
import '../../Components/StaticTextStyle/StaticTextStyle.dart';
import '../../Controllers/AllFavouritesService/AllFavouritesService.dart';
import '../../Utils/Constants/AssetConstants/AssetConstants.dart';
import '../../Utils/Constants/ColorConstants/ColorConstants.dart';
import '../../Utils/Constants/RouteConstants/RouteConstants.dart';

class WishListSearchResultPage extends StatefulWidget {
  const WishListSearchResultPage({super.key});

  @override
  State<WishListSearchResultPage> createState() => _WishListSearchResultPageState();
}

class _WishListSearchResultPageState extends State<WishListSearchResultPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // setState(() {
    //   showLoading = false;
    //
    // });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AllFavouritesProvider>(
          builder: (context, allFavouritesProvider,_) {
            var searchedResult = allFavouritesProvider.wishListSearchResponseModel?.data;
            return  Container(
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.symmetric(vertical: 40.sp,horizontal: 20.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BackButtonWidget(
                        icon: Icons.arrow_back_ios,
                        onPress: () => Navigator.of(context).pop(),
                      ),
                      Text("Searched Results",style: StaticTextStyle().boldTextStyle.copyWith(
                          fontSize: 18.sp,
                          color: ColorConstants.blackColor
                      ),),
                      SizedBox(),
                    ],
                  ),

                  Expanded(
                    child: ListView.builder(
                        itemCount: searchedResult?.length,
                        itemBuilder: (context,fIndex){
                          var myResult =  searchedResult?[fIndex];
                          return InkWell(
                            onTap: (){
                              Navigator.of(context).pushNamed(RouteConstants.barDetailPage,arguments: myResult?.barId);

                            },
                            child: Row(
                              children: [
                                Stack(
                                  alignment: AlignmentDirectional.bottomCenter,
                                  children: [
                                    ImageWidget(
                                      imageUrl: myResult?.getBar!.coverImage??"",
                                      height: 250.sp,
                                      width: 145.sp,
                                      borderRadius: BorderRadius.circular(20.sp),
                                      fit: BoxFit.cover,
                                      blendMode: BlendMode.darken,
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.sp)),
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        myResult?.isLiked==false? SizedBox(): Container(
                                          height: 150.sp,
                                          child: InkWell(
                                            onTap: (){

                                              // if()
                                              // await allFavoriteService.fetchFavourites(context);
                                            },
                                            child: Padding(
                                              padding:  EdgeInsets.only(top: 10.sp,right: 10.sp),
                                              child: Align(
                                                alignment: Alignment.topRight,
                                                child: BackButtonWidget(
                                                  imageWidget: SvgPicture.asset(AssetConstants.favouriteIcon),
                                                  containerColor: ColorConstants.whiteColor.withOpacity(0.3),
                                                  borderColor: ColorConstants.whiteColor.withOpacity(0.sp),
                                                  borderRadius: 8.sp,
                                                  onPress: ()async{
                                                    var response =await AllFavoriteService().toggle(context, myResult?.barId);
                                                    print(response);
                                                    if(response?.responseData?.success==true){
                                                      ShowMessage().showMessage(context, response!.responseData!.message!, ColorConstants.appPrimaryColor);
                                                    }
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:  EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                myResult?.getBar?.venue.toString()??"",
                                                style: StaticTextStyle().boldTextStyle.copyWith(
                                                  fontSize: 12.sp,

                                                ),
                                              ),
                                              Padding(
                                                padding:  EdgeInsets.symmetric(vertical: 5),
                                                child: Text(
                                                  myResult?.getBar?.address.toString()??"",
                                                  style: StaticTextStyle().regular.copyWith(
                                                      fontSize: 12.sp,
                                                      fontFamily: englishItalic
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                "Opening \n${myResult?.getBar?.startTime}-${myResult?.getBar?.endTime}",
                                                style: StaticTextStyle().regular.copyWith(
                                                    fontSize: 12.sp,
                                                    fontFamily: englishItalic
                                                ),
                                              ),
                                              myResult?.getBar!.havePromotion==false? SizedBox(): InkWell(
                                                onTap: (){
                                                  Navigator.of(context).pushNamed(RouteConstants.promotionsPageRoute,arguments:  {
                                                    "barId":myResult?.barId,
                                                    "coverImage":myResult?.getBar?.barInfo?[1]
                                                  });
                                                },
                                                child: PromotionContainer(
                                                  title: "Promotions",
                                                  containerColor: ColorConstants.appPrimaryColor,

                                                ),
                                              ),
                                            ],
                                          ),

                                        ),
                                      ],
                                    )

                                  ],
                                ),
                              ],
                            ),
                          );
                        }),
                  )
                ],
              ),
            );
          }
      ),
    );
  }

}
