import 'package:flutter/widgets.dart';
import 'package:topgo/models/report.dart';
import 'package:topgo/styles.dart';
import 'package:topgo/widgets/border_box.dart';

class ReportCard extends StatelessWidget {
  final Report report;
  const ReportCard({Key? key, required this.report}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BorderBox(
      height: 44,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Row(
          children: [
            SizedBox(
              width: 69,
              child: Text(this.report.date, style: TxtStyle.selectedMainText),
            ),
            Text(this.report.shift, style: TxtStyle.mainText),
            Spacer(),
            GestureDetector(
              onTap: () => {},
              child: Image.asset(
                'assets/icons/download.png',
                width: 24,
                height: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
