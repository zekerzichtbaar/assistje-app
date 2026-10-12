import 'dart:math' as math;

/// De rekenkunde achter het rad (port van `Pages/Wheel.tsx`). Hoeken in
/// graden, met de klok mee, 0 = boven (waar de wijzer staat). Segment `i`
/// beslaat `[i·seg, (i+1)·seg)` vanaf boven.

/// Hoe lang een draai duurt.
const Duration wheelSpinDuration = Duration(milliseconds: 4000);

/// Korte draai bij "minder beweging".
const Duration wheelReducedSpinDuration = Duration(milliseconds: 600);

/// Hoeveel volle rondes het rad maakt voor het uitkomt.
const int wheelFullTurns = 6;

/// De uitloop van de PWA (`1 - (1 - t)^3.2`).
double wheelEase(double t) =>
    1 - math.pow(1 - t.clamp(0.0, 1.0), 3.2).toDouble();

/// Grootte van één segment bij [count] deelnemers.
double segmentAngle(int count) => count <= 0 ? 360 : 360 / count;

/// De eindrotatie zodat het midden van segment [winnerIndex] onder de
/// wijzer stopt, vanaf [current] (die al rondes kan bevatten), altijd met
/// [fullTurns] volle rondes plus het stukje dat nog nodig is.
double spinTargetRotation({
  required double current,
  required int winnerIndex,
  required int count,
  int fullTurns = wheelFullTurns,
}) {
  final seg = segmentAngle(count);
  final targetCenter = winnerIndex * seg + seg / 2;
  final currentOffset = _mod360(current);
  final targetOffset = _mod360(360 - targetCenter);
  var delta = targetOffset - currentOffset;
  if (delta <= 0) delta += 360;
  return current + fullTurns * 360 + delta;
}

/// Welk segment er onder de wijzer staat bij rotatie [rotation].
int segmentAt(double rotation, int count) {
  if (count <= 0) return -1;
  final pointerAngle = _mod360(360 - _mod360(rotation));
  return (pointerAngle / segmentAngle(count)).floor() % count;
}

/// De "ratel" van de wijzer: een zaagtand over elk segment. Klimt tegen de
/// pin op (tot [maxTilt] graden, negatief = naar rechts) en klapt terug.
double pointerTilt(double rotation, int count, {double maxTilt = 20}) {
  if (count < 2) return 0;
  const rise = 0.85;
  final seg = segmentAngle(count);
  final phase = _mod(rotation, seg) / seg;
  if (phase < rise) {
    final p = phase / rise;
    return -maxTilt * (1 - math.pow(1 - p, 1.8));
  }
  final p = (phase - rise) / (1 - rise);
  return -maxTilt * (1 - p);
}

/// Kort een naam in tot [maxChars] tekens (met `…`).
String shortWheelName(String name, int maxChars) =>
    name.length <= maxChars ? name : '${name.substring(0, maxChars - 1)}…';

double _mod360(double value) => _mod(value, 360);

double _mod(double value, double by) => ((value % by) + by) % by;
