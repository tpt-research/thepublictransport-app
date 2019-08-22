import 'dart:convert';

import 'package:thepublictransport_app/backend/models/fluxfail/Pagination.dart';
import 'package:thepublictransport_app/backend/models/fluxfail/Report.dart';

class FluxDelayStream {
  Pagination pagination;
  List<Report> reports;

  FluxDelayStream({
    this.pagination,
    this.reports,
  });

  factory FluxDelayStream.fromRawJson(String str) => FluxDelayStream.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FluxDelayStream.fromJson(Map<String, dynamic> json) => new FluxDelayStream(
    pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
    reports: json["reports"] == null ? null : new List<Report>.from(json["reports"].map((x) => Report.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "pagination": pagination == null ? null : pagination.toJson(),
    "reports": reports == null ? null : new List<dynamic>.from(reports.map((x) => x.toJson())),
  };
}