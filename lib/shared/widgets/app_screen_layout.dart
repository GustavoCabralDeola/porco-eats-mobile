import 'package:flutter/material.dart';

class AppScreenLayout extends StatelessWidget {
  const AppScreenLayout({super.key, this.header, required this.children});

  final Widget? header;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final widgets = <Widget>[];
    if (header != null) {
      widgets.add(header!);
    }
    widgets.addAll(children);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: widgets,
          ),
        ),
      ),
    );
  }
}
