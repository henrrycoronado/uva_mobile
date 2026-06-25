import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:latlong2/latlong.dart';

import 'package:uva_design_system/models/activities/create_activity_dto.dart';
import 'package:uva_design_system/models/activities/create_activity_rule_dto.dart';
import '../../../l10n/app_localizations.dart';
import '../common/location_picker_dialog.dart';

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

  LatLng? _selectedLocation;

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
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      if (_startDate == null || _endDate == null) {
        final l10n = AppLocalizations.of(context)!;
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(l10n.datesRequiredError)));
        return;
      }
      if (_startDate!.isAfter(_endDate!)) {
        final l10n = AppLocalizations.of(context)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.startDateBeforeEndDateError)),
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
        locationLatitude: _selectedLocation?.latitude,
        locationLongitude: _selectedLocation?.longitude,
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
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: l10n.activityNameLabel,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              prefixIcon: const Icon(Icons.event),
            ),
            maxLength: 200,
            enabled: !widget.isLoading,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return l10n.nameRequired;
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
              labelText: l10n.activityTypeSelector,
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
                return l10n.requiredField;
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _descriptionController,
            decoration: InputDecoration(
              labelText: l10n.descriptionLabel,
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
                        ? '${l10n.startDateLabel} *'
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
                        ? '${l10n.endDateLabel} *'
                        : _endDate.toString().substring(0, 16),
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SwitchListTile(
            title: Text(l10n.requiresRegistration),
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
            title: Text(l10n.advancedSettings),
            childrenPadding: const EdgeInsets.all(16),
            children: [
              if (_requiresEnrollment)
                SwitchListTile(
                  title: Text(l10n.requiresApproval),
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
                title: Text(l10n.countsAsVolunteer),
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
                  labelText: l10n.capacityOptional,
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
                  labelText: l10n.costOptional,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.attach_money),
                ),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                enabled: !widget.isLoading,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _radiusController,
                decoration: InputDecoration(
                  labelText: l10n.radiusMeters,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.radar),
                ),
                keyboardType: TextInputType.number,
                enabled: !widget.isLoading,
              ),
              const SizedBox(height: 16),
              OutlinedButton.icon(
                onPressed: widget.isLoading
                    ? null
                    : () async {
                        final LatLng? result = await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => LocationPickerDialog(
                              initialLocation: _selectedLocation,
                            ),
                            fullscreenDialog: true,
                          ),
                        );
                        if (result != null) {
                          setState(() {
                            _selectedLocation = result;
                          });
                        }
                      },
                icon: const Icon(Icons.map),
                label: Text(
                  _selectedLocation == null
                      ? 'Seleccionar Ubicación en Mapa'
                      : 'Ubicación seleccionada',
                ),
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
                  child: Text(l10n.cancel),
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
                      ? SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: theme.colorScheme.onPrimary,
                          ),
                        )
                      : Text(l10n.save),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
