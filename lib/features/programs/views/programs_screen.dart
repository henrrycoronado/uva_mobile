import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';

class ProgramsScreen extends StatelessWidget {
  const ProgramsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.navPrograms), centerTitle: true),
      body: const Center(child: Text('Programs Dummy View')),
    );
  }
}
