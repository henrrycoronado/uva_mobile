import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import '../../../features/catalogs/models/catalog_item_dto.dart';
import '../../../features/home/models/profile_response_dto.dart';
import 'profile_details_widget.dart';

@widgetbook.UseCase(name: 'Default', type: ProfileDetailsWidget)
Widget buildProfileDetailsWidgetUseCase(BuildContext context) {
  final mockProfile = ProfileResponseDto(
    uvaCode: '123456789',
    firstName: 'Juan',
    lastName: 'Pérez',
    email: 'juan@example.com',
    careerCode: null,
    photoUrl: null,
    personalGoalHours: 100,
    stateCode: 'ACTIVE',
  );

  return Scaffold(
    body: Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ProfileDetailsWidget(
          profile: mockProfile,
          careerOptions: [
            CatalogItemDto(code: 'CIV', name: 'Ingeniería Civil'),
            CatalogItemDto(code: 'ARQ', name: 'Arquitectura'),
          ],
          isCatalogsLoading: false,
          imageVersion: 1,
          onSave: (dto) async => debugPrint('Saved: ${dto.toJson()}'),
          onPhotoUpload: (path) async => debugPrint('Photo upload: $path'),
        ),
      ),
    ),
  );
}
