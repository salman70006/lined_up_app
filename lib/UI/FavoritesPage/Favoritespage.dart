import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:linedup_app/Components/BackButtonWidget/BackButtonWidget.dart';
import 'package:linedup_app/Components/Extentions/PaddingExtentions.dart';
import 'package:linedup_app/Controllers/AllFavouritesService/AllFavouritesService.dart';
import 'package:linedup_app/Providers/AllFavouritesProvider/AllFavouritesProvider.dart';
import 'package:linedup_app/Utils/Constants/RouteConstants/RouteConstants.dart';
import 'package:provider/provider.dart';

import '../../Components/CacheNetworkImage/CacheNetworkImage.dart';
import '../../Components/CustomOutlineTextField/CustomOutlineTextField.dart';
import '../../Components/PromotionContainer/PromotionContainer.dart';
import '../../Components/StaticTextStyle/StaticTextStyle.dart';
import '../../Utils/Constants/AssetConstants/AssetConstants.dart';
import '../../Utils/Constants/ColorConstants/ColorConstants.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  AllFavoriteService allFavoriteService =  AllFavoriteService();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    allFavoriteService.fetchFavourites(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.scaffoldColor,
      body: Container(
        margin: EdgeInsets.only(top: 30.sp),
        padding:  EdgeInsets.only(left: PaddingExtensions.screenLeftSidePadding,right: PaddingExtensions.screenRightSidePadding,top: 20.sp),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.sp),
            topRight: Radius.circular(20.sp),
          ),
          color: ColorConstants.whiteColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            CustomOutlineTextFormField(
              hintText: "Search",
              filled: true,
              filledColor: ColorConstants.socialButtonBorderColor,
              borderSideColor: ColorConstants.whiteColor.withOpacity(0.sp),
              borderRadius: 30.sp,
              contentPadding: EdgeInsets.only(left: 24.sp, top: 10.sp, bottom: 10.sp),
              suffixIcon: Icon(
                Icons.search,
                size: 20.sp,
                color: ColorConstants.textGreyColor,
              ),
            ),
            Padding(
              padding:  EdgeInsets.symmetric(vertical: PaddingExtensions.screenVerticalPadding),
              child: Text(
                "Favorites",
                style: StaticTextStyle().regular.copyWith(
                    fontSize: 20.sp,
                    color: ColorConstants.blackColor
                ),
              ),
            ),

            Consumer<AllFavouritesProvider>(
              builder: (context, allFavourites,_) {
                var wishlist = allFavourites.allFavouriteResponseModel;
                return wishlist?.data==null ?Center(child: CircularProgressIndicator(color: ColorConstants.appPrimaryColor,)) :Expanded(
                  child: wishlist!.data!.isEmpty ? Center(child: Text("No favourites yet!")):GridView.builder(
                      itemCount: wishlist.data!.length,
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.zero,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 50.sp,
                          mainAxisSpacing: 20.sp,
                          childAspectRatio: 2 / 3),
                      itemBuilder: (context, index) {
                        var myFavourites = wishlist.data![index];
                        return Stack(
                          children: [
                            ImageWidget(
                              imageUrl: myFavourites.getBar!.coverImage??"",
                              height: 250.sp,
                              width: 145.sp,
                              borderRadius: BorderRadius.circular(20.sp),
                              fit: BoxFit.cover,
                              blendMode: BlendMode.darken,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.sp)),
                            ),
                           myFavourites.isLiked==false? SizedBox(): InkWell(
                             onTap: ()async{
                             var response =await allFavoriteService.toggle(context, myFavourites.barId);
                             print(response);
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
                                    myFavourites.getBar?.venue.toString()??"",
                                    style: StaticTextStyle().boldTextStyle.copyWith(
                                      fontSize: 12.sp,

                                    ),
                                  ),
                                  Padding(
                                    padding:  EdgeInsets.symmetric(vertical: 5),
                                    child: Text(
                                      myFavourites.getBar?.address.toString()??"",
                                      style: StaticTextStyle().regular.copyWith(
                                          fontSize: 12.sp,
                                          fontFamily: englishItalic
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "Opening \n${myFavourites.getBar?.startTime}-${myFavourites.getBar?.endTime}",
                                    style: StaticTextStyle().regular.copyWith(
                                        fontSize: 12.sp,
                                        fontFamily: englishItalic
                                    ),
                                  ),
                                 myFavourites.getBar!.havePromotion==false? SizedBox(): InkWell(
                                    onTap: (){
                                      Navigator.of(context).pushNamed(RouteConstants.promotionsPageRoute);
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
                        );
                      }),
                );
              }
            ),

          ],
        ),
      ),
    );
  }
}
