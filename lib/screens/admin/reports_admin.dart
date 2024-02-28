import 'package:agenda_pastora_app/repositories/report_repository.dart';
import 'package:agenda_pastora_app/utils/colors.dart';
import 'package:agenda_pastora_app/widgets/header_pages.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ReportsAdminPage extends StatefulWidget {
  const ReportsAdminPage({super.key});

  @override
  State<ReportsAdminPage> createState() => _ReportsAdminPageState();
}

class _ReportsAdminPageState extends State<ReportsAdminPage> {
  final ReportRepository _repository = ReportRepository();
  late TooltipBehavior _tooltip;
  bool loading = true;
  List<ChartData> months = [];
  List<ChartData> categories = [];
  List<ChartData> status = [];

  Future<void> hydrate() async {
    ReportResponse res = await _repository.findData();
    setState(() {
      months = res.months ?? [];
      categories = res.categories ?? [];
      status = res.status ?? [];
      loading = false;
    });
  }

  @override
  void initState() {
    _tooltip = TooltipBehavior(enable: true);
    hydrate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: HeaderPages(
          title: 'Relatórios',
          actions: [],
        ),
        preferredSize: Size(double.infinity, 80),
      ),
      body: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 24),
                child: Column(
                  children: [
                    SfCartesianChart(
                      primaryXAxis: CategoryAxis(),
                      title: ChartTitle(
                          text: 'Agendamentos por mês',
                          textStyle: TextStyle(fontWeight: FontWeight.w600),
                          alignment: ChartAlignment.near),
                      legend: Legend(isVisible: true),
                      tooltipBehavior: TooltipBehavior(enable: true),
                      series: <CartesianSeries<ChartData, String>>[
                        LineSeries<ChartData, String>(
                          dataSource: months,
                          xValueMapper: (ChartData sales, _) => sales.x,
                          yValueMapper: (ChartData sales, _) => sales.y,
                          name: 'Agendamentos',
                          dataLabelSettings: DataLabelSettings(isVisible: true),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    SfCircularChart(
                      title: ChartTitle(
                          text: 'Agendamentos por categoria',
                          textStyle: TextStyle(fontWeight: FontWeight.w600),
                          alignment: ChartAlignment.near),
                      legend: Legend(isVisible: true),
                      series: <CircularSeries>[
                        PieSeries<ChartData, String>(
                          dataSource: categories,
                          pointColorMapper: (ChartData data, _) => data.color,
                          xValueMapper: (ChartData data, _) => data.x,
                          yValueMapper: (ChartData data, _) => data.y,
                          dataLabelMapper: (ChartData data, _) => data.x,
                          dataLabelSettings: DataLabelSettings(isVisible: true),
                        ),
                      ],
                    ),
                    SfCircularChart(
                        tooltipBehavior: _tooltip,
                        title: ChartTitle(
                            text: 'Agendamentos por status',
                            textStyle: TextStyle(fontWeight: FontWeight.w600),
                            alignment: ChartAlignment.near),
                        legend: Legend(isVisible: true),
                        series: <CircularSeries<ChartData, String>>[
                          DoughnutSeries<ChartData, String>(
                              dataSource: status,
                              pointColorMapper: (ChartData data, _) =>
                                  data.color,
                              xValueMapper: (ChartData data, _) => data.x,
                              yValueMapper: (ChartData data, _) => data.y,
                              dataLabelMapper: (ChartData data, _) =>
                                  data.y.toString(),
                              dataLabelSettings:
                                  DataLabelSettings(isVisible: true),
                              name: 'Gold')
                        ]),
                  ],
                ),
              ),
            ),
    );
  }
}
