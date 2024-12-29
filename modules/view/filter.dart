import 'package:circular_seek_bar/circular_seek_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tophotels/modules/resources/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FilterOptions extends StatefulWidget {
  const FilterOptions({super.key});

  @override
  State<FilterOptions> createState() => _FilterOptionsState();
}

class _FilterOptionsState extends State<FilterOptions> {
  double heatScore = 50; // Default Heat Score
  int? activeIndex; // To track the active ExpansionTile
  late ValueNotifier<double> _valueNotifier = ValueNotifier(0);

  double _progress = 80;
  @override
  void initState() {
    super.initState();
    _valueNotifier = ValueNotifier(_progress);
  }

  String _getHeatLevel(double value) {
    if (value <= 20) {
      return "Low";
    } else if (value > 20 && value <= 70) {
      return "Medium";
    } else {
      return "High";
    }
  }


  @override
  void dispose() {
    _valueNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Filtering and Sorting",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  style: const ButtonStyle(
                      backgroundColor:
                          WidgetStatePropertyAll(Color(0xFFEEF1F5))),
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),

            // Filters
            _buildFilterTile(
              index: 0,
              icon: SvgPicture.asset('assets/svg/heat.svg'),
              title: "Heat Score",
              content: CircularSeekBar(
                width: double.infinity,
                height: 200,
                progress: _progress,
                barWidth: 8,
                startAngle: 45,
                sweepAngle: 270,
                strokeCap: StrokeCap.butt,
                progressGradientColors: const [
                  Colors.red,
                  Colors.orange,
                  Colors.yellow,
                  Colors.green,
                  Colors.blue,
                  Colors.indigo,
                  Colors.purple,
                ],
                innerThumbRadius: 5,
                innerThumbStrokeWidth: 3,
                innerThumbColor: Colors.white,
                outerThumbRadius: 5,
                outerThumbStrokeWidth: 10,
                outerThumbColor: AppColors.primaryBlue,
                dashWidth: 1,
                dashGap: 2,
                animation: true,
                curves: Curves.bounceOut,
                valueNotifier: _valueNotifier,
                child: Center(
                  child: ValueListenableBuilder(
                    valueListenable: _valueNotifier,
                    builder: (_, double value, __) => Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('${_getHeatLevel(value)}',
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 24,
                                fontWeight: FontWeight.bold)),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Heat Score',
                                style: TextStyle(color: Colors.grey)),
                            SizedBox(width: 10),
                            Icon(
                              Icons.info_outline_rounded,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            _buildFilterTile(
              index: 1,
              icon: SvgPicture.asset('assets/svg/popular.svg'),
              title: "Popular",
              content: const Text("Popular filter options go here."),
            ),
            _buildFilterTile(
              index: 2,
              icon: SvgPicture.asset('assets/svg/distance.svg'),
              title: "Distance",
              content: const Text("Distance filter options go here."),
            ),
            _buildFilterTile(
              index: 3,
              icon: SvgPicture.asset('assets/svg/rating.svg'),
              title: "Rating",
              content: const Text("Rating filter options go here."),
            ),
            _buildFilterTile(
              index: 4,
              icon: SvgPicture.asset('assets/svg/verify.svg'),
              title: "Verified",
              content: const Text("Verified filter options go here."),
            ),

            const SizedBox(height: 16),

            // Apply Changes Button
            ElevatedButton(
              onPressed: () {
                // Handle Apply Changes
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
                backgroundColor: AppColors.primaryBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                "Apply Changes",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterTile({
    required int index,
    required Widget icon,
    required String title,
    required Widget content,
  }) {
    return Container(
      // margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border(
            bottom: BorderSide(
          color: Colors.grey[300]!,
        )),
        borderRadius: BorderRadius.circular(0),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
        ),
        child: ExpansionTile(
          leading: icon,
          title: Text(title),
          onExpansionChanged: (expanded) {
            setState(() {
              activeIndex = expanded ? index : null;
            });
          },
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: content,
            ),
            const SizedBox(height: 8), // Add space at the bottom
          ],
        ),
      ),
    );
  }
}
