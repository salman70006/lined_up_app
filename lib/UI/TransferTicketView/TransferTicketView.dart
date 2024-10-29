import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:com.zat.linedup/Components/Extentions/PaddingExtentions.dart';
import 'package:com.zat.linedup/Components/ScaffoldMessageWidget/ScaffoldMessageWidget.dart';
import 'package:com.zat.linedup/Components/StaticTextStyle/StaticTextStyle.dart';
import 'package:com.zat.linedup/Controllers/AllUsersService/AllUsersService.dart';
import 'package:com.zat.linedup/Controllers/TransferTicketService/TransferTicketService.dart';
import 'package:com.zat.linedup/Providers/AllUsersProvider/AllUsersProvider.dart';
import 'package:com.zat.linedup/Utils/Constants/AssetConstants/AssetConstants.dart';
import 'package:com.zat.linedup/Utils/Constants/ColorConstants/ColorConstants.dart';
import 'package:provider/provider.dart';

import '../../Components/CustomAppButton/CustomAppButton.dart';
import '../../Components/CustomOutlineTextField/CustomOutlineTextField.dart';

class TransferTicketView extends StatefulWidget {
  var ticketId;
   TransferTicketView({this.ticketId});

  @override
  State<TransferTicketView> createState() => _TransferTicketViewState();
}

class _TransferTicketViewState extends State<TransferTicketView> {
  int? selectedValue;
  AllUsersService allUsersService = AllUsersService();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    debugPrint("Ticket Id::${widget.ticketId}");
    allUsersService.getAllUsers(context);
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        if (details.delta.dx > 0) {
          Navigator.of(context).pop();
          print("abck");
        }
      },
      child: Scaffold(
        bottomNavigationBar:
        Consumer<AllUsersProvider>(
          builder: (context, allUserProvider,_) {
            return Padding(
              padding:  EdgeInsets.symmetric(vertical: 20.sp,horizontal: 22.sp),
              child: CustomAppButton(
                title: "Transfer",
                btnRadius: 10.sp,
                height: 58.sp,
                width: 330.sp,
                onPress: ()async{
                  showDialog(context: context, builder: (context){
                    return Dialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.sp),
                      ),
                      insetPadding: EdgeInsets.only(left: 16,right: 16.sp,top: 16.sp),
                      child: Container(
                        padding: EdgeInsets.only(left: 25.sp,right: 25.sp),
                        height: 240.sp,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20.sp,
                            ),
                            Text("Transfer Ticket",style: StaticTextStyle().boldTextStyle.copyWith(
                              fontSize: 24.sp,
                              color: ColorConstants.appPrimaryColor
                            ),),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 10.sp),
                              child: Text(
                                "Are you sure\nYou want to transfer your ticket",
                                style: StaticTextStyle().regular.copyWith(
                                  fontSize: 16.sp,
                                  color: ColorConstants.blackColor
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            CustomAppButton(
                              title: "Yes",
                              onPress: ()async{
                                var response = await TransferTicketService().transferTicket(context,widget.ticketId.toString(),allUserProvider.selectedUserId.toString());
                                print(response);
                                if(response!.responseData?.success==true){
                                  ShowMessage().showMessage(context, response.responseData!.message.toString(), ColorConstants.appPrimaryColor);
                                  showDialog(context: context, builder: (context){
                                    return Dialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8.sp),
                                      ),
                                      insetPadding: EdgeInsets.only(left: 16,right: 16.sp,top: 16.sp),
                                      child: Container(
                                        padding: EdgeInsets.only(left: 25.sp,right: 25.sp),
                                        height: 150.sp,
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 20.sp,
                                            ),
                                            Text("Successful!",style: StaticTextStyle().boldTextStyle.copyWith(
                                                fontSize: 24.sp,
                                                color: ColorConstants.appPrimaryColor
                                            ),),
                                            Padding(
                                              padding: EdgeInsets.symmetric(vertical: 10.sp),
                                              child: Text(
                                                "Your ticket is transferred successfully",
                                                style: StaticTextStyle().regular.copyWith(
                                                    fontSize: 15.sp,
                                                    color: ColorConstants.blackColor
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            CustomAppButton(
                                              title: "Okay",
                                              onPress: (){
                                                Navigator.of(context)..pop()..pop()..pop();


                                                // Navigator.of(context).pushNamed(RouteConstants.paymentMethodsPageRoute);
                                              },
                                            ),

                                          ],
                                        ),
                                      ),
                                    );
                                  }
                                  );
                                }else{
                                  ShowMessage().showMessage(context, "${response.responseData?.message.toString()}", ColorConstants.redColor);

                                }


                                // Navigator.of(context).pushNamed(RouteConstants.paymentMethodsPageRoute);
                              },
                            ),
                            Padding(
                              padding:  EdgeInsets.symmetric(vertical: 10.sp),
                              child: CustomAppButton(
                                title: "No",
                                onPress: (){
                                  Navigator.of(context).pop();
                                },
                              ),
                            )

                          ],
                        ),
                      ),
                    );
                  }
                  );
                },
              ),
            );
          }
        ),
        body: Consumer<AllUsersProvider>(
          builder: (context, allUsersProvider,_) {
            var allUsers = allUsersProvider.allUsersResponseModel;
            return allUsers?.data==null?Center(child: CircularProgressIndicator(
              color: ColorConstants.appPrimaryColor,
            ),) :Padding(
              padding:  EdgeInsets.only(top: PaddingExtensions.screenTopPadding,left: 22.sp,right: 22.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 46.sp,
                      width: 46.sp,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: ColorConstants.whiteColor
                      ),
                      child: Padding(
                        padding:  EdgeInsets.only(left:6.sp),
                        child: Icon(
                          Icons.arrow_back_ios,size: 20.sp,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.symmetric(vertical: 20.sp),
                    child: Text(
                      "Search User",
                      style: StaticTextStyle().boldTextStyle.copyWith(
                        fontSize: 24.sp,
                        fontFamily: urbanBold,
                        color: ColorConstants.blackColor
                      ),
                    ),
                  ),
                  CustomOutlineTextFormField(
                    hintText: "Search",
                    filled: true,
                    cursorColor: ColorConstants.blackColor,
                    filledColor: ColorConstants.whiteColor,
                    borderSideColor: ColorConstants.whiteColor,
                    borderRadius: 30.sp,
                    contentPadding: EdgeInsets.only(left: 24.sp, top: 10.sp, bottom: 10.sp),
                    suffixIcon: Icon(
                      Icons.search,
                      size: 20.sp,
                      color: ColorConstants.textGreyColor,
                    ),
                  ),
                  Expanded(
                      child: Container(
                        margin: EdgeInsets.only(top: 15.sp),
                        padding: EdgeInsets.only(top: 10.sp),
                        decoration: BoxDecoration(
                          color: ColorConstants.whiteColor,
                          borderRadius: BorderRadius.circular(16.sp),
                          boxShadow: [
                            BoxShadow(
                              spreadRadius: 0.sp,
                              blurRadius: 0.6.sp,
                              color: ColorConstants.blackColor.withOpacity(0.2.sp)
                            ),
                          ]
                        ),
                        child: ListView.builder(
                            itemCount: allUsers?.data!.length,
                            padding: EdgeInsets.zero,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context,index){
                              var user = allUsers?.data![index];
                              return Padding(
                                padding:  EdgeInsets.only(bottom: 10.sp,right: 15.sp,left: 15.sp),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                   Row(
                                     children: [
                                       user?.profileImage!=null? Container(
                                           height: 36.sp,
                                           width: 36.sp,
                                           decoration: BoxDecoration(
                                             shape: BoxShape.circle
                                           ),
                                           child: Image.network(user!.profileImage.toString())): SvgPicture.asset(AssetConstants.userProfileIcon),
                                       SizedBox(
                                         width: 10.sp,
                                       ),
                                       Column(
                                         crossAxisAlignment: CrossAxisAlignment.start,
                                         children: [
                                           Text(
                                             user?.userName??"",
                                             style: StaticTextStyle().boldTextStyle.copyWith(
                                                 fontSize: 18.sp,
                                                 fontFamily: arimoBold,
                                                 color: ColorConstants.blackColor
                                             ),
                                           ),
                                           Text(
                                             user?.email??"",
                                             style: StaticTextStyle().regular.copyWith(
                                                 fontSize: 12.sp,
                                                 fontFamily: arimoBold,
                                                 color: ColorConstants.blackColor
                                             ),
                                           )
                                         ],
                                       ),

                                     ],
                                   ),
                                   Radio(
                                       activeColor: ColorConstants.appPrimaryColor,
                                       visualDensity: VisualDensity.compact,
                                       materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                       value: user!.id, groupValue: allUsersProvider.selectedUserId, onChanged: (newValue){

                                       allUsersProvider.UserId(newValue!);


                                   })
                                  ],
                                ),
                              );
                            }),
                      ),
                  )
                ],
              ),
            );
          }
        ),
      ),
    );
  }
}
