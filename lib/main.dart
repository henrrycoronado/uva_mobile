import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await dotenv.load(fileName: ".env");

  runApp(const ProviderScope(child: UVoluntAppMovil()));
}

class UVoluntAppMovil extends ConsumerWidget {
  const UVoluntAppMovil({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'U-VoluntApp Movil',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const Scaffold(
        body: Center(
          child: Text('U-VoluntApp Móvil - Esqueleto Base'),
        ),
      ),
    );
  }
}
