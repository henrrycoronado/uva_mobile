import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:uva_design_system/models/programs/program_response_dto.dart';
import 'package:uva_design_system/models/programs/update_program_dto.dart';

class EditProgramFormWidget extends StatefulWidget {
  final ProgramResponseDto initialData;
  final Future<void> Function(UpdateProgramDto dto) onSubmit;
  final bool isLoading;

  const EditProgramFormWidget({
    super.key,
    required this.initialData,
    required this.onSubmit,
    this.isLoading = false,
  });

  @override
  State<EditProgramFormWidget> createState() => _EditProgramFormWidgetState();
}

class _EditProgramFormWidgetState extends State<EditProgramFormWidget> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _acronymController;
  late TextEditingController _descriptionController;
  late TextEditingController _colorController;
  late TextEditingController _profilePhotoController;
  late TextEditingController _coverPhotoController;
  late TextEditingController _missionStatementController;
  late TextEditingController _scheduleInfoController;
  late TextEditingController _contactInfoController;
  late TextEditingController _leadershipInfoController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialData.name);
    _acronymController = TextEditingController(
      text: widget.initialData.acronym ?? '',
    );
    _descriptionController = TextEditingController(
      text: widget.initialData.description ?? '',
    );
    _colorController = TextEditingController(
      text: widget.initialData.color ?? '',
    );
    _profilePhotoController = TextEditingController(
      text: widget.initialData.profilePhotoUrl ?? '',
    );
    _coverPhotoController = TextEditingController(
      text: widget.initialData.coverPhotoUrl ?? '',
    );
    _missionStatementController = TextEditingController(
      text: widget.initialData.missionStatement ?? '',
    );
    _scheduleInfoController = TextEditingController(
      text: widget.initialData.scheduleInfo ?? '',
    );
    _contactInfoController = TextEditingController(
      text: widget.initialData.contactInfo ?? '',
    );
    _leadershipInfoController = TextEditingController(
      text: widget.initialData.leadershipInfo ?? '',
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _acronymController.dispose();
    _descriptionController.dispose();
    _colorController.dispose();
    _profilePhotoController.dispose();
    _coverPhotoController.dispose();
    _missionStatementController.dispose();
    _scheduleInfoController.dispose();
    _contactInfoController.dispose();
    _leadershipInfoController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final dto = UpdateProgramDto(
        name: _nameController.text.trim().isEmpty
            ? null
            : _nameController.text.trim(),
        acronym: _acronymController.text.trim().isEmpty
            ? null
            : _acronymController.text.trim(),
        description: _descriptionController.text.trim().isEmpty
            ? null
            : _descriptionController.text.trim(),
        color: _colorController.text.trim().isEmpty
            ? null
            : _colorController.text.trim(),
        profilePhotoUrl: _profilePhotoController.text.trim().isEmpty
            ? null
            : _profilePhotoController.text.trim(),
        coverPhotoUrl: _coverPhotoController.text.trim().isEmpty
            ? null
            : _coverPhotoController.text.trim(),
        missionStatement: _missionStatementController.text.trim().isEmpty
            ? null
            : _missionStatementController.text.trim(),
        scheduleInfo: _scheduleInfoController.text.trim().isEmpty
            ? null
            : _scheduleInfoController.text.trim(),
        contactInfo: _contactInfoController.text.trim().isEmpty
            ? null
            : _contactInfoController.text.trim(),
        leadershipInfo: _leadershipInfoController.text.trim().isEmpty
            ? null
            : _leadershipInfoController.text.trim(),
      );
      widget.onSubmit(dto);
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
              labelText: 'Nombre del Programa',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              prefixIcon: const Icon(Icons.title),
            ),
            maxLength: 200,
            enabled: !widget.isLoading,
            validator: (value) {
              if (value != null &&
                  value.trim().isNotEmpty &&
                  value.trim().length < 3) {
                return 'El nombre debe tener al menos 3 caracteres';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _acronymController,
            decoration: InputDecoration(
              labelText: 'Acrónimo',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              prefixIcon: const Icon(Icons.short_text),
            ),
            maxLength: 10,
            enabled: !widget.isLoading,
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
            maxLines: 4,
            enabled: !widget.isLoading,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _missionStatementController,
            decoration: InputDecoration(
              labelText: 'Misión',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              prefixIcon: const Icon(Icons.flag),
            ),
            maxLines: 3,
            enabled: !widget.isLoading,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _scheduleInfoController,
            decoration: InputDecoration(
              labelText: 'Información de Horarios',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              prefixIcon: const Icon(Icons.access_time),
            ),
            maxLines: 2,
            enabled: !widget.isLoading,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _contactInfoController,
            decoration: InputDecoration(
              labelText: 'Información de Contacto',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              prefixIcon: const Icon(Icons.contact_phone),
            ),
            maxLines: 2,
            enabled: !widget.isLoading,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _leadershipInfoController,
            decoration: InputDecoration(
              labelText: 'Información de Líderes/Colaboradores',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              prefixIcon: const Icon(Icons.people),
            ),
            maxLines: 2,
            enabled: !widget.isLoading,
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
                      : const Text('Guardar'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
