class UpdateProgramDto {
  final String? name;
  final String? description;
  final String? acronym;
  final String? color;
  final String? profilePhotoUrl;
  final String? coverPhotoUrl;

  UpdateProgramDto({
    this.name,
    this.description,
    this.acronym,
    this.color,
    this.profilePhotoUrl,
    this.coverPhotoUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (acronym != null) 'acronym': acronym,
      if (color != null) 'color': color,
      if (profilePhotoUrl != null) 'profilePhotoUrl': profilePhotoUrl,
      if (coverPhotoUrl != null) 'coverPhotoUrl': coverPhotoUrl,
    };
  }
}
