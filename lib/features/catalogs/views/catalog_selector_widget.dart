import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/catalog_item_dto.dart';
import '../viewmodels/catalogs_view_model.dart';

class CatalogSelectorWidget extends ConsumerStatefulWidget {
  final String label;
  final String groupName;
  final bool isState;
  final String? currentCode;
  final String? currentName;
  final void Function(CatalogItemDto) onChanged;

  const CatalogSelectorWidget({
    super.key,
    required this.label,
    required this.groupName,
    this.isState = false,
    this.currentCode,
    this.currentName,
    required this.onChanged,
  });

  @override
  ConsumerState<CatalogSelectorWidget> createState() =>
      _CatalogSelectorWidgetState();
}

class _CatalogSelectorWidgetState extends ConsumerState<CatalogSelectorWidget> {
  @override
  void initState() {
    super.initState();
    // Fetch data asynchronously when widget is mounted
    Future.microtask(() {
      if (!mounted) return;
      final vm = ref.read(catalogsViewModelProvider.notifier);
      if (widget.isState) {
        vm.fetchStateCatalog(widget.groupName);
      } else {
        vm.fetchTypeCatalog(widget.groupName);
      }
    });
  }

  void _showPicker(BuildContext context, List<CatalogItemDto> items) {
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
                  widget.label,
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
                      final isSelected = item.code == widget.currentCode;
                      return ListTile(
                        title: Text(item.name),
                        trailing: isSelected
                            ? const Icon(Icons.check, color: Colors.green)
                            : null,
                        onTap: () {
                          Navigator.of(context).pop();
                          widget.onChanged(item);
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
    final state = ref.watch(catalogsViewModelProvider);
    final vm = ref.read(catalogsViewModelProvider.notifier);

    final items = widget.isState
        ? state.cachedStates[widget.groupName] ?? []
        : state.cachedTypes[widget.groupName] ?? [];

    final displayName = widget.isState
        ? vm.getStateName(widget.groupName, widget.currentCode)
        : vm.getTypeName(widget.groupName, widget.currentCode);

    String displayValue = displayName;
    if (displayValue == widget.currentCode && widget.currentName != null && widget.currentName!.isNotEmpty) {
      displayValue = widget.currentName!;
    } else if (displayValue.isEmpty) {
      displayValue = 'Seleccionar...';
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: () => _showPicker(context, items),
        child: InputDecorator(
          decoration: InputDecoration(
            labelText: widget.label,
            isDense: true,
            suffixIcon: state.isLoading && items.isEmpty
                ? Transform.scale(
                    scale: 0.5,
                    child: const CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.arrow_drop_down),
          ),
          child: Text(
            displayValue,
            style: TextStyle(color: displayName.isEmpty ? Colors.grey : null),
          ),
        ),
      ),
    );
  }
}
