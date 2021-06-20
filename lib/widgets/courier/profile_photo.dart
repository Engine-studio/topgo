import 'package:flutter/widgets.dart';
import 'package:topgo/styles.dart';

class ProfilePhoto extends StatelessWidget {
  const ProfilePhoto({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 74,
      height: 74,
      child: Stack(
        children: [
          Container(
            width: 74,
            height: 74,
            decoration: BoxDecoration(shape: BoxShape.circle),
            clipBehavior: Clip.hardEdge,
            child: Image.asset('assets/images/example.png', fit: BoxFit.fill),
          ),
          Positioned(
            left: 50,
            top: 50,
            child: Container(
              width: 24,
              height: 24,
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFEEEDED),
              ),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ClrStyle.lightBackground,
                ),
                child: ShaderMask(
                  shaderCallback: (bounds) =>
                      GrdStyle.panel.createShader(bounds),
                  child: Image(
                    image: ResizeImage(
                      AssetImage('assets/icons/pen.png'),
                      width: 16,
                      height: 16,
                    ),
                    color: Color(0xFFFFFFFF),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
