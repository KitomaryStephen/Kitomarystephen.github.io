// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Signal _$SignalFromJson(Map<String, dynamic> json) => Signal()
  ..id = json['id'] as String? ?? ''
  ..entry = json['entry'] as num? ?? 0
  ..stopLoss = json['stopLoss'] as num? ?? 0
  ..takeProfit1 = json['takeProfit1'] as num? ?? 0
  ..takeProfit2 = json['takeProfit2'] as num? ?? 0
  ..symbol = json['symbol'] as String? ?? ''
  ..comment = json['comment'] as String? ?? ''
  ..type = json['type'] as String? ?? ''
  ..isActive = json['isActive'] as bool? ?? true
  ..isFree = json['isFree'] as bool? ?? false
  ..timestampCreated = parseToDateTime(json['timestampCreated'])
  ..timestampUpdated = parseToDateTime(json['timestampUpdated'])
  ..signalDatetime = parseToDateTime(json['signalDatetime']);

Map<String, dynamic> _$SignalToJson(Signal instance) => <String, dynamic>{
      'id': instance.id,
      'entry': instance.entry,
      'stopLoss': instance.stopLoss,
      'takeProfit1': instance.takeProfit1,
      'takeProfit2': instance.takeProfit2,
      'symbol': instance.symbol,
      'comment': instance.comment,
      'type': instance.type,
      'isActive': instance.isActive,
      'isFree': instance.isFree,
      'timestampCreated': parseToDateTime(instance.timestampCreated),
      'timestampUpdated': parseToDateTime(instance.timestampUpdated),
      'signalDatetime': parseToDateTime(instance.signalDatetime),
    };
