import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:engaz_task/cubits/app_cubit/app_cubit.dart';
import 'package:engaz_task/cubits/app_cubit/app_states.dart';
import 'package:engaz_task/shared/components/place_builder_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GoogleMapController? googleMapController;
  String? pressedPlace;

  @override
  void initState() {
    AppCubit.get(context).getPlaces(context: context);
    AppCubit.get(context).getMarkers(context: context);
    super.initState();
  }

  @override
  void dispose() {
    googleMapController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    return BlocBuilder<AppCubit, AppStates>(
      builder: (BuildContext context, state) => Scaffold(
        appBar: null,
        body: ConditionalBuilder(
          condition: state is AppGetPlacesSuccessState,
          builder: (BuildContext context) => Stack(
            children: [
              GoogleMap(
                mapType: MapType.normal,
                myLocationButtonEnabled: false,
                zoomControlsEnabled: false,
                zoomGesturesEnabled: true,
                myLocationEnabled: true,
                onMapCreated: (GoogleMapController controller) {
                  googleMapController = controller;
                  setState(() {});
                },
                initialCameraPosition: CameraPosition(
                  target: LatLng(
                    cubit.currentUserLatLng!.latitude,
                    cubit.currentUserLatLng!.longitude,
                  ),
                  zoom: 14.47460,
                ),
                markers: cubit.markers,
              ),
              Padding(
                padding: EdgeInsetsDirectional.only(top: 30.h),
                child: Align(
                  alignment: AlignmentDirectional.topStart,
                  child: SizedBox(
                    height: 30.h,
                    child: ListView.separated(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) => Row(
                        children: [
                          if (index == 0) SizedBox(width: 20.w),
                          PlaceBuilderItem(
                            placeDataModel: cubit.placeModel!.data![index],
                            pressedPlace: pressedPlace,
                            onTap: () {
                              setState(() {
                                pressedPlace = cubit
                                    .placeModel!.data![index].placesID
                                    .toString();
                                googleMapController!.animateCamera(
                                  CameraUpdate.newCameraPosition(
                                    CameraPosition(
                                      target: LatLng(
                                        double.parse(cubit
                                            .placeModel!.data![index].lat!),
                                        double.parse(cubit
                                            .placeModel!.data![index].longt!),
                                      ),
                                      zoom: 18.0,
                                    ),
                                  ),
                                );
                              });
                            },
                          ),
                          if (index == 9) SizedBox(width: 20.w),
                        ],
                      ),
                      separatorBuilder: (BuildContext context, int index) =>
                          SizedBox(width: 10.w),
                      itemCount: cubit.placeModel!.data!.length,
                    ),
                  ),
                ),
              ),
            ],
          ),
          fallback: (BuildContext context) => const SizedBox(),
        ),
      ),
    );
  }
}
