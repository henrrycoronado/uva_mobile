import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../features/catalogs/models/catalog_groups.dart';
import '../../../../features/catalogs/viewmodels/catalogs_view_model.dart';
import '../../../../features/catalogs/views/catalog_selector_widget.dart';
import '../../../../features/home/models/profile_response_dto.dart';
import '../../../../features/home/viewmodels/home_view_model.dart';
import '../../../../features/profile/models/update_profile_dto.dart';
import '../../../../features/profile/repositories/profile_repository.dart';
import '../../../../features/profile/viewmodels/profile_view_model.dart';
import '../../../../l10n/app_localizations.dart';
import '../../theme/app_colors.dart';

class ProfileDetailsWidget extends ConsumerStatefulWidget {
  final ProfileResponseDto profile;

  const ProfileDetailsWidget({super.key, required this.profile});

  @override
  ConsumerState<ProfileDetailsWidget> createState() =>
      _ProfileDetailsWidgetState();
}

class _ProfileDetailsWidgetState extends ConsumerState<ProfileDetailsWidget> {
  bool _isEditing = false;
  bool _isLoading = false;
  bool _isUploadingPhoto = false;
  int _imageVersion = DateTime.now().millisecondsSinceEpoch;

  late TextEditingController _firstNameCtrl;
  late TextEditingController _lastNameCtrl;
  late TextEditingController _phoneCtrl;
  late TextEditingController _housingCtrl;
  late TextEditingController _goalCtrl;
  String? _selectedCareerCode;

  @override
  void initState() {
    super.initState();
    _initControllers();
  }

  void _initControllers() {
    _firstNameCtrl = TextEditingController(text: widget.profile.firstName);
    _lastNameCtrl = TextEditingController(text: widget.profile.lastName);
    _phoneCtrl = TextEditingController(text: widget.profile.phone ?? '');
    _housingCtrl = TextEditingController(
      text: widget.profile.housingLocation ?? '',
    );
    _goalCtrl = TextEditingController(
      text: widget.profile.personalGoalHours.toString(),
    );
    _selectedCareerCode = widget.profile.careerCode;
  }

  @override
  void didUpdateWidget(covariant ProfileDetailsWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!_isEditing) {
      _initControllers();
    }
  }

  @override
  void dispose() {
    _firstNameCtrl.dispose();
    _lastNameCtrl.dispose();
    _phoneCtrl.dispose();
    _housingCtrl.dispose();
    _goalCtrl.dispose();
    super.dispose();
  }

  Future<void> _saveProfile() async {
    setState(() => _isLoading = true);
    try {
      final dto = UpdateProfileDto(
        firstName: _firstNameCtrl.text.trim(),
        lastName: _lastNameCtrl.text.trim(),
        phone: _phoneCtrl.text.trim(),
        housingLocation: _housingCtrl.text.trim(),
        careerCode: _selectedCareerCode,
        personalGoalHours: double.tryParse(_goalCtrl.text.trim()),
      );

      final repo = ref.read(profileRepositoryProvider);
      await repo.updateProfile(dto);

      // Refresh global state
      await ref.read(homeViewModelProvider.notifier).refresh(forceRefresh: true);
      await ref.read(profileViewModelProvider.notifier).refresh(forceRefresh: true);

      setState(() => _isEditing = false);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Widget _buildAvatar() {
    final photoUrl = widget.profile.photoUrl;
    final r2Url = dotenv.env['R2_PUBLIC_URL'] ?? '';

    Widget avatarChild;
    if (photoUrl == null || photoUrl.contains('default') || photoUrl.isEmpty) {
      avatarChild = SvgPicture.asset(
        'assets/images/ProfileLogo.svg',
        fit: BoxFit.cover,
      );
    } else {
      final finalUrl = photoUrl.startsWith('http') ? photoUrl : '$r2Url/$photoUrl';
      final versionedUrl = finalUrl.contains('?') 
          ? '$finalUrl&v=$_imageVersion' 
          : '$finalUrl?v=$_imageVersion';
      
      avatarChild = Image.network(
        versionedUrl,
        fit: BoxFit.cover,
        errorBuilder: (_, _, _) => const Icon(Icons.person, size: 50),
      );
    }

    return Stack(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey.withValues(alpha: 0.2),
          ),
          clipBehavior: Clip.antiAlias,
          child: avatarChild,
        ),
        if (_isEditing)
          Positioned(
            bottom: 0,
            right: 0,
            child: CircleAvatar(
              radius: 16,
              backgroundColor: AppColors.primary,
              child: IconButton(
                padding: EdgeInsets.zero,
                icon: _isUploadingPhoto
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.black,
                        ),
                      )
                    : const Icon(
                        Icons.camera_alt,
                        size: 16,
                        color: Colors.black,
                      ),
                onPressed: _isUploadingPhoto ? null : _showPhotoPicker,
              ),
            ),
          ),
      ],
    );
  }

  Future<void> _showPhotoPicker() async {
    final picker = ImagePicker();
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Tomar Foto'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickAndUploadPhoto(picker, ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Elegir de la Galería'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickAndUploadPhoto(picker, ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickAndUploadPhoto(
    ImagePicker picker,
    ImageSource source,
  ) async {
    try {
      final XFile? photo = await picker.pickImage(
        source: source,
        imageQuality: 70, // Compresses the image to save bandwidth
        maxWidth: 1024,
        maxHeight: 1024,
      );

      if (photo == null) return; // User canceled

      setState(() => _isUploadingPhoto = true);

      final repo = ref.read(profileRepositoryProvider);
      await repo.updateProfilePhoto(photo.path);

      // Refresh global state to get new URL
      await ref.read(homeViewModelProvider.notifier).refresh(forceRefresh: true);
      await ref.read(profileViewModelProvider.notifier).refresh(forceRefresh: true);

      // Clear Flutter's image cache and update version to force UI refresh
      PaintingBinding.instance.imageCache.clear();
      PaintingBinding.instance.imageCache.clearLiveImages();

      if (!mounted) return;
      setState(() {
        _imageVersion = DateTime.now().millisecondsSinceEpoch;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Foto de perfil actualizada correctamente'),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error al subir la foto: $e')));
    } finally {
      if (mounted) {
        setState(() => _isUploadingPhoto = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    ref.watch(catalogsViewModelProvider);

    final careerDisplay =
        widget.profile.careerName ??
        ref
            .read(catalogsViewModelProvider.notifier)
            .getTypeName(CatalogTypeGroup.career, widget.profile.careerCode);

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: theme.colorScheme.outlineVariant),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildAvatar(),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (!_isEditing) ...[
                        Text(
                          '${widget.profile.firstName} ${widget.profile.lastName}',
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          widget.profile.email,
                          style: theme.textTheme.bodyMedium,
                        ),
                        if (widget.profile.phone != null)
                          Text(
                            widget.profile.phone!,
                            style: theme.textTheme.bodyMedium,
                          ),
                      ] else ...[
                        TextField(
                          controller: _firstNameCtrl,
                          decoration: const InputDecoration(
                            labelText: 'First Name',
                            isDense: true,
                          ),
                        ),
                        TextField(
                          controller: _lastNameCtrl,
                          decoration: const InputDecoration(
                            labelText: 'Last Name',
                            isDense: true,
                          ),
                        ),
                        TextField(
                          controller: _phoneCtrl,
                          decoration: const InputDecoration(
                            labelText: 'Phone',
                            isDense: true,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (!_isEditing) ...[
              if (careerDisplay.isNotEmpty) _infoRow('Career', careerDisplay),
              if (widget.profile.housingLocation != null)
                _infoRow('Housing', widget.profile.housingLocation!),
              _infoRow(
                'Goal Hours',
                widget.profile.personalGoalHours.toString(),
              ),
            ] else ...[
              CatalogSelectorWidget(
                label: 'Career',
                groupName: CatalogTypeGroup.career,
                currentCode: _selectedCareerCode,
                currentName: widget.profile.careerName,
                onChanged: (item) {
                  setState(() => _selectedCareerCode = item.code);
                },
              ),
              TextField(
                controller: _housingCtrl,
                decoration: const InputDecoration(
                  labelText: 'Housing Location',
                  isDense: true,
                ),
              ),
              TextField(
                controller: _goalCtrl,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Goal Hours',
                  isDense: true,
                ),
              ),
            ],
            const SizedBox(height: 24),
            if (_isLoading)
              const CircularProgressIndicator()
            else if (_isEditing)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      setState(() => _isEditing = false);
                      _initControllers();
                    },
                    child: Text(l10n.profileCancel),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: _saveProfile,
                    child: Text(l10n.profileSave),
                  ),
                ],
              )
            else
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => setState(() => _isEditing = true),
                  child: Text(l10n.profileEdit),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
