class ContactModel {
  final String email;
  final String phone;

  const ContactModel({required this.email, required this.phone});
}

class EmailTemplateModel {
  final String subject;
  final String body;

  const EmailTemplateModel({required this.subject, required this.body});

  /// Constructs a URL encoding map for the query string
  String toQueryString() {
    return 'subject=${Uri.encodeComponent(subject)}&body=${Uri.encodeComponent(body)}';
  }
}
