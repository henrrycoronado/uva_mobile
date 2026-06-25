class UpdateProgramDto {
  final String? name;
  final String? description;
  final String? acronym;
  final String? color;
  final String? profilePhotoUrl;
  final String? coverPhotoUrl;
  final String? missionStatement;
  final String? scheduleInfo;
  final String? contactInfo;
  final String? leadershipInfo;

  UpdateProgramDto({
    this.name,
    this.description,
    this.acronym,
    this.color,
    this.profilePhotoUrl,
    this.coverPhotoUrl,
    this.missionStatement,
    this.scheduleInfo,
    this.contactInfo,
    this.leadershipInfo,
  });

  Map<String, dynamic> toJson() {
    return {
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (acronym != null) 'acronym': acronym,
      if (color != null) 'color': color,
      if (profilePhotoUrl != null) 'profilePhotoUrl': profilePhotoUrl,
      if (coverPhotoUrl != null) 'coverPhotoUrl': coverPhotoUrl,
      if (missionStatement != null) 'missionStatement': missionStatement,
      if (scheduleInfo != null) 'scheduleInfo': scheduleInfo,
      if (contactInfo != null) 'contactInfo': contactInfo,
      if (leadershipInfo != null) 'leadershipInfo': leadershipInfo,
    };
  }
}
