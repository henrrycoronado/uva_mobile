import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import '../../../features/catalogs/models/catalog_item_dto.dart';
import 'catalog_selector_widget.dart';

@widgetbook.UseCase(name: 'Default', type: CatalogSelectorWidget)
Widget buildCatalogSelectorWidgetUseCase(BuildContext context) {
  final items = [
    CatalogItemDto(
      code: 'ITM1',
      name: 'Opción 1',
    ),
    CatalogItemDto(
      code: 'ITM2',
      name: 'Opción 2',
    ),
  ];

  return Scaffold(
    body: Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CatalogSelectorWidget(
          label: 'Seleccionar Categoría',
          items: items,
          currentCode: 'ITM1',
          onChanged: (item) {},
        ),
      ),
    ),
  );
}
