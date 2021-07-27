import 'package:flutter/widgets.dart';
import 'package:topgo/styles.dart';
import 'package:topgo/widgets/border_box.dart';
import 'package:topgo/widgets/dropdown.dart';
import 'package:topgo/widgets/flag.dart';
import 'package:topgo/widgets/map/map.dart';
import 'package:topgo/widgets/map/map_marker.dart';

class MapCard extends StatefulWidget {
  final String text;
  final bool expanded;
  final List<MapMarker> markers;
  const MapCard({
    Key? key,
    this.text = 'Карта',
    required this.markers,
    this.expanded = true,
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
              text: widget.text,
              gradient: GrdStyle.select,
            ),
            icon: Image.asset(
              'assets/icons/arrow.png',
              width: 14,
            ),
            toShow: Map(
              markers: _markers,
              onTap: (marker) => {
                if (widget.expanded)
                  if (marker.build != null)
                    setState(
                      () {
                        card = marker.build!();
                      },
                    ),
              },
            ),
            onClosed: () => {
              if (widget.expanded)
                setState(
                  () {
                    card = null;
                    for (MapMarker marker in _markers) marker.picked = false;
                  },
                ),
            },
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
