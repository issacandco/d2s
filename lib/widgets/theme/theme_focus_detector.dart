import 'package:flutter/widgets.dart';
import 'package:visibility_detector/visibility_detector.dart';

/// Fires callbacks every time the widgets appears or disappears from the screen.
class ThemeFocusDetector extends StatefulWidget {
  const ThemeFocusDetector({
    required this.child,
    this.onFocusGained,
    this.onFocusLost,
    this.onVisibilityGained,
    this.onVisibilityLost,
    this.onForegroundGained,
    this.onForegroundLost,
    super.key,
  });

  /// Called when the widgets becomes visible or enters foreground while visible.
  final VoidCallback? onFocusGained;

  /// Called when the widgets becomes invisible or enters background while visible.
  final VoidCallback? onFocusLost;

  /// Called when the widgets becomes visible.
  final VoidCallback? onVisibilityGained;

  /// Called when the widgets becomes invisible.
  final VoidCallback? onVisibilityLost;

  /// Called when the app entered the foreground while the widgets is visible.
  final VoidCallback? onForegroundGained;

  /// Called when the app is sent to background while the widgets was visible.
  final VoidCallback? onForegroundLost;

  /// The widgets below this widgets in the tree.
  final Widget child;

  @override
  ThemeFocusDetectorState createState() => ThemeFocusDetectorState();
}

class ThemeFocusDetectorState extends State<ThemeFocusDetector>
    with WidgetsBindingObserver {
  final _visibilityDetectorKey = UniqueKey();

  /// Whether this widgets is currently visible within the app.
  bool _isWidgetVisible = false;

  /// Whether the app is in the foreground.
  bool _isAppInForeground = true;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _notifyPlaneTransition(state);
  }

  /// Notifies app's transitions to/from the foreground.
  void _notifyPlaneTransition(AppLifecycleState state) {
    if (!_isWidgetVisible) {
      return;
    }

    final isAppResumed = state == AppLifecycleState.resumed;
    final wasResumed = _isAppInForeground;
    if (isAppResumed && !wasResumed) {
      _isAppInForeground = true;
      _notifyFocusGain();
      _notifyForegroundGain();
      return;
    }

    final isAppPaused = state == AppLifecycleState.paused;
    if (isAppPaused && wasResumed) {
      _isAppInForeground = false;
      _notifyFocusLoss();
      _notifyForegroundLoss();
    }
  }

  @override
  Widget build(BuildContext context) => VisibilityDetector(
        key: _visibilityDetectorKey,
        onVisibilityChanged: (visibilityInfo) {
          final visibleFraction = visibilityInfo.visibleFraction;
          _notifyVisibilityStatusChange(visibleFraction);
        },
        child: widget.child,
      );

  /// Notifies changes in the widgets's visibility.
  void _notifyVisibilityStatusChange(double newVisibleFraction) {
    if (!_isAppInForeground) {
      return;
    }

    final wasFullyVisible = _isWidgetVisible;
    final isFullyVisible = newVisibleFraction == 1;
    if (!wasFullyVisible && isFullyVisible) {
      _isWidgetVisible = true;
      _notifyFocusGain();
      _notifyVisibilityGain();
    }

    final isFullyInvisible = newVisibleFraction == 0;
    if (wasFullyVisible && isFullyInvisible) {
      _isWidgetVisible = false;
      _notifyFocusLoss();
      _notifyVisibilityLoss();
    }
  }

  void _notifyFocusGain() {
    final onFocusGained = widget.onFocusGained;
    if (onFocusGained != null) {
      onFocusGained();
    }
  }

  void _notifyFocusLoss() {
    final onFocusLost = widget.onFocusLost;
    if (onFocusLost != null) {
      onFocusLost();
    }
  }

  void _notifyVisibilityGain() {
    final onVisibilityGained = widget.onVisibilityGained;
    if (onVisibilityGained != null) {
      onVisibilityGained();
    }
  }

  void _notifyVisibilityLoss() {
    final onVisibilityLost = widget.onVisibilityLost;
    if (onVisibilityLost != null) {
      onVisibilityLost();
    }
  }

  void _notifyForegroundGain() {
    final onForegroundGained = widget.onForegroundGained;
    if (onForegroundGained != null) {
      onForegroundGained();
    }
  }

  void _notifyForegroundLoss() {
    final onForegroundLost = widget.onForegroundLost;
    if (onForegroundLost != null) {
      onForegroundLost();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
