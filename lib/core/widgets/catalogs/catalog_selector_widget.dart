import 'package:flutter/material.dart';

import 'package:uva_design_system/models/catalogs/catalog_item_dto.dart';

class CatalogSelectorWidget extends StatelessWidget {
  final String label;
  final String? currentCode;
  final String? currentName;
  final List<CatalogItemDto> items;
  final bool isLoading;
  final void Function(CatalogItemDto) onChanged;

  const CatalogSelectorWidget({
    super.key,
    required this.label,
    this.currentCode,
    this.currentName,
    required this.items,
    this.isLoading = false,
    required this.onChanged,
  });

  void _showPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  label,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Divider(height: 1),
              if (items.isEmpty)
                const Padding(
                  padding: EdgeInsets.all(32.0),
                  child: Text('No hay opciones disponibles'),
                )
              else
                Flexible(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      final isSelected = item.code == currentCode;
                      return ListTile(
                        title: Text(item.name),
                        trailing: isSelected
                            ? const Icon(Icons.check, color: Colors.green)
                            : null,
                        onTap: () {
                          Navigator.of(context).pop();
                          onChanged(item);
                        },
                      );
                    },
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Determine display name locally from the provided items
    String displayValue = 'Seleccionar...';

    if (currentCode != null) {
      try {
        final match = items.firstWhere((item) => item.code == currentCode);
        displayValue = match.name;
      } catch (_) {
        if (currentName != null && currentName!.isNotEmpty) {
          displayValue = currentName!;
        } else {
          displayValue = currentCode!; // Fallback
        }
      }
    } else if (currentName != null && currentName!.isNotEmpty) {
      displayValue = currentName!;
    }

    final bool isPlaceholder = displayValue == 'Seleccionar...';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: () => _showPicker(context),
        child: InputDecorator(
          decoration: InputDecoration(
            labelText: label,
            isDense: true,
            suffixIcon: isLoading && items.isEmpty
                ? Transform.scale(
                    scale: 0.5,
                    child: const CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.arrow_drop_down),
          ),
          child: Text(
            displayValue,
            style: TextStyle(color: isPlaceholder ? Colors.grey : null),
          ),
        ),
      ),
    );
  }
}
