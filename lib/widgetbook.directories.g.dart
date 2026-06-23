// dart format width=80
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_import, prefer_relative_imports, directives_ordering

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AppGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:uva_mobile/core/widgets/auth/login_form.widgetbook.dart'
    as _uva_mobile_core_widgets_auth_login_form_widgetbook;
import 'package:uva_mobile/core/widgets/auth/register_form.widgetbook.dart'
    as _uva_mobile_core_widgets_auth_register_form_widgetbook;
import 'package:uva_mobile/core/widgets/permissions/permission_dialog.widgetbook.dart'
    as _uva_mobile_core_widgets_permissions_permission_dialog_widgetbook;
import 'package:uva_mobile/core/widgets/profile/logout_button_widget.widgetbook.dart'
    as _uva_mobile_core_widgets_profile_logout_button_widget_widgetbook;
import 'package:uva_mobile/core/widgets/profile/profile_details_widget.widgetbook.dart'
    as _uva_mobile_core_widgets_profile_profile_details_widget_widgetbook;
import 'package:uva_mobile/core/widgets/profile/profile_settings_widget.widgetbook.dart'
    as _uva_mobile_core_widgets_profile_profile_settings_widget_widgetbook;
import 'package:uva_mobile/features/catalogs/views/catalog_selector_widget.widgetbook.dart'
    as _uva_mobile_features_catalogs_views_catalog_selector_widget_widgetbook;
import 'package:widgetbook/widgetbook.dart' as _widgetbook;

final directories = <_widgetbook.WidgetbookNode>[
  _widgetbook.WidgetbookFolder(
    name: 'core',
    children: [
      _widgetbook.WidgetbookFolder(
        name: 'widgets',
        children: [
          _widgetbook.WidgetbookFolder(
            name: 'auth',
            children: [
              _widgetbook.WidgetbookComponent(
                name: 'LoginForm',
                useCases: [
                  _widgetbook.WidgetbookUseCase(
                    name: 'Default',
                    builder: _uva_mobile_core_widgets_auth_login_form_widgetbook
                        .buildLoginFormUseCase,
                  ),
                  _widgetbook.WidgetbookUseCase(
                    name: 'Loading state',
                    builder: _uva_mobile_core_widgets_auth_login_form_widgetbook
                        .buildLoginFormLoadingUseCase,
                  ),
                ],
              ),
              _widgetbook.WidgetbookComponent(
                name: 'RegisterForm',
                useCases: [
                  _widgetbook.WidgetbookUseCase(
                    name: 'Default',
                    builder:
                        _uva_mobile_core_widgets_auth_register_form_widgetbook
                            .buildRegisterFormUseCase,
                  ),
                  _widgetbook.WidgetbookUseCase(
                    name: 'Loading state',
                    builder:
                        _uva_mobile_core_widgets_auth_register_form_widgetbook
                            .buildRegisterFormLoadingUseCase,
                  ),
                ],
              ),
            ],
          ),
          _widgetbook.WidgetbookFolder(
            name: 'permissions',
            children: [
              _widgetbook.WidgetbookComponent(
                name: 'PermissionDialog',
                useCases: [
                  _widgetbook.WidgetbookUseCase(
                    name: 'Default',
                    builder:
                        _uva_mobile_core_widgets_permissions_permission_dialog_widgetbook
                            .buildPermissionDialogUseCase,
                  ),
                ],
              ),
            ],
          ),
          _widgetbook.WidgetbookFolder(
            name: 'profile',
            children: [
              _widgetbook.WidgetbookComponent(
                name: 'LogoutButtonWidget',
                useCases: [
                  _widgetbook.WidgetbookUseCase(
                    name: 'Default',
                    builder:
                        _uva_mobile_core_widgets_profile_logout_button_widget_widgetbook
                            .buildLogoutButtonWidgetUseCase,
                  ),
                ],
              ),
              _widgetbook.WidgetbookComponent(
                name: 'ProfileDetailsWidget',
                useCases: [
                  _widgetbook.WidgetbookUseCase(
                    name: 'Default',
                    builder:
                        _uva_mobile_core_widgets_profile_profile_details_widget_widgetbook
                            .buildProfileDetailsWidgetUseCase,
                  ),
                ],
              ),
              _widgetbook.WidgetbookComponent(
                name: 'ProfileSettingsWidget',
                useCases: [
                  _widgetbook.WidgetbookUseCase(
                    name: 'Default',
                    builder:
                        _uva_mobile_core_widgets_profile_profile_settings_widget_widgetbook
                            .buildProfileSettingsWidgetUseCase,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  ),
  _widgetbook.WidgetbookFolder(
    name: 'features',
    children: [
      _widgetbook.WidgetbookFolder(
        name: 'catalogs',
        children: [
          _widgetbook.WidgetbookFolder(
            name: 'views',
            children: [
              _widgetbook.WidgetbookComponent(
                name: 'CatalogSelectorWidget',
                useCases: [
                  _widgetbook.WidgetbookUseCase(
                    name: 'Default',
                    builder:
                        _uva_mobile_features_catalogs_views_catalog_selector_widget_widgetbook
                            .buildCatalogSelectorWidgetUseCase,
                  ),
                  _widgetbook.WidgetbookUseCase(
                    name: 'Loading',
                    builder:
                        _uva_mobile_features_catalogs_views_catalog_selector_widget_widgetbook
                            .buildCatalogSelectorWidgetLoadingUseCase,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  ),
];
