import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:com.zat.linedup/Providers/AllBarsProvider/AllBarsProvider.dart';
import 'package:com.zat.linedup/Providers/UserProfileProvider/UserProfileProvider.dart';
import 'package:provider/provider.dart';
import '../../Utils/Constants/RouteConstants/RouteConstants.dart';
import 'dart:ui' as ui;

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Completer<GoogleMapController> _controller = Completer();

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }
  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }


  @override
  void initState(){
    super.initState();
    getPicture();
  }
  Uint8List? markerIcon;
  getPicture()async{
    markerIcon = await getBytesFromAsset("assets/Images/location_pic.png",80);

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
        body: Consumer2<AllBarsProvider, UserProfileProvider>(
            builder: (context, allBarsProvider, userProfileProvider, _) {
          var bars = allBarsProvider.allBarsResponseModel?.barData;
          var profileData = userProfileProvider.userProfileResponseModel?.data;
          return Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: GoogleMap(
                      myLocationButtonEnabled: true,
                      onMapCreated: _onMapCreated,
                      initialCameraPosition: CameraPosition(
                        target: LatLng(
                            double.parse(profileData!.latitude.toString()),
                            double.parse(profileData.longitude.toString())),
                        zoom: 11.0,
                      ),
                      markers:
                          Set<Marker>.of(List.generate(bars!.length, (index) {
                        return Marker(
                            markerId: MarkerId(
                              bars[index].id.toString(),
                            ),
                            icon:  markerIcon!=null? BitmapDescriptor.fromBytes(markerIcon!):BitmapDescriptor.defaultMarker,

                            infoWindow: InfoWindow(title: bars[index].venue),
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                  RouteConstants.eventPageRoute,
                                  arguments: {
                                    "eventId": bars[index].id,
                                    "lat": bars[index].latitude,
                                    "long": bars[index].longitude
                                  });
                            },

                            position: bars[index].latitude != null &&
                                    bars[index].longitude != null
                                ? LatLng(
                                    double.parse("${bars[index].latitude}"),
                                    double.parse("${bars[index].longitude}"))
                                : LatLng(0.0, 0.0));
                      })),
                    ),
                  ),
                ],
              ),
            ],
          );
        }),
      ),
    );
  }
}
