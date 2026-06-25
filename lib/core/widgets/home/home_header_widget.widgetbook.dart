import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'home_header_widget.dart';

@widgetbook.UseCase(name: 'Default', type: HomeHeaderWidget)
Widget buildHomeHeaderWidgetUseCase(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Header Widget')),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: HomeHeaderWidget(
        firstName: 'Juan',
      ),
    ),
  );
}
