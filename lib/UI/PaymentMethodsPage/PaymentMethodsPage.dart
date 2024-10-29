import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:com.zat.linedup/Components/CustomAppButton/CustomAppButton.dart';
import 'package:com.zat.linedup/Components/StaticTextStyle/StaticTextStyle.dart';
import 'package:com.zat.linedup/Utils/Constants/ColorConstants/ColorConstants.dart';
import 'package:webview_flutter/webview_flutter.dart';
class PaymentMethodsPage extends StatefulWidget {
  var paymentUrl;

  PaymentMethodsPage({this.paymentUrl});

  @override
  State<PaymentMethodsPage> createState() => _PaymentMethodsPageState();
}

class _PaymentMethodsPageState extends State<PaymentMethodsPage> {
  WebViewController webViewController = WebViewController();
  var loading = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.paymentUrl);
webViewController..setJavaScriptMode(JavaScriptMode.unrestricted);
  }

  @override
  Widget build(BuildContext context) {
    print(widget.paymentUrl);
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        if (details.delta.dx > 0) {
          Navigator.of(context)..pop()..pop();
          print("abck");
        }
      },
      child: Scaffold(
        body: widget.paymentUrl==null? CircularProgressIndicator(): Container(
          child: Stack(
            children: [
              WebViewWidget(
                controller:  webViewController
                  ..loadRequest(Uri.parse(widget.paymentUrl)),

              ),
              loading < 100
                  ? LinearProgressIndicator(
                      color: Colors.red,
                      value: loading / 100.0,
                    )
                  : Container()
            ],
          ),
        ),
      ),
    );
  }

  void _showBookingSuccessMessageDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.sp),
              ),
              insetPadding: EdgeInsets.only(left: 16, right: 16.sp, top: 16.sp),
              child: Container(
                  padding:
                      EdgeInsets.only(left: 25.sp, right: 25.sp, top: 20.sp),
                  height: 260.sp,
                  width: double.infinity,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            "Successful!",
                            style: StaticTextStyle().boldTextStyle.copyWith(
                                fontSize: 24.sp,
                                color: ColorConstants.appPrimaryColor),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 15.sp),
                          child: Center(
                            child: SizedBox(
                              child: Text(
                                "Your booking can’t be canceled/refunded. Thank you for using LinedUp!",
                                textAlign: TextAlign.center,
                                style: StaticTextStyle().regular.copyWith(
                                      fontSize: 14.sp,
                                      color: ColorConstants.blackColor,
                                    ),
                              ),
                            ),
                          ),
                        ),
                        CustomAppButton(
                          title: "Okay",
                          onPress: () {},
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.sp),
                          child: CustomAppButton(
                            title: "Cancel",
                            textColor: ColorConstants.blackColor,
                            btnColor: ColorConstants.cancelButtonColor,
                            onPress: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        )
                      ])));
        });
  }
}
