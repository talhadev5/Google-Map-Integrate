import 'package:circular_seek_bar/circular_seek_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tophotels/modules/resources/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FilterOptions extends StatefulWidget {
  final ValueNotifier<double> valueNotifier;
  final ValueNotifier<double> distanceNotifier;
  const FilterOptions(
      {super.key, required this.valueNotifier, required this.distanceNotifier});

  @override
  State<FilterOptions> createState() => _FilterOptionsState();
}

class _FilterOptionsState extends State<FilterOptions> {
  int? activeIndex; // To track the active ExpansionTile
  late ValueNotifier<double> _localValueNotifier;
  late ValueNotifier<double> _silderValueNotifier;

  @override
  void initState() {
    super.initState();
    _localValueNotifier = ValueNotifier(widget.valueNotifier.value);
    _silderValueNotifier = ValueNotifier(widget.distanceNotifier.value);
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
    _localValueNotifier.dispose();
    _silderValueNotifier.dispose();
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
                  style: ButtonStyle(
                      backgroundColor:
                          WidgetStatePropertyAll(Colors.grey[200])),
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),

            _buildFilterTile(
              index: 0,
              icon: SvgPicture.asset('assets/svg/heat.svg'),
              title: "Heat Score",
              content: Stack(
                alignment: Alignment.topCenter,
                children: [
                  // CircularSeekBar with progress (Start angle 90, sweep angle 180)
                  Positioned(
                    top: 22,
                    child: SvgPicture.asset(
                      'assets/svg/Path.svg',
                      width: 80,
                      height: 80,
                      // ignore: deprecated_member_use
                      color: AppColors.grey,
                    ),
                  ),
                  Container(
                    height: 117,
                    // margin: EdgeInsets.symmetric(vertical: 5),
                    color: Colors.transparent,
                    child: ListView(
                      padding: const EdgeInsets.all(4),
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        CircularSeekBar(
                          width: 200,
                          height: 200,
                          trackColor: AppColors.grey.withOpacity(0.3),
                          progress: _localValueNotifier.value,
                          barWidth: 14,
                          startAngle: 90,
                          sweepAngle: 180,
                          strokeCap: StrokeCap.butt,
                          progressGradientColors: const [
                            Color(0xFFFF7C6F),
                            Color(0xFFEBA857),
                            Color(0xFF5799D6),
                            Color(0xFF5799D6),
                            Color(0xFF5ACBD2),
                          ],
                          innerThumbRadius: 5,
                          innerThumbStrokeWidth: 3,
                          innerThumbColor: Colors.white,
                          outerThumbRadius: 7,
                          outerThumbStrokeWidth: 10,
                          outerThumbColor: AppColors.primaryBlue,
                          dashWidth: 1.3,
                          dashGap: 2,
                          animation: false,
                          curves: Curves.linear,
                          valueNotifier: _localValueNotifier,
                          child: Center(
                            child: ValueListenableBuilder(
                              valueListenable: _localValueNotifier,
                              builder: (_, double value, __) => Column(
                                children: [
                                  const SizedBox(
                                    height: 35,
                                  ),
                                  Text(
                                    _getHeatLevel(value),
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold),
                                  ),
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
                      ],
                    ),
                  ),
                  // Custom painter to draw the line
                  // Positioned(
                  //   top: 20,
                  //   child: SvgPicture.asset(
                  //     'assets/svg/Path.svg',
                  //     width: 80,
                  //     height: 80,
                  //     // ignore: deprecated_member_use
                  //     color: AppColors.grey,
                  //   ),
                  // )
                ],
              ),
            ),

            _buildFilterTile(
              index: 1,
              icon: SvgPicture.asset('assets/svg/popular.svg'),
              title: "Popular",
              content: Text(
                "Popular filter options go here.",
                style: TextStyle(color: Colors.grey[400]),
              ),
            ),
            _buildFilterTile(
              index: 2,
              icon: SvgPicture.asset('assets/svg/distance.svg'),
              title: "Distance",
              content: Center(
                child: ValueListenableBuilder(
                  valueListenable: _silderValueNotifier,
                  builder: (_, double value, __) {
                    // Ensure value is clamped between min and max
                    double clampedValue = value.clamp(100.0, 2000.0);

                    return Column(
                      children: [
                        Slider(
                          activeColor: AppColors.primaryBlue,
                          thumbColor: AppColors.primaryBlue,
                          max: 2000.0,
                          min: 100.0,
                          value: clampedValue, // Use the clamped value
                          onChanged: (double newValue) {
                            setState(() {
                              _silderValueNotifier.value =
                                  newValue; // Update the ValueNotifier
                            });
                          },
                        ),
                        Text(
                          "Distance: ${clampedValue.toStringAsFixed(1)} m",
                          style: TextStyle(color: Colors.grey[400]),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),

            _buildFilterTile(
              index: 3,
              icon: SvgPicture.asset('assets/svg/rating.svg'),
              title: "Rating",
              content: Text(
                "Rating filter options go here.",
                style: TextStyle(color: Colors.grey[400]),
              ),
            ),
            _buildFilterTile(
              index: 4,
              icon: SvgPicture.asset('assets/svg/verify.svg'),
              title: "Verified",
              content: Text(
                "Verified filter options go here.",
                style: TextStyle(color: Colors.grey[400]),
              ),
            ),

            const SizedBox(height: 16),

            // Apply Changes Button
            ElevatedButton(
              onPressed: () {
                // Handle Apply Changes
                widget.valueNotifier.value = _localValueNotifier.value;
                widget.distanceNotifier.value = _silderValueNotifier.value;
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
          trailing: Icon(
            Icons.keyboard_arrow_down_outlined,
            color: Colors.grey[400],
          ),
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
            // Add space at the bottom
          ],
        ),
      ),
    );
  }
}
