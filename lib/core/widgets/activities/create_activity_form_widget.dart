import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../features/activities/models/create_activity_simple_dto.dart';

class CreateActivityFormWidget extends StatefulWidget {
  final String programCode;
  final List<Map<String, dynamic>> activityTypes;
  final Future<void> Function(CreateActivitySimpleDto dto) onSubmit;
  final bool isLoading;

  const CreateActivityFormWidget({
    super.key,
    required this.programCode,
    required this.activityTypes,
    required this.onSubmit,
    this.isLoading = false,
  });

  @override
  State<CreateActivityFormWidget> createState() =>
      _CreateActivityFormWidgetState();
}

class _CreateActivityFormWidgetState extends State<CreateActivityFormWidget> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  String? _selectedTypeCode;
  DateTime? _startDate;
  DateTime? _endDate;
  bool _requiresEnrollment = false;
  bool _requiresApproval = false;

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      if (_startDate == null || _endDate == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Las fechas de inicio y fin son obligatorias'),
          ),
        );
        return;
      }
      if (_startDate!.isAfter(_endDate!)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'La fecha de inicio no puede ser posterior a la de fin',
            ),
          ),
        );
        return;
      }

      final dto = CreateActivitySimpleDto(
        programCode: widget.programCode,
        activityTypeCode: _selectedTypeCode!,
        name: _nameController.text.trim(),
        description: _descriptionController.text.trim().isEmpty
            ? null
            : _descriptionController.text.trim(),
        startDate: _startDate!,
        endDate: _endDate!,
        requiresEnrollment: _requiresEnrollment,
        requiresApproval: _requiresApproval,
      );

      widget.onSubmit(dto);
    }
  }

  Future<void> _selectDate(BuildContext context, bool isStart) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
    );
    if (picked != null) {
      if (!context.mounted) return;
      final TimeOfDay? time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (time != null) {
        setState(() {
          final dt = DateTime(
            picked.year,
            picked.month,
            picked.day,
            time.hour,
            time.minute,
          );
          if (isStart) {
            _startDate = dt;
          } else {
            _endDate = dt;
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: 'Nombre de la Actividad *',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              prefixIcon: const Icon(Icons.event),
            ),
            maxLength: 200,
            enabled: !widget.isLoading,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'El nombre es requerido';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
              labelText: 'Tipo de Actividad *',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              prefixIcon: const Icon(Icons.category),
            ),
            initialValue: _selectedTypeCode,
            items: widget.activityTypes.map((type) {
              return DropdownMenuItem<String>(
                value: type['code'] as String,
                child: Text(type['value'] as String),
              );
            }).toList(),
            onChanged: widget.isLoading
                ? null
                : (val) {
                    setState(() {
                      _selectedTypeCode = val;
                    });
                  },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Requerido';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _descriptionController,
            decoration: InputDecoration(
              labelText: 'Descripción',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              prefixIcon: const Icon(Icons.description),
            ),
            maxLines: 3,
            enabled: !widget.isLoading,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: widget.isLoading
                      ? null
                      : () => _selectDate(context, true),
                  icon: const Icon(Icons.calendar_today, size: 16),
                  label: Text(
                    _startDate == null
                        ? 'Inicio *'
                        : _startDate.toString().substring(0, 16),
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: widget.isLoading
                      ? null
                      : () => _selectDate(context, false),
                  icon: const Icon(Icons.event_available, size: 16),
                  label: Text(
                    _endDate == null
                        ? 'Fin *'
                        : _endDate.toString().substring(0, 16),
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SwitchListTile(
            title: const Text('Requiere Inscripción'),
            value: _requiresEnrollment,
            onChanged: widget.isLoading
                ? null
                : (val) {
                    setState(() {
                      _requiresEnrollment = val;
                    });
                  },
          ),
          if (_requiresEnrollment)
            SwitchListTile(
              title: const Text('Requiere Aprobación Manual'),
              value: _requiresApproval,
              onChanged: widget.isLoading
                  ? null
                  : (val) {
                      setState(() {
                        _requiresApproval = val;
                      });
                    },
            ),
          const SizedBox(height: 32),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: widget.isLoading ? null : () => context.pop(),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Cancelar'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: FilledButton(
                  onPressed: widget.isLoading ? null : _submit,
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: widget.isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text('Crear'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
