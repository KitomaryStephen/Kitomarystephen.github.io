import 'package:json_annotation/json_annotation.dart';

import '_parsers.dart';

part 'auth_user.g.dart';

@JsonSerializable(explicitToJson: true)
class AuthUser {
  String? id;
  @JsonKey(defaultValue: '')
  String email;
  @JsonKey(defaultValue: 'Jaime Doe(Change default)')
  String name;
  @JsonKey(defaultValue: '')
  String profileImageUrl;
  @JsonKey(defaultValue: '')
  String referalCode;
  @JsonKey(defaultValue: [])
  List<String> favoritesSignals;
  @JsonKey(defaultValue: true)
  bool isNotificationsEnabled;
  @JsonKey(fromJson: parseToDateTime, toJson: parseToDateTime)
  DateTime? timestampLastLogin;
  @JsonKey(fromJson: parseToDateTime, toJson: parseToDateTime)
  DateTime? timestampCreated;

  // subcription
  @JsonKey(defaultValue: false)
  bool subRevenueCatIsActive;
  @JsonKey(defaultValue: false)
  bool subRevenueCatWillRenew;
  @JsonKey(defaultValue: '')
  String subRevenueCatPeriodType;
  @JsonKey(defaultValue: '')
  String subRevenueCatProductIdentifier;
  @JsonKey(defaultValue: false)
  bool subRevenueCatIsSandbox;
  @JsonKey(fromJson: parseToDateTime, toJson: parseToDateTime)
  DateTime? subRevenueCatOriginalPurchaseDate;
  @JsonKey(fromJson: parseToDateTime, toJson: parseToDateTime)
  DateTime? subRevenueCatLatestPurchaseDate;
  @JsonKey(fromJson: parseToDateTime, toJson: parseToDateTime)
  DateTime? subRevenueCatExpirationDate;
  @JsonKey(fromJson: parseToDateTime, toJson: parseToDateTime)
  DateTime? subRevenueCatUnsubscribeDetectedAt;
  @JsonKey(fromJson: parseToDateTime, toJson: parseToDateTime)
  DateTime? subRevenueCatBillingIssueDetectedAt;
  @JsonKey(defaultValue: false)
  bool subIsLifetime;

  AuthUser()
      : isNotificationsEnabled = true,
        email = '',
        profileImageUrl = '',
        favoritesSignals = [],
        referalCode = '',
        subRevenueCatIsActive = false,
        subRevenueCatWillRenew = false,
        subRevenueCatIsSandbox = false,
        name = '',
        subRevenueCatPeriodType = '',
        subRevenueCatProductIdentifier = '',
        subIsLifetime = false;

  factory AuthUser.fromJson(Map<String, dynamic> json) => _$AuthUserFromJson(json);
  Map<String, dynamic> toJson() => _$AuthUserToJson(this)
    ..remove('id')
    ..remove('timestampLastLogin')
    ..remove('timestampCreated');

  // functions
  bool get hasActiveSubscription => subRevenueCatIsActive || subIsLifetime;
  bool get hasLifetime => subIsLifetime;
}
