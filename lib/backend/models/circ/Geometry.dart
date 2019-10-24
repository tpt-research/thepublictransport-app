import 'dart:convert';

import 'MFigure.dart';
import 'MPoint.dart';
import 'MShape.dart';

class Geometry {
  List<MPoint> mPoints;
  dynamic mZValues;
  dynamic mMValues;
  List<MFigure> mFigures;
  List<MShape> mShapes;
  bool mFValid;
  String mExtendedUserProperties;

  Geometry({
    this.mPoints,
    this.mZValues,
    this.mMValues,
    this.mFigures,
    this.mShapes,
    this.mFValid,
    this.mExtendedUserProperties,
  });

  factory Geometry.fromRawJson(String str) => Geometry.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
    mPoints: json["m_points"] == null ? null : List<MPoint>.from(json["m_points"].map((x) => MPoint.fromJson(x))),
    mZValues: json["m_zValues"],
    mMValues: json["m_mValues"],
    mFigures: json["m_figures"] == null ? null : List<MFigure>.from(json["m_figures"].map((x) => MFigure.fromJson(x))),
    mShapes: json["m_shapes"] == null ? null : List<MShape>.from(json["m_shapes"].map((x) => MShape.fromJson(x))),
    mFValid: json["m_fValid"] == null ? null : json["m_fValid"],
    mExtendedUserProperties: json["m_extendedUserProperties"] == null ? null : json["m_extendedUserProperties"],
  );

  Map<String, dynamic> toJson() => {
    "m_points": mPoints == null ? null : List<dynamic>.from(mPoints.map((x) => x.toJson())),
    "m_zValues": mZValues,
    "m_mValues": mMValues,
    "m_figures": mFigures == null ? null : List<dynamic>.from(mFigures.map((x) => x.toJson())),
    "m_shapes": mShapes == null ? null : List<dynamic>.from(mShapes.map((x) => x.toJson())),
    "m_fValid": mFValid == null ? null : mFValid,
    "m_extendedUserProperties": mExtendedUserProperties == null ? null : mExtendedUserProperties,
  };
}