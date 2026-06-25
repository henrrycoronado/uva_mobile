class ProgramResponseDto {
  final String uvaCode;
  final String name;
  final String? description;
  final String? acronym;
  final String? color;
  final String? profilePhotoUrl;
  final String? coverPhotoUrl;
  final String? missionStatement;
  final String? scheduleInfo;
  final String? contactInfo;
  final String? leadershipInfo;
  final String managerProfileId;
  final String managerName;
  final String state;
  final String stateCode;
  final DateTime createdAt;

  ProgramResponseDto({
    required this.uvaCode,
    required this.name,
    this.description,
    this.acronym,
    this.color,
    this.profilePhotoUrl,
    this.coverPhotoUrl,
    this.missionStatement,
    this.scheduleInfo,
    this.contactInfo,
    this.leadershipInfo,
    required this.managerProfileId,
    required this.managerName,
    required this.state,
    required this.stateCode,
    required this.createdAt,
  });

  factory ProgramResponseDto.fromJson(Map<String, dynamic> json) {
    return ProgramResponseDto(
      uvaCode: json['uvaCode'] ?? '',
      name: json['name'] ?? '',
      description: json['description'],
      acronym: json['acronym'],
      color: json['color'],
      profilePhotoUrl: json['profilePhotoUrl'],
      coverPhotoUrl: json['coverPhotoUrl'],
      missionStatement: json['missionStatement'],
      scheduleInfo: json['scheduleInfo'],
      contactInfo: json['contactInfo'],
      leadershipInfo: json['leadershipInfo'],
      managerProfileId: json['managerProfileId'] ?? '',
      managerName: json['managerName'] ?? '',
      state: json['state'] ?? '',
      stateCode: json['stateCode'] ?? '',
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uvaCode': uvaCode,
      'name': name,
      'description': description,
      'acronym': acronym,
      'color': color,
      'profilePhotoUrl': profilePhotoUrl,
      'coverPhotoUrl': coverPhotoUrl,
      'managerProfileId': managerProfileId,
      'managerName': managerName,
      'state': state,
      'stateCode': stateCode,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
