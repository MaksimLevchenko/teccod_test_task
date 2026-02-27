import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:teccod_test_task/core/config/app_config.dart';
import 'package:teccod_test_task/core/network/error_parser.dart';
import 'package:teccod_test_task/core/network/http_api_client.dart';
import 'package:teccod_test_task/features/order_creation/data/datasources/order_remote_data_source.dart';
import 'package:teccod_test_task/features/order_creation/data/datasources/order_remote_data_source_impl.dart';
import 'package:teccod_test_task/features/order_creation/data/repositories/order_repository_impl.dart';
import 'package:teccod_test_task/features/order_creation/domain/repositories/order_repository.dart';
import 'package:teccod_test_task/features/order_creation/domain/usecases/create_order_usecase.dart';

class OrderCreationProviders {
  const OrderCreationProviders._();

  static List<RepositoryProvider<dynamic>> get repositoryProviders {
    return <RepositoryProvider<dynamic>>[
      RepositoryProvider<HttpApiClient>(
        create: (BuildContext context) {
          return HttpApiClient(
            client: context.read<http.Client>(),
            appConfig: context.read<AppConfig>(),
          );
        },
      ),
      RepositoryProvider<ErrorParser>(
        create: (BuildContext context) {
          return const ErrorParser();
        },
      ),
      RepositoryProvider<OrderRemoteDataSource>(
        create: (BuildContext context) {
          return OrderRemoteDataSourceImpl(
            httpApiClient: context.read<HttpApiClient>(),
            errorParser: context.read<ErrorParser>(),
          );
        },
      ),
      RepositoryProvider<OrderRepository>(
        create: (BuildContext context) {
          return OrderRepositoryImpl(
            orderRemoteDataSource: context.read<OrderRemoteDataSource>(),
          );
        },
      ),
      RepositoryProvider<CreateOrderUseCase>(
        create: (BuildContext context) {
          return CreateOrderUseCase(
            orderRepository: context.read<OrderRepository>(),
          );
        },
      ),
    ];
  }
}
