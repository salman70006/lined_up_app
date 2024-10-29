
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:com.zat.linedup/Components/StaticTextStyle/StaticTextStyle.dart';
import 'package:com.zat.linedup/UI/AppHomePage/AppHomepage.dart';
import 'package:com.zat.linedup/UI/FavoritesPage/Favoritespage.dart';
import 'package:com.zat.linedup/UI/ProfileTabPage/ProfileTabPage.dart';
import 'package:com.zat.linedup/UI/WalletTabbarPages/WalletTabbarPages.dart';
import 'package:provider/provider.dart';

import '../../Providers/SocialLoginsAuthProvider/SocailLoginsAuthProvider.dart';
import '../../Utils/Constants/AssetConstants/AssetConstants.dart';
import '../../Utils/Constants/ColorConstants/ColorConstants.dart';

class AppBottomBarPage extends StatefulWidget {
  // c  BottomNavigationBarUI({});

  @override
  State<AppBottomBarPage> createState() =>
      _AppBottomBarPageState();
}

class _AppBottomBarPageState
    extends State<AppBottomBarPage> {
  int _selectedIndex = 0;

  List<Widget?> bottomPages=[
    const AppHomePage(),
          FavoritesPage(),
    WalletTabBarPage(),
    ProfileTabPage()
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bottomPages.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: StaticTextStyle().regular.copyWith(
          fontSize: 10.sp,
        ),
        unselectedLabelStyle: StaticTextStyle().regular.copyWith(
          fontSize: 10.sp
        ),
        elevation: 5,
        items:  <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: SvgPicture.asset(AssetConstants.homeIcon,height: 24.sp,width: 24.sp,color: _selectedIndex==0?ColorConstants.appPrimaryColor: ColorConstants.textGreyColor,),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(AssetConstants.heartOutlineIcon,height: 24.sp,width: 24.sp,color: _selectedIndex==1?ColorConstants.appPrimaryColor:ColorConstants.textGreyColor),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(AssetConstants.calendarBottomBarIcon,height: 24.sp,width: 24.sp,color: _selectedIndex==2?ColorConstants.appPrimaryColor: ColorConstants.textGreyColor,),

            label: 'Wallet',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(AssetConstants.profileIcon,height: 24.sp,width: 24.sp,color: _selectedIndex==3?ColorConstants.appPrimaryColor:ColorConstants.textGreyColor),
            label: 'Profile',
          ),

        ],
        currentIndex: _selectedIndex,
        selectedItemColor: ColorConstants.appPrimaryColor,
        unselectedItemColor: ColorConstants.textGreyColor,
        onTap: _onItemTapped,
      ),
    );
  }
}