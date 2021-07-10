import 'dart:convert' show jsonEncode;

import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:topgo/functions/naive_time.dart';

class OrderRequest {
  int courierId;
  LocationData locationData;

  OrderRequest.create({
    required this.courierId,
    required this.locationData,
  });

  String get json => jsonEncode({
        'courier_id': courierId,
        'lat': locationData.latitude,
        'lng': locationData.longitude,
      });
}

class Order {
  int? id, restaurantId, sessionId, total;
  String? fromAddress, toAddress;
  LatLng? fromLatLng, toLatLng;
  double? appearance, behavior, sum;
  List<int>? start, stop;
  bool? withCash;

  Order.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        restaurantId = json['restaurant_id'],
        sessionId = json['session_id'],
        total = json['coocking_time'],
        //fromAddress = json['']
        toAddress = json['delivery_address'],
        //fromLatLng = json['']
        toLatLng = LatLng(json['address_lat'], json['address_lng']),
        withCash = json['method'] == 'Cash',
        //appearance, behavior
        start = parseNaiveDateTime(json['take_datetime']),
        stop = parseNaiveDateTime(json['delivery_datetime']),
        sum = json['courier_share'] / 100;

  String get jsonID => jsonEncode({"id": id});
}
