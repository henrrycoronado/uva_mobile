class CatalogItemDto {
  final String code;
  final String name;

  CatalogItemDto({required this.code, required this.name});

  factory CatalogItemDto.fromJson(Map<String, dynamic> json) {
    // Handling possible variations from the backend
    final code =
        json['uvaCode'] ??
        json['code'] ??
        json['typeCode'] ??
        json['stateCode'] ??
        '';
    final name = json['name'] ?? '';
    return CatalogItemDto(code: code, name: name);
  }
}
