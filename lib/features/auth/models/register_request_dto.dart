class RegisterRequestDto {
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final String? phone;
  final String? careerCode;

  RegisterRequestDto({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    this.phone,
    this.careerCode,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'email': email,
      'password': password,
      'firstName': firstName,
      'lastName': lastName,
    };
    if (phone != null) data['phone'] = phone;
    if (careerCode != null) data['careerCode'] = careerCode;
    return data;
  }
}
