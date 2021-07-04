import 'package:flutter/widgets.dart';

class DropDown extends StatefulWidget {
  final Widget child;
  final Widget toShow;
  final Widget icon;
  final bool initiallyShown;
  final Duration duration;
  final double topPadding;

  final void Function()? onClosed;

  const DropDown({
    Key? key,
    required this.toShow,
    required this.icon,
    required this.child,
    this.onClosed,
    this.topPadding = 19,
    this.initiallyShown = false,
    this.duration = const Duration(milliseconds: 350),
  }) : super(key: key);

  @override
  _DropDownState createState() => _DropDownState();
}

class _DropDownState extends State<DropDown>
    with SingleTickerProviderStateMixin {
  static final Animatable<double> show = CurveTween(curve: Curves.easeIn);
  static final Animatable<double> rotate = Tween<double>(begin: 0.0, end: 0.5);

  late AnimationController _controller;
  late Animation<double> _iconTurns;
  late Animation<double> _heightFactor;
  late bool _isExpanded;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this);
    _heightFactor = _controller.drive(show);
    _iconTurns = _controller.drive(rotate.chain(show));
    _isExpanded = widget.initiallyShown;
    if (_isExpanded) _controller.value = 1.0;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildChildren(BuildContext context, Widget? child) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(top: widget.topPadding),
          child: ClipRect(
            child: Align(
              heightFactor: _heightFactor.value,
              child: child,
            ),
          ),
        ),
        GestureDetector(
          onTap: () => {
            setState(() {
              _isExpanded = !_isExpanded;
              _isExpanded
                  ? _controller.forward()
                  : _controller
                      .reverse()
                      .whenCompleteOrCancel(widget.onClosed ?? () {});
            })
          },
          child: Stack(
            alignment: Alignment.centerRight,
            children: [
              widget.child,
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: RotationTransition(
                  turns: _iconTurns,
                  child: widget.icon,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller.view,
      builder: _buildChildren,
      child: !_isExpanded && _controller.isDismissed ? null : widget.toShow,
    );
  }
}
