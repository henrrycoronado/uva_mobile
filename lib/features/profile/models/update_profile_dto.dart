class UpdateProfileDto {
  final String? firstName;
  final String? lastName;
  final String? phone;
  final String? housingLocation;
  final String? careerCode;
  final double? personalGoalHours;

  UpdateProfileDto({
    this.firstName,
    this.lastName,
    this.phone,
    this.housingLocation,
    this.careerCode,
    this.personalGoalHours,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (firstName != null) {
      data['firstName'] = firstName;
    }
    if (lastName != null) {
      data['lastName'] = lastName;
    }
    if (phone != null) {
      data['phone'] = phone;
    }
    if (housingLocation != null) {
      data['housingLocation'] = housingLocation;
    }
    if (careerCode != null) {
      data['careerCode'] = careerCode;
    }
    if (personalGoalHours != null) {
      data['personalGoalHours'] = personalGoalHours;
    }
    return data;
  }
}
