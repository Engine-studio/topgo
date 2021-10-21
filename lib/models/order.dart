import 'dart:convert' show jsonEncode;

import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:topgo/functions/naive_time.dart';
import 'package:topgo/models/simple_courier.dart';

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
  String? fromAddress, toAddress, comment;
  LatLng? fromLatLng, toLatLng;
  double? appearance, behavior, sum;
  List<int>? start, stop;
  String? withCash;
  OrderStatus? status;

  Order.fromJson(Map<String, dynamic> json)
      : id = json['order_id'] ?? json['id'],
        restaurantId = json['restaurant_id'],
        sessionId = json['session_id'],
        fromAddress = json['restaurant_address'],
        toAddress = json['destination_address'] ?? json['delivery_address'],
        fromLatLng =
            json['restaurant_lat'] != null && json['restaurant_lng'] != null
                ? LatLng(json['restaurant_lat']!, json['restaurant_lng']!)
                : null,
        toLatLng =
            json['destination_lat'] != null && json['destination_lng'] != null
                ? LatLng(json['destination_lat']!, json['destination_lng']!)
                : null,
        withCash = json['method'] ?? json['payment_method'],
        appearance = (json['look_rate'] ?? 0) * 1.0,
        behavior = (json['politeness_rate'] ?? 0) * 1.0,
        start = parseNaiveDateTime(json['take_datetime']),
        stop = parseNaiveDateTime(json['delivery_datetime']),
        comment = json['client_comment'],
        sum =
            ((json['pay_amount'] ?? json['order_price']) * 1.0 ?? 0.0) / 100.0,
        status = (json['status'] != null)
            ? OrderStatus.values.firstWhere(
                (e) => e.toString() == 'OrderStatus.' + json['status'])
            : (json['order_status'] != null)
                ? OrderStatus.values.firstWhere((e) =>
                    e.toString() == 'OrderStatus.' + json['order_status'])
                : null {
    List<int> tmp = parseNaiveTime(json['cooking_time']) ?? [0, 0];
    this.total = tmp[0] * 60 + tmp[1];
  }

  Order.create()
      : id = 123,
        restaurantId = 124124,
        sessionId = 1,
        total = 15,
        fromAddress = 'from ' * 10,
        toAddress = 'to ' * 12,
        fromLatLng = LatLng(55.756063, 37.627903),
        toLatLng = LatLng(55.786063, 37.647903),
        withCash = 'Cash',
        //appearance, behavior
        start = [15, 0],
        stop = [16, 0],
        sum = 14124;

  String get jsonID => jsonEncode({"id": id});
}
