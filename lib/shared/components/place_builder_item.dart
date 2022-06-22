import 'package:engaz_task/models/place_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PlaceBuilderItem extends StatefulWidget {
  PlaceDataModel? placeDataModel;
  String? pressedPlace;
  Function? onTap;
  PlaceBuilderItem({
    Key? key,
    required this.placeDataModel,
    required this.pressedPlace,
    required this.onTap,
  }) : super(key: key);

  @override
  State<PlaceBuilderItem> createState() => _PlaceBuilderItemState();
}

class _PlaceBuilderItemState extends State<PlaceBuilderItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onTap!(),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        decoration: BoxDecoration(
          color:
              widget.pressedPlace == widget.placeDataModel!.placesID.toString()
                  ? Colors.red
                  : Colors.white,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Center(
          child: Text(
            widget.placeDataModel!.placeName.toString(),
            style: TextStyle(
              color: widget.pressedPlace ==
                      widget.placeDataModel!.placesID.toString()
                  ? Colors.white
                  : Colors.black,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
