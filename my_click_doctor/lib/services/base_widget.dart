import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BaseWidget<T extends ChangeNotifier> extends StatefulWidget {
  final Widget Function(BuildContext context, T model, Widget child) builder;
  final T model;
  final Widget child;
  final Function(T) onModelReady;
  final isLoading;
  BaseWidget(
      {Key key,
      this.builder,
      this.model,
      this.child,
      this.onModelReady,
      api,
      this.isLoading})
      : super(key: key);

  _BaseWidgetState<T> createState() => _BaseWidgetState<T>();
}

class _BaseWidgetState<T extends ChangeNotifier> extends State<BaseWidget<T>> {
  T model;
  int flg = 0;

  @override
  void initState() {
    model = widget.model;
    if (widget.onModelReady != null) {
      widget.onModelReady(model);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isLoading == true)
      return RefreshIndicator(
        // displacement: 100.0,
        // triggerMode: RefreshIndicatorTriggerMode.anywhere,
        onRefresh: () async {
          await widget.onModelReady(model);
          Timer(
              Duration(seconds: 2),
              () => {
                    setState(() {
                      flg++;
                    })
                  });
        },
        child: ChangeNotifierProvider<T>(
          create: (context) => model,
          child: Consumer<T>(
            builder: widget.builder,
            child: widget.child,
          ),
        ),
      );
    else
      return Container(
        child: ChangeNotifierProvider<T>(
          create: (context) => model,
          child: Consumer<T>(
            builder: widget.builder,
            child: widget.child,
          ),
        ),
      );
  }
}
