import 'package:flutter/widgets.dart';
import 'package:topgo/models/user.dart';
import 'package:topgo/widgets/report_card.dart';
import 'package:provider/provider.dart';

class DocumentsTab extends StatelessWidget {
  const DocumentsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 16),
            ...context.read<User>().reports.map(
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
