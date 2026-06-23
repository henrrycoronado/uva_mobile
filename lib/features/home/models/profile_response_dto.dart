class ProfileResponseDto {
  final String uvaCode;
  final String firstName;
  final String lastName;
  final String email;
  final String? photoUrl;
  final String? phone;
  final String? housingLocation;
  final String? careerCode;
  final String? careerName;
  final double personalGoalHours;
  final String stateCode;

  ProfileResponseDto({
    required this.uvaCode,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.photoUrl,
    this.phone,
    this.housingLocation,
    this.careerCode,
    this.careerName,
    required this.personalGoalHours,
    required this.stateCode,
  });

  factory ProfileResponseDto.fromJson(Map<String, dynamic> json) {
    return ProfileResponseDto(
      uvaCode: json['uvaCode'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      email: json['email'] ?? '',
      photoUrl: json['photoUrl'],
      phone: json['phone'],
      housingLocation: json['housingLocation'],
      careerCode: json['careerCode'],
      careerName: json['careerName'],
      personalGoalHours: (json['personalGoalHours'] as num?)?.toDouble() ?? 0.0,
      stateCode: json['stateCode'] ?? '',
    );
  }
}
