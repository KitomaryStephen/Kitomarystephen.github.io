import 'package:json_annotation/json_annotation.dart';

import '_parsers.dart';

part 'signal.g.dart';

@JsonSerializable(explicitToJson: true)
class Signal {
  @JsonKey(defaultValue: '')
  String id;
  @JsonKey(defaultValue: 0)
  num entry;
  @JsonKey(defaultValue: 0)
  num stopLoss;
  @JsonKey(defaultValue: 0)
  num takeProfit1;
  @JsonKey(defaultValue: 0)
  num takeProfit2;
  @JsonKey(defaultValue: '')
  String symbol;
  @JsonKey(defaultValue: '')
  String comment;
  @JsonKey(defaultValue: '')
  String type;
  @JsonKey(defaultValue: true)
  bool isActive;
  @JsonKey(defaultValue: false)
  bool isFree;
  @JsonKey(fromJson: parseToDateTime, toJson: parseToDateTime)
  DateTime? timestampCreated;
  @JsonKey(fromJson: parseToDateTime, toJson: parseToDateTime)
  DateTime? timestampUpdated;
  @JsonKey(fromJson: parseToDateTime, toJson: parseToDateTime)
  DateTime? signalDatetime;

  Signal()
      : id = '',
        entry = 0,
        stopLoss = 0,
        takeProfit1 = 0,
        takeProfit2 = 0,
        symbol = '',
        comment = '',
        type = '',
        isActive = true,
        isFree = false,
        timestampCreated = null,
        timestampUpdated = null,
        signalDatetime = null;

  factory Signal.fromJson(Map<String, dynamic> json) => _$SignalFromJson(json);
  Map<String, dynamic> toJson() => _$SignalToJson(this)..remove('id');

  // functions
  get getEntryText {
    if (type == 'Bull') return 'Buy \nEntry';
    return 'Sell \nEntry';
  }

  get getIconPath {
    if (type == 'Bull') return 'assets/images/icon_signal_bull.png';
    return 'assets/images/icon_signal_bear.png';
  }

  get getIconArrow {
    if (type == 'Bull') return 'assets/images/icon_signal_bull_arrow.png';
    return 'assets/images/icon_signal_bear_arrow.png';
  }
}
