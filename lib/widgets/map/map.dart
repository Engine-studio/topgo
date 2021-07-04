import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:topgo/widgets/map/map_marker.dart';

class Map extends StatefulWidget {
  final List<MapMarker> markers;
  final void Function(MapMarker) onTap;
  const Map({Key? key, this.markers = const [], required this.onTap})
      : super(key: key);

  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  late MapController _controller;
  final Location _location = Location();

  late List<MapMarker> _markers;

  LatLng? _locationData;

  PermissionStatus? _permissionGranted;

  Future<void> _checkPermissions() async {
    final PermissionStatus permissionGrantedResult =
        await _location.hasPermission();
    setState(() {
      _permissionGranted = permissionGrantedResult;
    });
  }

  Future<void> _requestPermission() async {
    if (_permissionGranted != PermissionStatus.granted) {
      final PermissionStatus permissionRequestedResult =
          await _location.requestPermission();
      setState(() {
        _permissionGranted = permissionRequestedResult;
      });
    }
  }

  Future<void> _getCurrentLocation() async {
    if (_permissionGranted == PermissionStatus.granted) {
      final LocationData locationData = await _location.getLocation();
      setState(() {
        _locationData = LatLng(locationData.latitude!, locationData.longitude!);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = MapController();
    this._markers = widget.markers;
    _checkPermissions();
    if (_permissionGranted != PermissionStatus.granted) _requestPermission();
  }

  void pick(MapMarker mapMarker) {
    setState(() {
      for (MapMarker marker in _markers) {
        marker.picked = marker == mapMarker;
      }
    });
  }

  void move(LatLng location) {
    _controller.move(location, _controller.zoom);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    _getCurrentLocation();
    return AspectRatio(
      aspectRatio: 7 / 6,
      child: FlutterMap(
        mapController: _controller,
        options: MapOptions(
          center: _locationData ?? MapMarker.moscow,
          zoom: 11.5,
        ),
        layers: [
          TileLayerOptions(
              urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
              subdomains: ['a', 'b', 'c']),
          MarkerLayerOptions(
              markers: _markers
                  .map(
                    (marker) => Marker(
                      width: 25,
                      height: 25,
                      point: marker.location,
                      builder: (context) => GestureDetector(
                        onTap: () => marker.picked
                            ? {}
                            : {
                                pick(marker),
                                move(marker.location),
                                widget.onTap(marker),
                              },
                        child: marker.picked
                            ? marker.pickedWidget
                            : marker.waitingWidget,
                      ),
                    ),
                  )
                  .toList()),
        ],
      ),
    );
  }
}
