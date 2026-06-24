import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CreateProgramFormWidget extends StatefulWidget {
  final Future<void> Function(String name, String? acronym) onSubmit;
  final bool isLoading;

  const CreateProgramFormWidget({
    super.key,
    required this.onSubmit,
    this.isLoading = false,
  });

  @override
  State<CreateProgramFormWidget> createState() =>
      _CreateProgramFormWidgetState();
}

class _CreateProgramFormWidgetState extends State<CreateProgramFormWidget> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _acronymController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _acronymController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      widget.onSubmit(
        _nameController.text.trim(),
        _acronymController.text.trim().isEmpty
            ? null
            : _acronymController.text.trim(),
      );
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
              labelText: 'Nombre del Programa *',
              hintText: 'Ej. Programa de Liderazgo',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              prefixIcon: const Icon(Icons.title),
            ),
            maxLength: 200,
            enabled: !widget.isLoading,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'El nombre es requerido';
              }
              if (value.trim().length < 3) {
                return 'El nombre debe tener al menos 3 caracteres';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _acronymController,
            decoration: InputDecoration(
              labelText: 'Acrónimo (Opcional)',
              hintText: 'Ej. PLU',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              prefixIcon: const Icon(Icons.short_text),
            ),
            maxLength: 10,
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
                      : const Text('Crear Programa'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
