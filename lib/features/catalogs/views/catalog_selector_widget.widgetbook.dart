import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../../../core/widgets/catalogs/catalog_selector_widget.dart';
import '../models/catalog_item_dto.dart';

@widgetbook.UseCase(name: 'Default', type: CatalogSelectorWidget)
Widget buildCatalogSelectorWidgetUseCase(BuildContext context) {
  final items = [
    CatalogItemDto(code: 'OPT1', name: 'Opción 1'),
    CatalogItemDto(code: 'OPT2', name: 'Opción 2'),
    CatalogItemDto(code: 'OPT3', name: 'Opción 3'),
  ];

  return Scaffold(
    body: Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CatalogSelectorWidget(
          label: 'Selecciona una Opción',
          items: items,
          currentCode: null,
          isLoading: false,
          onChanged: (val) => debugPrint('Selected: ${val.code}'),
        ),
      ),
    ),
  );
}

@widgetbook.UseCase(name: 'Loading', type: CatalogSelectorWidget)
Widget buildCatalogSelectorWidgetLoadingUseCase(BuildContext context) {
  return Scaffold(
    body: Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CatalogSelectorWidget(
          label: 'Cargando Catálogo...',
          items: const [],
          currentCode: null,
          isLoading: true,
          onChanged: (val) {},
        ),
      ),
    ),
  );
}
