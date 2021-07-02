import 'package:flutter/widgets.dart';
import 'package:topgo/models/user.dart';
import 'package:topgo/widgets/report_card.dart';
import 'package:provider/provider.dart';

class CourierDocumentsTab extends StatelessWidget {
  const CourierDocumentsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 16),
            ...context.watch<User>().courier.reports.map(
                  (report) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: ReportCard(report: report),
                  ),
                ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
