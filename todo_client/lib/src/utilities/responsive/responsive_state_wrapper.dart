// MIT License
//
// Copyright (c) 2024 [Mostafijul Islam]
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import 'package:flutter/material.dart';

enum ResponsiveState implements Comparable<ResponsiveState> {
  ts(
    min: 0,
    max: 360,
    bodyMargin: 8,
    layoutColumn: 4,
    bodyWidth: null,
  ),
  xs(
    min: 361,
    max: 600,
    bodyMargin: 16,
    layoutColumn: 4,
    bodyWidth: null,
  ),
  sm(
    min: 601,
    max: 900,
    bodyMargin: 32,
    layoutColumn: 8,
    bodyWidth: null,
  ),
  md(
    min: 901,
    max: 1250,
    bodyMargin: null,
    layoutColumn: 12,
    bodyWidth: 840,
  ),
  lg(min: 1250, max: 1500, bodyMargin: 200, layoutColumn: 12, bodyWidth: null),
  xl(
    min: 1500,
    max: double.infinity,
    bodyMargin: null,
    layoutColumn: 8,
    bodyWidth: 1080,
  );

  const ResponsiveState({
    required this.min,
    required this.max,
    required this.bodyMargin,
    required this.layoutColumn,
    required this.bodyWidth,
  });

  final double max;
  final double min;

  /* Material 2 Specifications [https://arc.net/l/quote/qtcvlqts] */
  final double? bodyMargin;
  final int? layoutColumn;
  final double? bodyWidth;

  bool inRange(double screenWidth) => min <= screenWidth && screenWidth <= max;

  @override
  compareTo(ResponsiveState state) => min.toInt() - state.min.toInt();

  bool operator <=(ResponsiveState other) => compareTo(other) <= 0;

  bool operator >=(ResponsiveState other) => compareTo(other) >= 0;

  bool operator <(ResponsiveState other) => compareTo(other) < 0;

  bool operator >(ResponsiveState other) => compareTo(other) > 0;
}

extension ParentResponsiveStateGetter on BuildContext {
  ValueNotifier<ResponsiveState?> get responsiveStateListener {
    final state = findAncestorStateOfType<_ResponsiveParentWrapperState>();
    if (state == null) {
      throw UnimplementedError(
        "No parent [ResponsiveParentWrapper] "
        "widget found in the current widget tree!",
      );
    }
    return state.currentState;
  }

  ResponsiveState get responsiveState {
    final state = findAncestorStateOfType<_ResponsiveParentWrapperState>();
    final value = state?.currentState.value;
    if (state == null || value == null) {
      throw UnimplementedError(
        "No parent [ResponsiveParentWrapper] "
        "widget found in the current widget tree!"
        "Or the widget hasn't been built yet."
        "Please make sure the system is ready before using value!",
      );
    }
    return value;
  }
}

typedef ResponsiveWidgetCallback = Widget Function(
  BuildContext context,
  ResponsiveState currentState,
);

class ResponsiveParentWrapper extends StatefulWidget {
  const ResponsiveParentWrapper({
    super.key,
    required this.builder,
    this.useMaterialTwoSpecifications = false,
  });
  final bool useMaterialTwoSpecifications;
  final ResponsiveWidgetCallback builder;

  @override
  State<ResponsiveParentWrapper> createState() =>
      _ResponsiveParentWrapperState();
}

class _ResponsiveParentWrapperState extends State<ResponsiveParentWrapper> {
  late Widget child;
  ValueNotifier<ResponsiveState?> currentState = ValueNotifier(null);

  @override
  void didUpdateWidget(covariant ResponsiveParentWrapper oldWidget) {
    child = widget.builder(context, currentState.value!);
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final state = ResponsiveState.values.firstWhere(
          (element) => element.inRange(constraints.maxWidth),
        );
        if (currentState.value != state) {
          currentState.value = state;
          child = widget.builder(context, state);
        }
        return widget.useMaterialTwoSpecifications
            ? MaterialTwoSpecificationWrapper(state: state, child: child)
            : child;
      },
    );
  }
}

class MaterialTwoSpecificationWrapper extends StatelessWidget {
  const MaterialTwoSpecificationWrapper({
    super.key,
    required this.child,
    required this.state,
  });

  final Widget child;
  final ResponsiveState state;

  @override
  Widget build(BuildContext context) {
    Widget widget = child;
    if (state.bodyMargin != null) {
      widget = Padding(
        padding: EdgeInsets.symmetric(horizontal: state.bodyMargin!.toDouble()),
        child: widget,
      );
    }
    if (state.bodyWidth != null) {
      widget = Center(
        child: SizedBox(
          width: state.bodyWidth!.toDouble(),
          child: widget,
        ),
      );
    }
    return widget;
  }
}
