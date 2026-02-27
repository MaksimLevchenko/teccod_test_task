import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:teccod_test_task/core/config/app_config.dart';
import 'package:teccod_test_task/features/order_creation/presentation/di/order_creation_providers.dart';
import 'package:teccod_test_task/features/order_creation/presentation/screens/create_order_screen.dart';

void main() {
  runApp(const OrderCreationApp());
}

class OrderCreationApp extends StatefulWidget {
  const OrderCreationApp({super.key});

  @override
  State<OrderCreationApp> createState() => _OrderCreationAppState();
}

class _OrderCreationAppState extends State<OrderCreationApp> {
  late final http.Client _httpClient;

  @override
  void initState() {
    super.initState();
    _httpClient = http.Client();
  }

  @override
  void dispose() {
    _httpClient.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AppConfig appConfig = AppConfig.fromEnvironment();
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AppConfig>.value(value: appConfig),
        RepositoryProvider<http.Client>.value(value: _httpClient),
        ...OrderCreationProviders.repositoryProviders,
      ],
      child: const MaterialApp(
        title: 'Order Creation',
        home: CreateOrderScreen(userId: 1, serviceId: 2),
      ),
    );
  }
}
