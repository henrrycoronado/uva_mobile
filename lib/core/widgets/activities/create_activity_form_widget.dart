import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../features/activities/models/create_activity_dto.dart';
import '../../../features/activities/models/create_activity_rule_dto.dart';

class CreateActivityFormWidget extends StatefulWidget {
  final String programCode;
  final List<Map<String, dynamic>> activityTypes;
  final Future<void> Function(CreateActivityDto dto) onSubmit;
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

  final _capacityController = TextEditingController();
  final _costController = TextEditingController();
  final _radiusController = TextEditingController();
  final _latController = TextEditingController();
  final _lngController = TextEditingController();

  String? _selectedTypeCode;
  DateTime? _startDate;
  DateTime? _endDate;
  bool _requiresEnrollment = false;
  bool _requiresApproval = false;
  bool _countsVolunteerHours = false;

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _capacityController.dispose();
    _costController.dispose();
    _radiusController.dispose();
    _latController.dispose();
    _lngController.dispose();
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

      final dto = CreateActivityDto(
        programCode: widget.programCode,
        activityTypeCode: _selectedTypeCode!,
        name: _nameController.text.trim(),
        description: _descriptionController.text.trim().isEmpty
            ? null
            : _descriptionController.text.trim(),
        startDate: _startDate!,
        endDate: _endDate!,
        requiresEnrollment: _requiresEnrollment,
        countsVolunteerHours: _countsVolunteerHours,
        costAmount: double.tryParse(_costController.text),
        locationLatitude: double.tryParse(_latController.text),
        locationLongitude: double.tryParse(_lngController.text),
        rule: CreateActivityRuleDto(
          registrationRadiusMeters: int.tryParse(_radiusController.text) ?? 500,
          requiresApproval: _requiresApproval,
          totalCapacity: int.tryParse(_capacityController.text),
        ),
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
                value: type['uvaCode'] as String,
                child: Text(type['name'] as String),
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
          ExpansionTile(
            title: const Text('Configuración Avanzada'),
            childrenPadding: const EdgeInsets.all(16),
            children: [
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
              SwitchListTile(
                title: const Text('Cuenta como Voluntariado'),
                value: _countsVolunteerHours,
                onChanged: widget.isLoading
                    ? null
                    : (val) {
                        setState(() {
                          _countsVolunteerHours = val;
                        });
                      },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _capacityController,
                decoration: InputDecoration(
                  labelText: 'Capacidad Total (opcional)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.group),
                ),
                keyboardType: TextInputType.number,
                enabled: !widget.isLoading,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _costController,
                decoration: InputDecoration(
                  labelText: 'Costo/Precio (opcional)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.attach_money),
                ),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                enabled: !widget.isLoading,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _radiusController,
                decoration: InputDecoration(
                  labelText: 'Radio de Registro (metros)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.radar),
                ),
                keyboardType: TextInputType.number,
                enabled: !widget.isLoading,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _latController,
                      decoration: InputDecoration(
                        labelText: 'Latitud',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      keyboardType: const TextInputType.numberWithOptions(signed: true, decimal: true),
                      enabled: !widget.isLoading,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextFormField(
                      controller: _lngController,
                      decoration: InputDecoration(
                        labelText: 'Longitud',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      keyboardType: const TextInputType.numberWithOptions(signed: true, decimal: true),
                      enabled: !widget.isLoading,
                    ),
                  ),
                ],
              ),
            ],
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
