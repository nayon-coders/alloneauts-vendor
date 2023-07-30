// To parse this JSON data, do
//
//     final cameraViolationModel = cameraViolationModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<CameraViolationModel> cameraViolationModelFromJson(String str) => List<CameraViolationModel>.from(json.decode(str).map((x) => CameraViolationModel.fromJson(x)));

String cameraViolationModelToJson(List<CameraViolationModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CameraViolationModel {
  final Plate plate;
  final States state;
  final LicenseType licenseType;
  final String summonsNumber;
  final String issueDate;
  final String violationTime;
  final String violation;
  final String fineAmount;
  final String penaltyAmount;
  final String interestAmount;
  final String reductionAmount;
  final String paymentAmount;
  final String amountDue;
  final String precinct;
  final String county;
  final IssuingAgency issuingAgency;
  final SummonsImage summonsImage;
  final String judgmentEntryDate;
  final String violationStatus;

  CameraViolationModel({
    required this.plate,
    required this.state,
    required this.licenseType,
    required this.summonsNumber,
    required this.issueDate,
    required this.violationTime,
    required this.violation,
    required this.fineAmount,
    required this.penaltyAmount,
    required this.interestAmount,
    required this.reductionAmount,
    required this.paymentAmount,
    required this.amountDue,
    required this.precinct,
    required this.county,
    required this.issuingAgency,
    required this.summonsImage,
    required this.judgmentEntryDate,
    required this.violationStatus,
  });

  factory CameraViolationModel.fromJson(Map<String, dynamic> json) => CameraViolationModel(
    plate: plateValues.map[json["plate"]]!,
    state: stateValues.map[json["state"]]!,
    licenseType: licenseTypeValues.map[json["license_type"]]!,
    summonsNumber: json["summons_number"],
    issueDate: json["issue_date"],
    violationTime: json["violation_time"],
    violation: json["violation"],
    fineAmount: json["fine_amount"],
    penaltyAmount: json["penalty_amount"],
    interestAmount: json["interest_amount"],
    reductionAmount: json["reduction_amount"],
    paymentAmount: json["payment_amount"],
    amountDue: json["amount_due"],
    precinct: json["precinct"],
    county: json["county"],
    issuingAgency: issuingAgencyValues.map[json["issuing_agency"]]!,
    summonsImage: SummonsImage.fromJson(json["summons_image"]),
    judgmentEntryDate: json["judgment_entry_date"],
    violationStatus: json["violation_status"],
  );

  Map<String, dynamic> toJson() => {
    "plate": plateValues.reverse[plate],
    "state": stateValues.reverse[state],
    "license_type": licenseTypeValues.reverse[licenseType],
    "summons_number": summonsNumber,
    "issue_date": issueDate,
    "violation_time": violationTime,
    "violation": violation,
    "fine_amount": fineAmount,
    "penalty_amount": penaltyAmount,
    "interest_amount": interestAmount,
    "reduction_amount": reductionAmount,
    "payment_amount": paymentAmount,
    "amount_due": amountDue,
    "precinct": precinct,
    "county": county,
    "issuing_agency": issuingAgencyValues.reverse[issuingAgency],
    "summons_image": summonsImage.toJson(),
    "judgment_entry_date": judgmentEntryDate,
    "violation_status": violationStatus,
  };
}

enum IssuingAgency { DEPARTMENT_OF_TRANSPORTATION, TRAFFIC, POLICE_DEPARTMENT, DEPARTMENT_OF_SANITATION }

final issuingAgencyValues = EnumValues({
  "DEPARTMENT OF SANITATION": IssuingAgency.DEPARTMENT_OF_SANITATION,
  "DEPARTMENT OF TRANSPORTATION": IssuingAgency.DEPARTMENT_OF_TRANSPORTATION,
  "POLICE DEPARTMENT": IssuingAgency.POLICE_DEPARTMENT,
  "TRAFFIC": IssuingAgency.TRAFFIC
});

enum LicenseType { OMT, PAS }

final licenseTypeValues = EnumValues({
  "OMT": LicenseType.OMT,
  "PAS": LicenseType.PAS
});

enum Plate { T684813_C }

final plateValues = EnumValues({
  "T684813C": Plate.T684813_C
});

enum States { NY }

final stateValues = EnumValues({
  "NY": States.NY
});

class SummonsImage {
  final String url;
  final Description description;

  SummonsImage({
    required this.url,
    required this.description,
  });

  factory SummonsImage.fromJson(Map<String, dynamic> json) => SummonsImage(
    url: json["url"],
    description: descriptionValues.map[json["description"]]!,
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "description": descriptionValues.reverse[description],
  };
}

enum Description { VIEW_SUMMONS }

final descriptionValues = EnumValues({
  "View Summons": Description.VIEW_SUMMONS
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
