import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/contact_model.dart';

part 'portfolio_contact_view_model.g.dart';

@riverpod
class PortfolioContactViewModel extends _$PortfolioContactViewModel {
  @override
  ContactModel build() {
    // In the future this could fetch from a repo if it's dynamic
    return const ContactModel(
      email: 'soporte@uvoluntapp.com', // Will be overridden or used as default
      phone: '+123456789',
    );
  }

  Future<void> copyToClipboard(String text) async {
    await Clipboard.setData(ClipboardData(text: text));
  }

  Future<bool> sendEmail(String email, EmailTemplateModel template) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
      query: template.toQueryString(),
    );

    if (await canLaunchUrl(emailLaunchUri)) {
      return await launchUrl(emailLaunchUri);
    }
    return false;
  }

  Future<bool> callPhone(String phone) async {
    final Uri phoneLaunchUri = Uri(scheme: 'tel', path: phone);

    if (await canLaunchUrl(phoneLaunchUri)) {
      return await launchUrl(phoneLaunchUri);
    }
    return false;
  }
}
