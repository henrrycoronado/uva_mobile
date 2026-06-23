import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../l10n/app_localizations.dart';

class ProfileSettingsWidget extends StatefulWidget {
  final Locale currentLocale;
  final ThemeMode currentTheme;
  final double currentTextScale;
  final ValueChanged<String> onChangeLocale;
  final ValueChanged<ThemeMode> onChangeTheme;
  final ValueChanged<String> onChangeTextScale;

  const ProfileSettingsWidget({
    super.key,
    required this.currentLocale,
    required this.currentTheme,
    required this.currentTextScale,
    required this.onChangeLocale,
    required this.onChangeTheme,
    required this.onChangeTextScale,
  });

  @override
  State<ProfileSettingsWidget> createState() => _ProfileSettingsWidgetState();
}

class _ProfileSettingsWidgetState extends State<ProfileSettingsWidget> {
  Map<Permission, PermissionStatus> _permissionsStatus = {};

  @override
  void initState() {
    super.initState();
    _checkPermissions();
  }

  Future<void> _checkPermissions() async {
    final camera = await Permission.camera.status;
    final location = await Permission.location.status;
    final notification = await Permission.notification.status;

    if (mounted) {
      setState(() {
        _permissionsStatus = {
          Permission.camera: camera,
          Permission.location: location,
          Permission.notification: notification,
        };
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    // Map textScale double to string for dropdown
    String textScaleStr = 'normal';
    if (widget.currentTextScale == 0.85) textScaleStr = 'small';
    if (widget.currentTextScale == 1.15) textScaleStr = 'large';

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
              l10n.settingsTitle,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Divider(height: 1),
          ListTile(
            leading: const Icon(Icons.language),
            title: Text(l10n.settingsLanguage),
            trailing: DropdownButton<String>(
              value: widget.currentLocale.languageCode == 'es' ? 'es' : 'en',
              underline: const SizedBox(),
              items: [
                DropdownMenuItem(
                  value: 'es',
                  child: Text(l10n.settingsLanguageEs),
                ),
                DropdownMenuItem(
                  value: 'en',
                  child: Text(l10n.settingsLanguageEn),
                ),
              ],
              onChanged: (val) {
                if (val != null) widget.onChangeLocale(val);
              },
            ),
          ),
          ListTile(
            leading: const Icon(Icons.dark_mode),
            title: Text(l10n.settingsTheme),
            trailing: DropdownButton<ThemeMode>(
              value: widget.currentTheme,
              underline: const SizedBox(),
              items: [
                DropdownMenuItem(
                  value: ThemeMode.system,
                  child: Text(l10n.settingsThemeSystem),
                ),
                DropdownMenuItem(
                  value: ThemeMode.light,
                  child: Text(l10n.settingsThemeLight),
                ),
                DropdownMenuItem(
                  value: ThemeMode.dark,
                  child: Text(l10n.settingsThemeDark),
                ),
              ],
              onChanged: (val) {
                if (val != null) widget.onChangeTheme(val);
              },
            ),
          ),
          ListTile(
            leading: const Icon(Icons.format_size),
            title: Text(l10n.settingsFontSize),
            trailing: DropdownButton<String>(
              value: textScaleStr,
              underline: const SizedBox(),
              items: [
                DropdownMenuItem(
                  value: 'small',
                  child: Text(l10n.settingsFontSmall),
                ),
                DropdownMenuItem(
                  value: 'normal',
                  child: Text(l10n.settingsFontNormal),
                ),
                DropdownMenuItem(
                  value: 'large',
                  child: Text(l10n.settingsFontBig),
                ),
              ],
              onChanged: (val) {
                if (val != null) widget.onChangeTextScale(val);
              },
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              l10n.settingsPermissions,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          _buildPermissionTile(
            l10n.settingsPermissionCamera,
            Permission.camera,
            l10n,
          ),
          _buildPermissionTile(
            l10n.settingsPermissionLocation,
            Permission.location,
            l10n,
          ),
          _buildPermissionTile(
            l10n.settingsPermissionNotifications,
            Permission.notification,
            l10n,
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildPermissionTile(
    String title,
    Permission permission,
    AppLocalizations l10n,
  ) {
    final status = _permissionsStatus[permission];
    final isGranted = status?.isGranted ?? false;

    return ListTile(
      dense: true,
      title: Text(title),
      trailing: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          color: isGranted
              ? Colors.green.withValues(alpha: 0.1)
              : Colors.red.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          isGranted
              ? l10n.settingsPermissionGranted
              : l10n.settingsPermissionDenied,
          style: TextStyle(
            color: isGranted ? Colors.green : Colors.red,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ),
      onTap: () async {
        if (!isGranted) {
          await permission.request();
          _checkPermissions();
        } else {
          openAppSettings();
        }
      },
    );
  }
}

