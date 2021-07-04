import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:topgo/models/restaurant.dart';
import 'package:topgo/models/simple_courier.dart';
import 'package:topgo/styles.dart';
import 'package:topgo/widgets/curator/courier_card.dart';
import 'package:topgo/widgets/curator/restaurant_card.dart';

class MapMarker {
  late double x, y;
  bool picked;

  SimpleCourier? courier;
  Restaurant? restaurant;

  Widget Function()? build;

  MapMarker({required this.x, required this.y}) : picked = false;

  MapMarker.courier({required this.courier}) : picked = false {
    this.x = courier!.x ?? 0;
    this.y = courier!.y ?? 0;
    this.build = () => CourierCard(courier: courier!, forMap: true);
  }

  MapMarker.restaurant({required this.restaurant}) : picked = false {
    this.x = restaurant!.x ?? 0;
    this.y = restaurant!.y ?? 0;
    this.build = () => RestaurantCard(restaurant: restaurant!, forMap: true);
  }

  MapMarker.restaurantNoCard({required this.restaurant}) : picked = false {
    this.x = restaurant!.x ?? 0;
    this.y = restaurant!.y ?? 0;
  }

  LatLng get location => LatLng(x, y);
  static LatLng get moscow => LatLng(55.75222, 37.61556);
  Widget get waitingWidget => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: Color(0xFFFFFFFF),
        ),
        child: Center(
          child: Image(
            image: AssetImage(
              restaurant != null
                  ? 'assets/icons/store.png'
                  : 'assets/icons/user.png',
            ),
            width: 18,
            height: 18,
            color: ClrStyle.icons,
          ),
        ),
      );
  Widget get pickedWidget => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: Color(0xFFFFFFFF),
          gradient: GrdStyle.select,
        ),
        child: Center(
          child: Image(
            image: AssetImage(
              restaurant != null
                  ? 'assets/icons/store.png'
                  : 'assets/icons/user.png',
            ),
            width: 18,
            height: 19,
            color: ClrStyle.lightBackground,
          ),
        ),
      );
}
