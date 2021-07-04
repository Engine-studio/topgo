import 'package:flutter/widgets.dart';
import 'package:topgo/styles.dart';
import 'package:topgo/widgets/border_box.dart';
import 'package:topgo/widgets/dropdown.dart';
import 'package:topgo/widgets/flag.dart';
import 'package:topgo/widgets/map/map.dart';
import 'package:topgo/widgets/map/map_marker.dart';

class MapCard extends StatefulWidget {
  final List<MapMarker> markers;
  const MapCard({
    Key? key,
    required this.markers,
  }) : super(key: key);

  @override
  _MapCardState createState() => _MapCardState();
}

class _MapCardState extends State<MapCard> {
  Widget? card;
  late List<MapMarker> _markers;

  @override
  void initState() {
    super.initState();
    this._markers = widget.markers;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BorderBox(
          gradient: GrdStyle.select,
          child: DropDown(
            child: Flag(
              text: 'Карта',
              gradient: GrdStyle.select,
            ),
            icon: Image.asset(
              'assets/icons/arrow.png',
              width: 14,
            ),
            toShow: Map(
              markers: _markers,
              onTap: (marker) => {
                if (marker.build != null)
                  setState(() {
                    card = marker.build!();
                  })
              },
            ),
            onClosed: () => setState(() {
              card = null;
              for (MapMarker marker in _markers) marker.picked = false;
            }),
          ),
        ),
        card != null
            ? Padding(
                padding: const EdgeInsets.only(top: 16),
                child: card,
              )
            : SizedBox(),
      ],
    );
  }
}
