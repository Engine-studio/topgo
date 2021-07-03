import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:topgo/api/general.dart';
import 'package:topgo/models/report.dart';
import 'package:topgo/widgets/error.dart';
import 'package:topgo/widgets/loading.dart';
import 'package:topgo/widgets/report_card.dart';

class DocumentsTab extends StatelessWidget {
  const DocumentsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<List<Report>> reports = getReports(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            FutureBuilder<List<Report>>(
              future: reports,
              builder: (context, snapshot) {
                if (snapshot.hasError)
                  return Error(text: snapshot.error!.toString());
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  return Wrap(
                    direction: Axis.vertical,
                    runSpacing: 8,
                    children: snapshot.data!
                        .map((report) => ReportCard(report: report))
                        .toList(),
                  );
                } else
                  return Loading();
              },
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
