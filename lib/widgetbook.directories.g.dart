// dart format width=80
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_import, prefer_relative_imports, directives_ordering

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AppGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:uva_mobile/core/widgets/activities/activity_card_widget.widgetbook.dart'
    as _uva_mobile_core_widgets_activities_activity_card_widget_widgetbook;
import 'package:uva_mobile/core/widgets/activities/activity_details_content.widgetbook.dart'
    as _uva_mobile_core_widgets_activities_activity_details_content_widgetbook;
import 'package:uva_mobile/core/widgets/activities/create_activity_form_widget.widgetbook.dart'
    as _uva_mobile_core_widgets_activities_create_activity_form_widget_widgetbook;
import 'package:uva_mobile/core/widgets/auth/login_form.widgetbook.dart'
    as _uva_mobile_core_widgets_auth_login_form_widgetbook;
import 'package:uva_mobile/core/widgets/auth/register_form.widgetbook.dart'
    as _uva_mobile_core_widgets_auth_register_form_widgetbook;
import 'package:uva_mobile/core/widgets/catalogs/catalog_selector_widget.widgetbook.dart'
    as _uva_mobile_core_widgets_catalogs_catalog_selector_widget_widgetbook;
import 'package:uva_mobile/core/widgets/common/custom_button.widgetbook.dart'
    as _uva_mobile_core_widgets_common_custom_button_widgetbook;
import 'package:uva_mobile/core/widgets/common/custom_text_field.widgetbook.dart'
    as _uva_mobile_core_widgets_common_custom_text_field_widgetbook;
import 'package:uva_mobile/core/widgets/home/activity_stats_chart_widget.widgetbook.dart'
    as _uva_mobile_core_widgets_home_activity_stats_chart_widget_widgetbook;
import 'package:uva_mobile/core/widgets/home/goal_progress_chart_widget.widgetbook.dart'
    as _uva_mobile_core_widgets_home_goal_progress_chart_widget_widgetbook;
import 'package:uva_mobile/core/widgets/home/home_calendar_heatmap_widget.widgetbook.dart'
    as _uva_mobile_core_widgets_home_home_calendar_heatmap_widget_widgetbook;
import 'package:uva_mobile/core/widgets/home/home_goal_progress_widget.widgetbook.dart'
    as _uva_mobile_core_widgets_home_home_goal_progress_widget_widgetbook;
import 'package:uva_mobile/core/widgets/home/home_header_widget.widgetbook.dart'
    as _uva_mobile_core_widgets_home_home_header_widget_widgetbook;
import 'package:uva_mobile/core/widgets/home/scholarship_progress_card_widget.widgetbook.dart'
    as _uva_mobile_core_widgets_home_scholarship_progress_card_widget_widgetbook;
import 'package:uva_mobile/core/widgets/home/suggested_activities_widget.widgetbook.dart'
    as _uva_mobile_core_widgets_home_suggested_activities_widget_widgetbook;
import 'package:uva_mobile/core/widgets/layout/main_layout_screen.widgetbook.dart'
    as _uva_mobile_core_widgets_layout_main_layout_screen_widgetbook;
import 'package:uva_mobile/core/widgets/permissions/permission_dialog.widgetbook.dart'
    as _uva_mobile_core_widgets_permissions_permission_dialog_widgetbook;
import 'package:uva_mobile/core/widgets/portfolio/portfolio_contact_widget.widgetbook.dart'
    as _uva_mobile_core_widgets_portfolio_portfolio_contact_widget_widgetbook;
import 'package:uva_mobile/core/widgets/profile/logout_button_widget.widgetbook.dart'
    as _uva_mobile_core_widgets_profile_logout_button_widget_widgetbook;
import 'package:uva_mobile/core/widgets/profile/profile_actions_widget.widgetbook.dart'
    as _uva_mobile_core_widgets_profile_profile_actions_widget_widgetbook;
import 'package:uva_mobile/core/widgets/profile/profile_details_widget.widgetbook.dart'
    as _uva_mobile_core_widgets_profile_profile_details_widget_widgetbook;
import 'package:uva_mobile/core/widgets/profile/profile_settings_widget.widgetbook.dart'
    as _uva_mobile_core_widgets_profile_profile_settings_widget_widgetbook;
import 'package:uva_mobile/core/widgets/programs/create_program_form_widget.widgetbook.dart'
    as _uva_mobile_core_widgets_programs_create_program_form_widget_widgetbook;
import 'package:uva_mobile/core/widgets/programs/edit_program_form_widget.widgetbook.dart'
    as _uva_mobile_core_widgets_programs_edit_program_form_widget_widgetbook;
import 'package:uva_mobile/core/widgets/programs/program_card_widget.widgetbook.dart'
    as _uva_mobile_core_widgets_programs_program_card_widget_widgetbook;
import 'package:uva_mobile/core/widgets/programs/program_details_widget.widgetbook.dart'
    as _uva_mobile_core_widgets_programs_program_details_widget_widgetbook;
import 'package:widgetbook/widgetbook.dart' as _widgetbook;

final directories = <_widgetbook.WidgetbookNode>[
  _widgetbook.WidgetbookFolder(
    name: 'core',
    children: [
      _widgetbook.WidgetbookFolder(
        name: 'widgets',
        children: [
          _widgetbook.WidgetbookFolder(
            name: 'activities',
            children: [
              _widgetbook.WidgetbookComponent(
                name: 'ActivityCardWidget',
                useCases: [
                  _widgetbook.WidgetbookUseCase(
                    name: 'Default',
                    builder:
                        _uva_mobile_core_widgets_activities_activity_card_widget_widgetbook
                            .buildActivityCardWidgetUseCase,
                  ),
                ],
              ),
              _widgetbook.WidgetbookComponent(
                name: 'ActivityDetailsContent',
                useCases: [
                  _widgetbook.WidgetbookUseCase(
                    name: 'Default',
                    builder:
                        _uva_mobile_core_widgets_activities_activity_details_content_widgetbook
                            .buildActivityDetailsContentUseCase,
                  ),
                ],
              ),
              _widgetbook.WidgetbookComponent(
                name: 'CreateActivityFormWidget',
                useCases: [
                  _widgetbook.WidgetbookUseCase(
                    name: 'Default',
                    builder:
                        _uva_mobile_core_widgets_activities_create_activity_form_widget_widgetbook
                            .buildCreateActivityFormWidgetUseCase,
                  ),
                  _widgetbook.WidgetbookUseCase(
                    name: 'Loading state',
                    builder:
                        _uva_mobile_core_widgets_activities_create_activity_form_widget_widgetbook
                            .buildCreateActivityFormWidgetLoadingUseCase,
                  ),
                ],
              ),
            ],
          ),
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
            name: 'catalogs',
            children: [
              _widgetbook.WidgetbookComponent(
                name: 'CatalogSelectorWidget',
                useCases: [
                  _widgetbook.WidgetbookUseCase(
                    name: 'Default',
                    builder:
                        _uva_mobile_core_widgets_catalogs_catalog_selector_widget_widgetbook
                            .buildCatalogSelectorWidgetUseCase,
                  ),
                ],
              ),
            ],
          ),
          _widgetbook.WidgetbookFolder(
            name: 'common',
            children: [
              _widgetbook.WidgetbookComponent(
                name: 'CustomButton',
                useCases: [
                  _widgetbook.WidgetbookUseCase(
                    name: 'Default',
                    builder:
                        _uva_mobile_core_widgets_common_custom_button_widgetbook
                            .buildCustomButtonUseCase,
                  ),
                  _widgetbook.WidgetbookUseCase(
                    name: 'Loading state',
                    builder:
                        _uva_mobile_core_widgets_common_custom_button_widgetbook
                            .buildCustomButtonLoadingUseCase,
                  ),
                ],
              ),
              _widgetbook.WidgetbookComponent(
                name: 'CustomTextField',
                useCases: [
                  _widgetbook.WidgetbookUseCase(
                    name: 'Default',
                    builder:
                        _uva_mobile_core_widgets_common_custom_text_field_widgetbook
                            .buildCustomTextFieldUseCase,
                  ),
                  _widgetbook.WidgetbookUseCase(
                    name: 'Password (Obscure)',
                    builder:
                        _uva_mobile_core_widgets_common_custom_text_field_widgetbook
                            .buildCustomTextFieldObscureUseCase,
                  ),
                ],
              ),
            ],
          ),
          _widgetbook.WidgetbookFolder(
            name: 'home',
            children: [
              _widgetbook.WidgetbookComponent(
                name: 'ActivityStatsChartWidget',
                useCases: [
                  _widgetbook.WidgetbookUseCase(
                    name: 'Default',
                    builder:
                        _uva_mobile_core_widgets_home_activity_stats_chart_widget_widgetbook
                            .buildActivityStatsChartWidgetUseCase,
                  ),
                  _widgetbook.WidgetbookUseCase(
                    name: 'Empty State',
                    builder:
                        _uva_mobile_core_widgets_home_activity_stats_chart_widget_widgetbook
                            .buildActivityStatsChartWidgetEmptyUseCase,
                  ),
                ],
              ),
              _widgetbook.WidgetbookComponent(
                name: 'GoalProgressChartWidget',
                useCases: [
                  _widgetbook.WidgetbookUseCase(
                    name: 'Default',
                    builder:
                        _uva_mobile_core_widgets_home_goal_progress_chart_widget_widgetbook
                            .buildGoalProgressChartWidgetUseCase,
                  ),
                ],
              ),
              _widgetbook.WidgetbookComponent(
                name: 'HomeCalendarHeatmapWidget',
                useCases: [
                  _widgetbook.WidgetbookUseCase(
                    name: 'Default',
                    builder:
                        _uva_mobile_core_widgets_home_home_calendar_heatmap_widget_widgetbook
                            .buildHomeCalendarHeatmapWidgetUseCase,
                  ),
                ],
              ),
              _widgetbook.WidgetbookComponent(
                name: 'HomeGoalProgressWidget',
                useCases: [
                  _widgetbook.WidgetbookUseCase(
                    name: 'Completed Goal',
                    builder:
                        _uva_mobile_core_widgets_home_home_goal_progress_widget_widgetbook
                            .buildHomeGoalProgressWidgetCompletedUseCase,
                  ),
                  _widgetbook.WidgetbookUseCase(
                    name: 'Default',
                    builder:
                        _uva_mobile_core_widgets_home_home_goal_progress_widget_widgetbook
                            .buildHomeGoalProgressWidgetUseCase,
                  ),
                ],
              ),
              _widgetbook.WidgetbookComponent(
                name: 'HomeHeaderWidget',
                useCases: [
                  _widgetbook.WidgetbookUseCase(
                    name: 'Default',
                    builder:
                        _uva_mobile_core_widgets_home_home_header_widget_widgetbook
                            .buildHomeHeaderWidgetUseCase,
                  ),
                ],
              ),
              _widgetbook.WidgetbookComponent(
                name: 'ScholarshipProgressCardWidget',
                useCases: [
                  _widgetbook.WidgetbookUseCase(
                    name: 'Default',
                    builder:
                        _uva_mobile_core_widgets_home_scholarship_progress_card_widget_widgetbook
                            .buildScholarshipProgressCardWidgetUseCase,
                  ),
                  _widgetbook.WidgetbookUseCase(
                    name: 'No Scholarship',
                    builder:
                        _uva_mobile_core_widgets_home_scholarship_progress_card_widget_widgetbook
                            .buildScholarshipProgressCardWidgetNoScholarshipUseCase,
                  ),
                ],
              ),
              _widgetbook.WidgetbookComponent(
                name: 'SuggestedActivitiesWidget',
                useCases: [
                  _widgetbook.WidgetbookUseCase(
                    name: 'Default',
                    builder:
                        _uva_mobile_core_widgets_home_suggested_activities_widget_widgetbook
                            .buildSuggestedActivitiesWidgetUseCase,
                  ),
                ],
              ),
            ],
          ),
          _widgetbook.WidgetbookFolder(
            name: 'layout',
            children: [
              _widgetbook.WidgetbookComponent(
                name: 'MainLayoutScreen',
                useCases: [
                  _widgetbook.WidgetbookUseCase(
                    name: 'Default Placeholder',
                    builder:
                        _uva_mobile_core_widgets_layout_main_layout_screen_widgetbook
                            .buildMainLayoutScreenUseCase,
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
            name: 'portfolio',
            children: [
              _widgetbook.WidgetbookComponent(
                name: 'PortfolioContactWidget',
                useCases: [
                  _widgetbook.WidgetbookUseCase(
                    name: 'Default',
                    builder:
                        _uva_mobile_core_widgets_portfolio_portfolio_contact_widget_widgetbook
                            .buildPortfolioContactWidgetUseCase,
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
                name: 'ProfileActionsWidget',
                useCases: [
                  _widgetbook.WidgetbookUseCase(
                    name: 'Default',
                    builder:
                        _uva_mobile_core_widgets_profile_profile_actions_widget_widgetbook
                            .buildProfileActionsWidgetUseCase,
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
          _widgetbook.WidgetbookFolder(
            name: 'programs',
            children: [
              _widgetbook.WidgetbookComponent(
                name: 'CreateProgramFormWidget',
                useCases: [
                  _widgetbook.WidgetbookUseCase(
                    name: 'Default',
                    builder:
                        _uva_mobile_core_widgets_programs_create_program_form_widget_widgetbook
                            .buildCreateProgramFormWidgetUseCase,
                  ),
                  _widgetbook.WidgetbookUseCase(
                    name: 'Loading',
                    builder:
                        _uva_mobile_core_widgets_programs_create_program_form_widget_widgetbook
                            .buildCreateProgramFormWidgetLoadingUseCase,
                  ),
                ],
              ),
              _widgetbook.WidgetbookComponent(
                name: 'EditProgramFormWidget',
                useCases: [
                  _widgetbook.WidgetbookUseCase(
                    name: 'Default',
                    builder:
                        _uva_mobile_core_widgets_programs_edit_program_form_widget_widgetbook
                            .buildEditProgramFormWidgetUseCase,
                  ),
                ],
              ),
              _widgetbook.WidgetbookComponent(
                name: 'ProgramCardWidget',
                useCases: [
                  _widgetbook.WidgetbookUseCase(
                    name: 'Default',
                    builder:
                        _uva_mobile_core_widgets_programs_program_card_widget_widgetbook
                            .buildProgramCardWidgetUseCase,
                  ),
                  _widgetbook.WidgetbookUseCase(
                    name: 'No Acronym or Description',
                    builder:
                        _uva_mobile_core_widgets_programs_program_card_widget_widgetbook
                            .buildProgramCardWidgetMinimalUseCase,
                  ),
                ],
              ),
              _widgetbook.WidgetbookComponent(
                name: 'ProgramDetailsWidget',
                useCases: [
                  _widgetbook.WidgetbookUseCase(
                    name: 'Default',
                    builder:
                        _uva_mobile_core_widgets_programs_program_details_widget_widgetbook
                            .buildProgramDetailsWidgetUseCase,
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
