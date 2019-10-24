import 'dart:convert';

import 'LatLng.dart';
import 'Location.dart';

class Scooter {
  int idScooter;
  String idCity;
  String scooterCode;
  String idScooterState;
  LatLng latLng;
  double distance;
  String powerPercent;
  String remainderRange;
  int powerPercentInt;
  String scooterModel;
  bool isBookable;
  bool isTootable;
  String streetInfo;
  String streetInfo2;
  String txtRentalPrice;
  int bookingDurationMinutes;
  bool showRoute;
  String distanceTxt;
  bool locked;
  Location location;
  String googleMapsMode;
  int googleMapsEstimatedTimeRatio;
  bool costEstimationEnabled;
  String cityName;
  String scooterStatus;
  int gsmCoverage;
  int satelliteNumber;
  String gpsStatusTxt;
  String gpsStatusSort;
  int gpsStatusInt;
  String iotStatusTxt;
  String iotStatusSort;
  int iotStatusInt;
  String txtCode;
  String sortCode;
  String txtModel;
  String sortModel;
  String txtLocation;
  double sortLocation;
  String txtPower;
  int sortPower;
  String txtGsm;
  String sortGsm;
  String txtGps;
  String sortGps;
  String txtStatus;
  String sortStatus;

  Scooter({
    this.idScooter,
    this.idCity,
    this.scooterCode,
    this.idScooterState,
    this.latLng,
    this.distance,
    this.powerPercent,
    this.remainderRange,
    this.powerPercentInt,
    this.scooterModel,
    this.isBookable,
    this.isTootable,
    this.streetInfo,
    this.streetInfo2,
    this.txtRentalPrice,
    this.bookingDurationMinutes,
    this.showRoute,
    this.distanceTxt,
    this.locked,
    this.location,
    this.googleMapsMode,
    this.googleMapsEstimatedTimeRatio,
    this.costEstimationEnabled,
    this.cityName,
    this.scooterStatus,
    this.gsmCoverage,
    this.satelliteNumber,
    this.gpsStatusTxt,
    this.gpsStatusSort,
    this.gpsStatusInt,
    this.iotStatusTxt,
    this.iotStatusSort,
    this.iotStatusInt,
    this.txtCode,
    this.sortCode,
    this.txtModel,
    this.sortModel,
    this.txtLocation,
    this.sortLocation,
    this.txtPower,
    this.sortPower,
    this.txtGsm,
    this.sortGsm,
    this.txtGps,
    this.sortGps,
    this.txtStatus,
    this.sortStatus,
  });

  factory Scooter.fromRawJson(String str) => Scooter.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Scooter.fromJson(Map<String, dynamic> json) => Scooter(
    idScooter: json["idScooter"] == null ? null : json["idScooter"],
    idCity: json["idCity"] == null ? null : json["idCity"],
    scooterCode: json["ScooterCode"] == null ? null : json["ScooterCode"],
    idScooterState: json["idScooterState"] == null ? null : json["idScooterState"],
    latLng: json["LatLng"] == null ? null : LatLng.fromJson(json["LatLng"]),
    distance: json["Distance"] == null ? null : json["Distance"].toDouble(),
    powerPercent: json["PowerPercent"] == null ? null : json["PowerPercent"],
    remainderRange: json["RemainderRange"] == null ? null : json["RemainderRange"],
    powerPercentInt: json["PowerPercentInt"] == null ? null : json["PowerPercentInt"],
    scooterModel: json["ScooterModel"] == null ? null : json["ScooterModel"],
    isBookable: json["IsBookable"] == null ? null : json["IsBookable"],
    isTootable: json["IsTootable"] == null ? null : json["IsTootable"],
    streetInfo: json["StreetInfo"] == null ? null : json["StreetInfo"],
    streetInfo2: json["StreetInfo2"] == null ? null : json["StreetInfo2"],
    txtRentalPrice: json["txtRentalPrice"] == null ? null : json["txtRentalPrice"],
    bookingDurationMinutes: json["BookingDurationMinutes"] == null ? null : json["BookingDurationMinutes"],
    showRoute: json["ShowRoute"] == null ? null : json["ShowRoute"],
    distanceTxt: json["Distance_txt"] == null ? null : json["Distance_txt"],
    locked: json["Locked"] == null ? null : json["Locked"],
    location: json["location"] == null ? null : Location.fromJson(json["location"]),
    googleMapsMode: json["GoogleMapsMode"] == null ? null : json["GoogleMapsMode"],
    googleMapsEstimatedTimeRatio: json["GoogleMapsEstimatedTimeRatio"] == null ? null : json["GoogleMapsEstimatedTimeRatio"],
    costEstimationEnabled: json["CostEstimationEnabled"] == null ? null : json["CostEstimationEnabled"],
    cityName: json["CityName"] == null ? null : json["CityName"],
    scooterStatus: json["ScooterStatus"] == null ? null : json["ScooterStatus"],
    gsmCoverage: json["GSMCoverage"] == null ? null : json["GSMCoverage"],
    satelliteNumber: json["SatelliteNumber"] == null ? null : json["SatelliteNumber"],
    gpsStatusTxt: json["GPSStatus_txt"] == null ? null : json["GPSStatus_txt"],
    gpsStatusSort: json["GPSStatus_sort"] == null ? null : json["GPSStatus_sort"],
    gpsStatusInt: json["GPSStatus_int"] == null ? null : json["GPSStatus_int"],
    iotStatusTxt: json["IOTStatus_txt"] == null ? null : json["IOTStatus_txt"],
    iotStatusSort: json["IOTStatus_sort"] == null ? null : json["IOTStatus_sort"],
    iotStatusInt: json["IOTStatus_int"] == null ? null : json["IOTStatus_int"],
    txtCode: json["txt_Code"] == null ? null : json["txt_Code"],
    sortCode: json["sort_Code"] == null ? null : json["sort_Code"],
    txtModel: json["txt_Model"] == null ? null : json["txt_Model"],
    sortModel: json["sort_Model"] == null ? null : json["sort_Model"],
    txtLocation: json["txt_Location"] == null ? null : json["txt_Location"],
    sortLocation: json["sort_Location"] == null ? null : json["sort_Location"].toDouble(),
    txtPower: json["txt_Power"] == null ? null : json["txt_Power"],
    sortPower: json["sort_Power"] == null ? null : json["sort_Power"],
    txtGsm: json["txt_GSM"] == null ? null : json["txt_GSM"],
    sortGsm: json["sort_GSM"] == null ? null : json["sort_GSM"],
    txtGps: json["txt_GPS"] == null ? null : json["txt_GPS"],
    sortGps: json["sort_GPS"] == null ? null : json["sort_GPS"],
    txtStatus: json["txt_Status"] == null ? null : json["txt_Status"],
    sortStatus: json["sort_Status"] == null ? null : json["sort_Status"],
  );

  Map<String, dynamic> toJson() => {
    "idScooter": idScooter == null ? null : idScooter,
    "idCity": idCity == null ? null : idCity,
    "ScooterCode": scooterCode == null ? null : scooterCode,
    "idScooterState": idScooterState == null ? null : idScooterState,
    "LatLng": latLng == null ? null : latLng.toJson(),
    "Distance": distance == null ? null : distance,
    "PowerPercent": powerPercent == null ? null : powerPercent,
    "RemainderRange": remainderRange == null ? null : remainderRange,
    "PowerPercentInt": powerPercentInt == null ? null : powerPercentInt,
    "ScooterModel": scooterModel == null ? null : scooterModel,
    "IsBookable": isBookable == null ? null : isBookable,
    "IsTootable": isTootable == null ? null : isTootable,
    "StreetInfo": streetInfo == null ? null : streetInfo,
    "StreetInfo2": streetInfo2 == null ? null : streetInfo2,
    "txtRentalPrice": txtRentalPrice == null ? null : txtRentalPrice,
    "BookingDurationMinutes": bookingDurationMinutes == null ? null : bookingDurationMinutes,
    "ShowRoute": showRoute == null ? null : showRoute,
    "Distance_txt": distanceTxt == null ? null : distanceTxt,
    "Locked": locked == null ? null : locked,
    "location": location == null ? null : location.toJson(),
    "GoogleMapsMode": googleMapsMode == null ? null : googleMapsMode,
    "GoogleMapsEstimatedTimeRatio": googleMapsEstimatedTimeRatio == null ? null : googleMapsEstimatedTimeRatio,
    "CostEstimationEnabled": costEstimationEnabled == null ? null : costEstimationEnabled,
    "CityName": cityName == null ? null : cityName,
    "ScooterStatus": scooterStatus == null ? null : scooterStatus,
    "GSMCoverage": gsmCoverage == null ? null : gsmCoverage,
    "SatelliteNumber": satelliteNumber == null ? null : satelliteNumber,
    "GPSStatus_txt": gpsStatusTxt == null ? null : gpsStatusTxt,
    "GPSStatus_sort": gpsStatusSort == null ? null : gpsStatusSort,
    "GPSStatus_int": gpsStatusInt == null ? null : gpsStatusInt,
    "IOTStatus_txt": iotStatusTxt == null ? null : iotStatusTxt,
    "IOTStatus_sort": iotStatusSort == null ? null : iotStatusSort,
    "IOTStatus_int": iotStatusInt == null ? null : iotStatusInt,
    "txt_Code": txtCode == null ? null : txtCode,
    "sort_Code": sortCode == null ? null : sortCode,
    "txt_Model": txtModel == null ? null : txtModel,
    "sort_Model": sortModel == null ? null : sortModel,
    "txt_Location": txtLocation == null ? null : txtLocation,
    "sort_Location": sortLocation == null ? null : sortLocation,
    "txt_Power": txtPower == null ? null : txtPower,
    "sort_Power": sortPower == null ? null : sortPower,
    "txt_GSM": txtGsm == null ? null : txtGsm,
    "sort_GSM": sortGsm == null ? null : sortGsm,
    "txt_GPS": txtGps == null ? null : txtGps,
    "sort_GPS": sortGps == null ? null : sortGps,
    "txt_Status": txtStatus == null ? null : txtStatus,
    "sort_Status": sortStatus == null ? null : sortStatus,
  };
}