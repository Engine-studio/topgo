import 'package:flutter/widgets.dart';
import 'package:topgo/styles.dart';

class StarHolder extends StatelessWidget {
  final double rating;
  const StarHolder({Key? key, required this.rating}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('$rating', style: TxtStyle.smallText),
        ShaderMask(
          shaderCallback: (bounds) => GrdStyle.select.createShader(bounds),
          child: Image.asset(
            'assets/icons/star.png',
            width: 15,
            height: 15,
            color: Color(0xFFFFFFFF),
          ),
        )
      ],
    );
  }
}
