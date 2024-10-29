import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:com.zat.linedup/Components/BackButtonWidget/BackButtonWidget.dart';
import 'package:com.zat.linedup/Components/Extentions/PaddingExtentions.dart';
import 'package:com.zat.linedup/Components/ScaffoldMessageWidget/ScaffoldMessageWidget.dart';
import 'package:com.zat.linedup/Controllers/AllFavouritesService/AllFavouritesService.dart';
import 'package:com.zat.linedup/Providers/AllFavouritesProvider/AllFavouritesProvider.dart';
import 'package:com.zat.linedup/Utils/Constants/RouteConstants/RouteConstants.dart';
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
  TextEditingController searchController = TextEditingController();
  var wishList;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AllFavoriteService().fetchFavourites(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.scaffoldColor,
      body: Consumer<AllFavouritesProvider>(
        builder: (context, allFavouritesProvider,_) {
          wishList = allFavouritesProvider.allFavouriteResponseModel;

          return  Container(
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
                  cursorColor: ColorConstants.blackColor,
                  borderSideColor: ColorConstants.whiteColor.withOpacity(0.sp),
                  borderRadius: 30.sp,
                  contentPadding: EdgeInsets.only(left: 24.sp, top: 10.sp, bottom: 10.sp),
                  controller: searchController,
                  textInputAction: TextInputAction.search,
                  onFieldSubmitted: (value)async{
                    var response = await AllFavoriteService().searchFromWishList(context, searchController.text);
                    searchController.clear();
                    if(response?.responseData?.success==true){
                      FocusScope.of(context).unfocus();
                      ShowMessage().showMessage(context, "${response?.responseData?.message}", ColorConstants.appPrimaryColor);
                      Navigator.of(context).pushNamed(RouteConstants.wishListSearchedResultPageRoute);
                    }
                  },
                  onChanged: (value){
                    if(value.isNotEmpty){
                      allFavouritesProvider.wishListSearchResponseModel?.data?.where((search)=>search.getBar!.venue!.toLowerCase().contains(searchController.text)).toList();
                    }
                  },
                  suffixIcon: InkWell(
                    onTap: ()async{
                      var response = await AllFavoriteService().searchFromWishList(context, searchController.text);
                      searchController.clear();
                      if(response?.responseData?.success==true){
                        FocusScope.of(context).unfocus();
                        ShowMessage().showMessage(context, "${response?.responseData?.message}", ColorConstants.appPrimaryColor);
                        Navigator.of(context).pushNamed(RouteConstants.wishListSearchedResultPageRoute);
                      }
                    },
                    child: Icon(
                      Icons.search,
                      size: 20.sp,
                      color: ColorConstants.textGreyColor,
                    ),
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.symmetric(vertical: PaddingExtensions.screenVerticalPadding),
                  child: Text(
                    "Favorites",
                    style: StaticTextStyle().boldTextStyle.copyWith(fontSize: 16.sp, color: ColorConstants.blackColor),

                  ),
                ),
                wishList?.data==null ?Center(child: CircularProgressIndicator(color: ColorConstants.appPrimaryColor,)) :  Expanded(
              child: wishList!.data!.isEmpty ? Center(child: Text("No Favorites yet!")):

              GridView.builder(
                  itemCount:  wishList.data!.length,
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.zero,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 30.sp,
                      mainAxisSpacing: 20.sp,
                      childAspectRatio: 2 / 3),
                  itemBuilder: (context, index) {
                    var myFavourites = wishList.data![index];
                    return InkWell(
                      onTap: (){
                        Navigator.of(context).pushNamed(RouteConstants.barDetailPage,arguments: myFavourites.barId);

                      },
                      child: Stack(
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
                                  leftPadding: 0.sp,
                                  onPress: ()async{
                                    var response =await AllFavoriteService().toggle(context, myFavourites.barId);
                                    print(response);
                                    if(response?.responseData?.success==true){
                                      ShowMessage().showMessage(context, "added bar to Favorites!", ColorConstants.appPrimaryColor);
                                    }else{
                                      ShowMessage().showMessage(context, "removed bar from Favorites!", ColorConstants.appPrimaryColor);

                                    }
                                  },
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
                                    Navigator.of(context).pushNamed(RouteConstants.promotionsPageRoute,arguments:  {
                                      "barId":myFavourites.barId,
                                      "coverImage":myFavourites.getBar?.barInfo?[1]
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
                      ),
                    );
                  })

            )


              ],
            ),
          );
        }
      ),
    );
  }
}
