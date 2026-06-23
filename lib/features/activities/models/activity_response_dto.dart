class ActivityResponseDto {
  final String uvaCode;
  final String programCode;
  final String programName;
  final String name;
  final String? description;
  final String? photoUrl;
  final DateTime startDate;
  final DateTime endDate;
  final String state;
  final String stateCode;

  ActivityResponseDto({
    required this.uvaCode,
    required this.programCode,
    required this.programName,
    required this.name,
    this.description,
    this.photoUrl,
    required this.startDate,
    required this.endDate,
    required this.state,
    required this.stateCode,
  });

  factory ActivityResponseDto.fromJson(Map<String, dynamic> json) {
    return ActivityResponseDto(
      uvaCode: json['uvaCode'] as String,
      programCode: json['programCode'] as String,
      programName: json['programName'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      photoUrl: json['photoUrl'] as String?,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      state: json['state'] as String,
      stateCode: json['stateCode'] as String,
    );
  }
}
