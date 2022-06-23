import 'package:engaz_task/cubits/app_cubit/app_cubit.dart';
import 'package:engaz_task/models/place_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher_string.dart';

class PlaceDetailsBuilderItem extends StatelessWidget {
  PlaceDataModel? placeDataModel;
  GoogleMapController? googleMapController;
  PlaceDetailsBuilderItem({
    Key? key,
    required this.placeDataModel,
    this.googleMapController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      height: 220.h,
      width: 428.w,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xA0000000).withOpacity(0.20),
            const Color(0xA0000000).withOpacity(0.15),
            const Color(0xA0000000).withOpacity(0.05),
            const Color(0xA0000000).withOpacity(0.0),
          ],
          begin: AlignmentDirectional.bottomCenter,
          end: AlignmentDirectional.topCenter,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CircleAvatar(
            radius: 20.r,
            backgroundColor: const Color(0xFF000000).withOpacity(0.5),
            child: IconButton(
              icon: const Icon(
                Icons.my_location,
                color: Colors.white,
                size: 25,
              ),
              onPressed: () {
                googleMapController!.animateCamera(
                  CameraUpdate.newCameraPosition(
                    CameraPosition(
                      target: LatLng(
                        AppCubit.get(context).currentUserLatLng!.latitude,
                        AppCubit.get(context).currentUserLatLng!.longitude,
                      ),
                      zoom: 14.47460,
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(width: 15.w),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  placeDataModel!.description.toString(),
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 15.sp,
                  ),
                ),
                SizedBox(height: 10.h),
                Container(
                  height: 120.h,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        placeDataModel!.photo.toString(),
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 15.w),
          CircleAvatar(
            radius: 20.r,
            backgroundColor: const Color(0xFF000000).withOpacity(0.5),
            child: IconButton(
              icon: const Icon(
                Icons.map_outlined,
                color: Colors.white,
                size: 25,
              ),
              onPressed: () async {
                await launchUrlString(
                    'https://www.google.com/maps/search/?api=1&query=${placeDataModel!.lat},${placeDataModel!.longt}');
              },
            ),
          ),
        ],
      ),
    );
  }
}
