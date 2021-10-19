import 'package:flutter/material.dart';

/// {@template hero_dialog_route}
/// Custom [PageRoute] that creates an overlay dialog (popup effect).
///
/// Best used with a [Hero] animation.
/// {@endtemplate}

class HeroDialogRoute<T> extends PageRoute<T> {
  /// {@macro hero_dialog_route}

  HeroDialogRoute({
    required WidgetBuilder builder,
    RouteSettings? settings,
    bool fullScreenDialog = false,
  })  : _builder = builder,
        super(
          fullscreenDialog: fullScreenDialog,
          settings: settings,
        );
  final WidgetBuilder _builder;
  @override
  Color? get barrierColor => Colors.black54;

  @override
  String? get barrierLabel => 'Popup dialog open';

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return _builder(context);
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return child;
  }

  @override
  bool get maintainState => true;

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => true;

  @override
  Duration get transitionDuration => const Duration(seconds: 1);
}
