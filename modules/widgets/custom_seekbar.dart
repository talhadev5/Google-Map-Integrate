// import 'dart:math';

// import 'package:flutter/material.dart';

// class HeatGauge extends StatefulWidget {
//   final double value;

//   const HeatGauge({Key? key, required this.value}) : super(key: key);

//   @override
//   _HeatGaugeState createState() => _HeatGaugeState();
// }

// class _HeatGaugeState extends State<HeatGauge> {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: CustomPaint(
//         size: Size.fromRadius(100), // Adjust size as needed
//         painter: _HeatGaugePainter(value: widget.value),
//       ),
//     );
//   }
// }

// class _HeatGaugePainter extends CustomPainter {
//   final double value;

//   _HeatGaugePainter({required this.value});

//   @override
//   void paint(Canvas canvas, Size size) {
//     final center = Offset(size.width / 2, size.height / 2);
//     final radius = size.width / 2;

//     // Paint the background
//     final backgroundPaint = Paint()
//       ..color = Colors.grey[300]!
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 10;

//     canvas.drawArc(
//       Rect.fromCircle(center: center, radius: radius),
//       -pi / 2,
//       pi,
//       false,
//       backgroundPaint,
//     );

//     // Paint the colored segments
//     final gradient = SweepGradient(
//       colors: [Colors.red, Colors.orange, Colors.yellow, Colors.green, Colors.blue],
//       stops: [0.0, 0.25, 0.5, 0.75, 1.0],
//     );
//     final paint = Paint()
//       ..shader = gradient.createShader(Rect.fromCircle(center: center, radius: radius))
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 10;

//     canvas.drawArc(
//       Rect.fromCircle(center: center, radius: radius),
//       -pi / 2,
//       pi * value,
//       false,
//       paint,
//     );

//     // Paint the pointer
//     final pointerPaint = Paint()
//       ..color = Colors.blue
//       ..style = PaintingStyle.fill;

//     final pointerAngle = -pi / 2 + pi * value;
//     final pointerX = center.dx + radius * cos(pointerAngle);
//     final pointerY = center.dy + radius * sin(pointerAngle);

//     canvas.drawCircle(Offset(pointerX, pointerY), 10, pointerPaint);
//   }

//   @override
//   bool shouldRepaint(_HeatGaugePainter oldDelegate) {
//     return value != oldDelegate.value;
//   }
// }