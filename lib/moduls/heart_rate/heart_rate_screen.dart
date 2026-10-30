import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heart_bpm/heart_bpm.dart';

/// Heart-rate (BPM) measurement via the phone camera + flash (PPG).
/// The finger goes over the rear camera/flash; the camera widget runs hidden
/// behind the heart. The raw sensor BPM is noisy, so we smooth it (median of a
/// window) and only accept plausible readings after a short warm-up.
class HeartRateScreen extends StatefulWidget {
  const HeartRateScreen({Key? key}) : super(key: key);

  @override
  State<HeartRateScreen> createState() => _HeartRateScreenState();
}

class _HeartRateScreenState extends State<HeartRateScreen>
    with SingleTickerProviderStateMixin {
  static const int measureSeconds = 45;
  static const int warmupSeconds = 5;

  final List<SensorValue> data = [];
  final List<int> _readings = [];
  int? displayBpm;
  int? finalBpm;

  bool measuring = false;
  int _elapsed = 0;
  Timer? _timer;
  late final AnimationController _pulse;

  @override
  void initState() {
    super.initState();
    _pulse = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 650))
      ..repeat(reverse: true);
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pulse.dispose();
    super.dispose();
  }

  int get progress => measuring
      ? ((_elapsed / measureSeconds) * 100).clamp(0, 100).round()
      : (finalBpm != null ? 100 : 0);

  void _start() {
    setState(() {
      measuring = true;
      data.clear();
      _readings.clear();
      displayBpm = null;
      finalBpm = null;
      _elapsed = 0;
    });
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) return;
      setState(() {
        _elapsed++;
        if (_elapsed >= measureSeconds) _stop();
      });
    });
  }

  void _stop() {
    _timer?.cancel();
    if (!mounted) return;
    setState(() {
      measuring = false;
      finalBpm = _readings.isNotEmpty ? _median(_readings) : displayBpm;
      displayBpm = finalBpm;
    });
  }

  // Max amount the shown number may change per update (smaller = smoother).
  static const int maxStep = 2;

  void _onBPM(int value) {
    if (_elapsed < warmupSeconds) return; // sensor warm-up
    if (value < 40 || value > 180) return; // implausible
    _readings.add(value);
    final recent = _readings.length <= 10
        ? _readings
        : _readings.sublist(_readings.length - 10);
    final target = _median(recent);
    setState(() {
      if (displayBpm == null) {
        displayBpm = target;
      } else {
        // Ease toward the target instead of jumping, so the change feels small.
        final diff = target - displayBpm!;
        final step = diff > maxStep ? maxStep : (diff < -maxStep ? -maxStep : diff);
        displayBpm = displayBpm! + step;
      }
    });
  }

  int _median(List<int> values) {
    final s = List<int>.from(values)..sort();
    final mid = s.length ~/ 2;
    return s.length.isOdd ? s[mid] : ((s[mid - 1] + s[mid]) / 2).round();
  }

  @override
  Widget build(BuildContext context) {
    final statusText = measuring
        ? (_elapsed < warmupSeconds
            ? 'Keep your finger still…'
            : 'Measuring… ($progress%)')
        : (finalBpm != null ? 'Result' : 'Place finger on camera');

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xffE11D28), Color(0xff7A0C13), Color(0xff000000)],
            stops: [0.0, 0.45, 1.0],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Back button
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                  ),
                ),
                SizedBox(height: 10.h),

                // Heart (with the hidden camera running behind it while measuring)
                SizedBox(
                  width: 240.w,
                  height: 240.w,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Hidden camera/PPG processor
                      if (measuring)
                        SizedBox(
                          width: 70.w,
                          height: 70.w,
                          child: HeartBPMDialog(
                            context: context,
                            showTextValues: false,
                            cameraWidgetHeight: 70.w,
                            cameraWidgetWidth: 70.w,
                            borderRadius: 8,
                            onRawData: (value) {
                              if (data.length >= 120) data.removeAt(0);
                              data.add(value);
                            },
                            onBPM: _onBPM,
                          ),
                        ),
                      // Soft outer ring
                      Container(
                        width: 220.w,
                        height: 220.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: Colors.white.withOpacity(.12), width: 2),
                        ),
                      ),
                      // Pulsing heart
                      ScaleTransition(
                        scale: Tween(begin: 1.0, end: 1.12).animate(
                            CurvedAnimation(
                                parent: _pulse, curve: Curves.easeInOut)),
                        child: Icon(Icons.favorite,
                            color: const Color(0xffFF3B3B), size: 150.w),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.h),

                // BPM value
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(displayBpm != null ? '$displayBpm' : '--',
                        style: TextStyle(
                            fontSize: 64.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            height: 1)),
                    SizedBox(width: 8.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.favorite, color: Colors.white, size: 18.w),
                        Text('bpm',
                            style: TextStyle(
                                fontSize: 20.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 6.h),
                Text(statusText,
                    style: TextStyle(fontSize: 18.sp, color: Colors.white70)),
                SizedBox(height: 26.h),

                // ECG / PPG waveform
                SizedBox(
                  height: 120.h,
                  width: double.infinity,
                  child: CustomPaint(
                    painter: _WavePainter(data),
                  ),
                ),
                SizedBox(height: 30.h),

                // Explanation
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 28.w),
                  child: Column(
                    children: [
                      Text(
                        "We use the PPG method to track your heart rate with your phone's camera",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 17.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            height: 1.4),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        'With each heartbeat, blood flow in your fingers changes',
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(fontSize: 14.sp, color: Colors.white38),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24.h),

                // Start / Stop
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 28.w),
                  child: SizedBox(
                    width: double.infinity,
                    height: 52.h,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            measuring ? Colors.white : const Color(0xffFF3B3B),
                        foregroundColor:
                            measuring ? const Color(0xffE11D28) : Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14)),
                      ),
                      onPressed: () => measuring ? _stop() : _start(),
                      icon: Icon(measuring ? Icons.stop : Icons.favorite),
                      label: Text(measuring ? 'Stop' : 'Start Measuring',
                          style: TextStyle(
                              fontSize: 16.sp, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                Text('For wellness reference only — not a medical device.',
                    style: TextStyle(fontSize: 11.sp, color: Colors.white30)),
                SizedBox(height: 16.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Draws the PPG signal as a clean white line (ECG-style). Shows a flat line
/// with a moving pulse when there's no data yet.
class _WavePainter extends CustomPainter {
  final List<SensorValue> data;
  _WavePainter(this.data);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2.2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path();

    if (data.length < 2) {
      // flat line
      path.moveTo(0, size.height / 2);
      path.lineTo(size.width, size.height / 2);
      canvas.drawPath(path, paint..color = Colors.white24);
      return;
    }

    final values = data.map((e) => (e.value).toDouble()).toList();
    double minV = values.reduce((a, b) => a < b ? a : b);
    double maxV = values.reduce((a, b) => a > b ? a : b);
    final range = (maxV - minV).abs() < 1e-6 ? 1.0 : (maxV - minV);

    final n = values.length;
    for (int i = 0; i < n; i++) {
      final x = size.width * (i / (n - 1));
      // normalize + invert (higher value -> higher on screen)
      final norm = (values[i] - minV) / range;
      final y = size.height - (norm * size.height * 0.9) - size.height * 0.05;
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _WavePainter old) => true;
}
