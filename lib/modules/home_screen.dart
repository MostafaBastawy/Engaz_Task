import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:engaz_task/cubits/app_cubit/app_cubit.dart';
import 'package:engaz_task/cubits/app_cubit/app_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    return BlocBuilder<AppCubit, AppStates>(
      builder: (BuildContext context, state) => Scaffold(
        appBar: null,
        body: Stack(
          children: [
            ConditionalBuilder(
              condition: state is! AppGetPlacesLoadingState,
              builder: (BuildContext context) => GoogleMap(
                mapType: MapType.normal,
                myLocationButtonEnabled: false,
                zoomControlsEnabled: false,
                zoomGesturesEnabled: true,
                myLocationEnabled: true,
                onMapCreated: (GoogleMapController controller) {},
                initialCameraPosition: CameraPosition(
                  target: LatLng(12.0, 45.05
                      // cubit.currentUserLatLng!.latitude,
                      // cubit.currentUserLatLng!.longitude,
                      ),
                  zoom: 14.47460,
                ),
                markers: cubit.markers,
              ),
              fallback: (BuildContext context) => const SizedBox(),
            ),
            Align(
              alignment: AlignmentDirectional.topCenter,
            ),
          ],
        ),
      ),
    );
  }
}
