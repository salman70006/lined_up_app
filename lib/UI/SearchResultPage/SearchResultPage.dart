import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:com.zat.linedup/Components/BackButtonWidget/BackButtonWidget.dart';
import 'package:com.zat.linedup/Providers/AllBarsProvider/AllBarsProvider.dart';
import 'package:provider/provider.dart';

import '../../Components/CacheNetworkImage/CacheNetworkImage.dart';
import '../../Components/PromotionContainer/PromotionContainer.dart';
import '../../Components/StaticTextStyle/StaticTextStyle.dart';
import '../../Utils/Constants/ColorConstants/ColorConstants.dart';
import '../../Utils/Constants/RouteConstants/RouteConstants.dart';

class SearchResultPage extends StatefulWidget {
  const SearchResultPage({super.key});

  @override
  State<SearchResultPage> createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  bool? showLoading=true;
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
      body: Consumer<AllBarsProvider>(
        builder: (context, allBarsProvider,_) {
          var searchedBar = allBarsProvider.homeSearchResponseModel?.searchData;
          return searchedBar!.isEmpty?Text("No bars matched with search!") : Container(
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.only(top: 40.sp,left: 12.sp,right: 12.sp),
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
                    SizedBox(width: 30.sp,),
                  ],
                ),

                Expanded(
                  child: GridView.builder(
                      itemCount: searchedBar.length,
                      padding: EdgeInsets.only(top: 30.sp),
                      gridDelegate:
                      SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 10.sp,
                          mainAxisSpacing: 10.sp,
                          childAspectRatio: 2 / 3),
                      itemBuilder: (context,sIndex){
                  
                        return InkWell(
                          onTap: (){
                            Navigator.of(context).pushNamed(
                                RouteConstants.barDetailPage,
                                arguments: searchedBar[sIndex].id);
                          },
                          child: Stack(
                            alignment: AlignmentDirectional.bottomCenter,
                            children: [
                              ImageWidget(
                                imageUrl: searchedBar[sIndex].coverImage,
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
                                    Text(
                                      searchedBar[sIndex].venue.toString() ?? "",
                                      style: StaticTextStyle()
                                          .boldTextStyle
                                          .copyWith(
                                        fontSize: 12.sp,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 5),
                                      child: Text(
                                        searchedBar[sIndex].address.toString() ?? "",
                                        style: StaticTextStyle()
                                            .regular
                                            .copyWith(
                                            fontSize: 12.sp,
                                            fontFamily:
                                            englishItalic),
                                      ),
                                    ),
                                    Text(
                                      "Opening \n${searchedBar[sIndex].startTime}-${searchedBar[sIndex].endTime}" ??
                                          "",
                                      style: StaticTextStyle()
                                          .regular
                                          .copyWith(
                                          fontSize: 12.sp,
                                          fontFamily:
                                          englishItalic),
                                    ),
                                    searchedBar[sIndex].havePromotion == false
                                        ? SizedBox()
                                        : PromotionContainer(
                                      title: "Promotions",
                                      containerColor:
                                      ColorConstants
                                          .appPrimaryColor,
                                    )
                                  ],
                                ),
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
