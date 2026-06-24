class OfflineNoProfileException implements Exception {
  final String message;
  const OfflineNoProfileException([
    this.message = 'No profile cache available while offline.',
  ]);

  @override
  String toString() => 'OfflineNoProfileException: $message';
}
