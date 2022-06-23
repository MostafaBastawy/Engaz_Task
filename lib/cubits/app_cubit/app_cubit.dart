import 'dart:collection';
import 'dart:convert';

import 'package:engaz_task/cubits/app_cubit/app_states.dart';
import 'package:engaz_task/models/place_model.dart';
import 'package:engaz_task/shared/components/place_details_builder_item.dart';
import 'package:engaz_task/shared/tools/dio_helper/dio_helper.dart';
import 'package:engaz_task/shared/tools/dio_helper/end_points.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  PlaceModel? placeModel;
  void getPlaces({
    required BuildContext context,
    required GlobalKey<ScaffoldState> scaffoldKey,
  }) {
    emit(AppGetPlacesLoadingState());
    DioHelper.getData(
      endPoint: dioKeyPlaces,
      headers: {},
      queryParameters: {},
    ).then((value) async {
      var response = jsonDecode(value.toString());
      try {
        if (response['status_code'] == 200) {
          placeModel = PlaceModel.fromJson(response);
          placeModel!.data!.sort(
            (a, b) => int.parse(a.placesID!).compareTo(int.parse(b.placesID!)),
          );
          await getUserCurrentLatLang();
          getMarkers(context: context, scaffoldKey: scaffoldKey);
          emit(AppGetPlacesSuccessState());
        }
      } catch (e) {
        if (response['status_code'] != 200) {
          emit(AppGetPlacesErrorState(response['message']));
        }
      }
    });
  }

  var markers = HashSet<Marker>();
  void getMarkers({
    required BuildContext context,
    required GlobalKey<ScaffoldState> scaffoldKey,
  }) {
    markers = HashSet<Marker>();
    for (int i = 0; i < placeModel!.data!.length; i++) {
      markers.add(
        Marker(
          markerId: MarkerId('${placeModel!.data![i].placesID}'),
          position: LatLng(
            double.parse(placeModel!.data![i].lat!),
            double.parse(placeModel!.data![i].longt!),
          ),
          infoWindow: InfoWindow(
            title: placeModel!.data![i].placeName,
          ),
          onTap: () {
            //print(placeModel!.data![i].placesID);
            scaffoldKey.currentState!.showBottomSheet(
              backgroundColor: const Color.fromRGBO(0, 0, 0, 0.1),
              (context) => PlaceDetailsBuilderItem(
                placeDataModel: placeModel!
                    .data![int.parse(placeModel!.data![i].placesID!) - 1],
              ),
            );
          },
        ),
      );
    }
  }

  Position? currentUserLatLng;
  bool? serviceEnabled;
  LocationPermission? permission;
  Future<void> getUserCurrentLatLang() async {
    emit(AppGetUserCurrentLatLangLoadingState());
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
    }
    currentUserLatLng = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    emit(AppGetUserCurrentLatLangSuccessState());
  }
}
