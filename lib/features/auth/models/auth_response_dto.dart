class AuthResponseDto {
  final String? token;
  final DateTime? accessTokenExpiresAtUtc;
  final String? refreshToken;
  final String? uvaCode;
  final String? email;
  final String? firstName;
  final String? lastName;

  AuthResponseDto({
    this.token,
    this.accessTokenExpiresAtUtc,
    this.refreshToken,
    this.uvaCode,
    this.email,
    this.firstName,
    this.lastName,
  });

  factory AuthResponseDto.fromJson(Map<String, dynamic> json) {
    return AuthResponseDto(
      token: json['token'] as String?,
      accessTokenExpiresAtUtc: json['accessTokenExpiresAtUtc'] != null
          ? DateTime.tryParse(json['accessTokenExpiresAtUtc'] as String)
          : null,
      refreshToken: json['refreshToken'] as String?,
      uvaCode: json['uvaCode'] as String?,
      email: json['email'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
    );
  }
}
