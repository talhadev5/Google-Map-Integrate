// import 'package:flutter/material.dart';
// import 'dart:math';

// class HeatScoreIndicator extends StatefulWidget {
//   @override
//   _HeatScoreIndicatorState createState() => _HeatScoreIndicatorState();
// }

// class _HeatScoreIndicatorState extends State<HeatScoreIndicator> {
//   double score = 75; // Initial score (out of 100)

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: GestureDetector(
//         onPanUpdate: (details) {
//           setState(() {
//             // Update score based on the thumb's movement
//             double delta =
//                 details.localPosition.dx - 150; // Adjust center offset
//             double newScore =
//                 (atan2(-delta, 150) / pi + 1) * 50; // Map angle to score
//             score = newScore.clamp(0, 100); // Ensure score stays within bounds
//           });
//         },
//         child: Stack(
//           alignment: Alignment.center,
//           children: [
//             // Arc and Gradient
//             CustomPaint(
//               size: Size(300, 150), // Width and height of the arc
//               painter: HeatScorePainter(score),
//             ),
//             // Text Labels
//             Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text(
//                   _getScoreLevel(score),
//                   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                 ),
//                 SizedBox(height: 8),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       'Heat Score',
//                       style: TextStyle(fontSize: 16, color: Colors.grey),
//                     ),
//                     SizedBox(width: 4),
//                     Icon(Icons.info, size: 16, color: Colors.grey),
//                   ],
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   String _getScoreLevel(double score) {
//     if (score < 33) return "Low";
//     if (score < 66) return "Medium";
//     return "High";
//   }
// }

// class HeatScorePainter extends CustomPainter {
//   final double score;

//   HeatScorePainter(this.score);

//   @override
//   void paint(Canvas canvas, Size size) {
//     final center = Offset(size.width / 2, size.height);
//     final radius = size.width / 2;

//     // Gradient Arc
//     final Paint arcPaint = Paint()
//       ..shader = SweepGradient(
//         colors: [
//           Colors.blue,
//           Colors.cyan,
//           Colors.green,
//           Colors.yellow,
//           Colors.orange,
//           Colors.red,
//         ],
//         startAngle: pi,
//         endAngle: 2 * pi,
//       ).createShader(Rect.fromCircle(center: center, radius: radius))
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 10
//       ..strokeCap = StrokeCap.round;

//     canvas.drawArc(
//       Rect.fromCircle(center: center, radius: radius),
//       pi,
//       pi,
//       false,
//       arcPaint,
//     );

//     // Thumb Position
//     final angle = pi + (score / 100) * pi;
//     final thumbRadius = 12.0;
//     final thumbCenter = Offset(
//       center.dx + (radius - 10) * cos(angle),
//       center.dy + (radius - 10) * sin(angle),
//     );

//     final Paint thumbPaint = Paint()..color = Colors.white;
//     final Paint thumbOutline = Paint()
//       ..color = Colors.blueAccent
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 3;

//     // Draw Thumb
//     canvas.drawCircle(thumbCenter, thumbRadius, thumbPaint);
//     canvas.drawCircle(thumbCenter, thumbRadius, thumbOutline);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
// }
