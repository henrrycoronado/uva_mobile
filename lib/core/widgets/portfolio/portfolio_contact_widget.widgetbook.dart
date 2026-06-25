import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'portfolio_contact_widget.dart';

@widgetbook.UseCase(name: 'Default', type: PortfolioContactWidget)
Widget buildPortfolioContactWidgetUseCase(BuildContext context) {
  return Scaffold(
    body: ProviderScope(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: PortfolioContactWidget(),
        ),
      ),
    ),
  );
}
