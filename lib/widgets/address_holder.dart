import 'package:flutter/widgets.dart';
import 'package:topgo/styles.dart';

class AddressHolder extends StatelessWidget {
  final String dist, address;
  const AddressHolder({
    Key? key,
    required this.dist,
    required this.address,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 65,
          height: 45,
          alignment: Alignment.topLeft,
          child: Text(dist, style: TxtStyle.smallText),
        ),
        Expanded(
          child: Container(
            height: 45,
            child: SingleChildScrollView(
                child: Text(
              address,
              style: TxtStyle.smallText,
            )),
          ),
        ),
      ],
    );
  }
}
