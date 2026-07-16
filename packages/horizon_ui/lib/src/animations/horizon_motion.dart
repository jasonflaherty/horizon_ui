import 'package:flutter/widgets.dart';

import '../extensions/horizon_context.dart';
import '../tokens/motion_tokens.dart';

/// Helpers for motion that respect reduced-motion preferences.
abstract final class HorizonMotion {
  static Duration resolve(BuildContext context, Duration preferred) {
    if (context.horizonReduceMotion) {
      return Duration.zero;
    }
    return preferred;
  }

  static Duration fast(BuildContext context) {
    final HorizonMotionTokens motion = context.horizon.motion;
    return resolve(context, motion.fast);
  }

  static Duration medium(BuildContext context) {
    final HorizonMotionTokens motion = context.horizon.motion;
    return resolve(context, motion.medium);
  }

  static Duration slow(BuildContext context) {
    final HorizonMotionTokens motion = context.horizon.motion;
    return resolve(context, motion.slow);
  }

  static bool shouldAnimate(BuildContext context) =>
      !context.horizonReduceMotion;
}
