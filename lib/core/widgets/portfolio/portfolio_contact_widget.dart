import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../features/portfolio/models/contact_model.dart';
import '../../../features/portfolio/viewmodels/portfolio_contact_view_model.dart';
import '../../../l10n/app_localizations.dart';

class PortfolioContactWidget extends ConsumerWidget {
  const PortfolioContactWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    // Watch contact model from view model
    final contact = ref.watch(portfolioContactViewModelProvider);
    // Get view model notifier for actions
    final viewModel = ref.read(portfolioContactViewModelProvider.notifier);

    // Email template
    final emailTemplate = EmailTemplateModel(
      subject: l10n.supportTitle,
      body: 'Hola equipo de Uvoluntapp,\n\n',
    );

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: theme.colorScheme.outlineVariant),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              l10n.supportTitle,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Divider(height: 1),
          ListTile(
            leading: const Icon(Icons.email),
            title: Text(contact.email),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.copy, size: 20),
                  tooltip: 'Copiar correo',
                  onPressed: () {
                    viewModel.copyToClipboard(contact.email);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Correo copiado al portapapeles'),
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.open_in_new, size: 20),
                  tooltip: 'Enviar correo',
                  onPressed: () async {
                    final success = await viewModel.sendEmail(
                      contact.email,
                      emailTemplate,
                    );
                    if (!success && context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'No se pudo abrir la aplicación de correo',
                          ),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.phone),
            title: Text(contact.phone),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.copy, size: 20),
                  tooltip: 'Copiar teléfono',
                  onPressed: () {
                    viewModel.copyToClipboard(contact.phone);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Teléfono copiado al portapapeles'),
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.phone_forwarded, size: 20),
                  tooltip: 'Llamar',
                  onPressed: () async {
                    final success = await viewModel.callPhone(contact.phone);
                    if (!success && context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'No se pudo abrir la aplicación de teléfono',
                          ),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
