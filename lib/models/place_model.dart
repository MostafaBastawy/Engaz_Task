class PlaceModel {
  int? statusCode;
  bool? status;
  List<PlaceDataModel>? data = [];
  String? message;
  PlaceModel({
    this.statusCode,
    this.status,
    this.data,
    this.message,
  });

  PlaceModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    status = json['success'];
    json['data'] != []
        ? json['data'].forEach((element) {
            data!.add(PlaceDataModel.fromJson(element));
          })
        : data = [];
    message = json['message'];
  }
}

class PlaceDataModel {
  String? placesID;
  String? lat;
  String? longt;
  String? placeName;
  String? description;
  String? photo;
  PlaceDataModel({
    this.placesID,
    this.lat,
    this.longt,
    this.placeName,
    this.description,
    this.photo,
  });

  PlaceDataModel.fromJson(Map<String, dynamic> json) {
    placesID = json['PlacesID'];
    lat = json['Lat'];
    longt = json['Longt'];
    placeName = json['PlaceName'];
    description = json['description'];
    photo = json['Photo'];
  }
}
