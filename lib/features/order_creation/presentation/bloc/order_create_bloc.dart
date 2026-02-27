import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teccod_test_task/core/network/api_exception.dart';
import 'package:teccod_test_task/core/network/network_exceptions.dart';
import 'package:teccod_test_task/features/order_creation/domain/entities/order.dart';
import 'package:teccod_test_task/features/order_creation/domain/usecases/create_order_usecase.dart';
import 'package:teccod_test_task/features/order_creation/presentation/bloc/order_create_error.dart';
import 'package:teccod_test_task/features/order_creation/presentation/bloc/order_create_event.dart';
import 'package:teccod_test_task/features/order_creation/presentation/bloc/order_create_initial.dart';
import 'package:teccod_test_task/features/order_creation/presentation/bloc/order_create_loading.dart';
import 'package:teccod_test_task/features/order_creation/presentation/bloc/order_create_retried.dart';
import 'package:teccod_test_task/features/order_creation/presentation/bloc/order_create_state.dart';
import 'package:teccod_test_task/features/order_creation/presentation/bloc/order_create_submitted.dart';
import 'package:teccod_test_task/features/order_creation/presentation/bloc/order_create_success.dart';

class OrderCreateBloc extends Bloc<OrderCreateEvent, OrderCreateState> {
  final CreateOrderUseCase _createOrderUseCase;

  OrderCreateBloc({required CreateOrderUseCase createOrderUseCase})
      : _createOrderUseCase = createOrderUseCase,
        super(const OrderCreateInitial()) {
    on<OrderCreateSubmitted>(_onOrderCreateSubmitted);
    on<OrderCreateRetried>(_onOrderCreateRetried);
  }

  Future<void> _onOrderCreateSubmitted(
    OrderCreateSubmitted event,
    Emitter<OrderCreateState> emit,
  ) async {
    await _performCreateOrder(
      userId: event.userId,
      serviceId: event.serviceId,
      emit: emit,
    );
  }

  Future<void> _onOrderCreateRetried(
    OrderCreateRetried event,
    Emitter<OrderCreateState> emit,
  ) async {
    await _performCreateOrder(
      userId: event.userId,
      serviceId: event.serviceId,
      emit: emit,
    );
  }

  Future<void> _performCreateOrder({
    required int userId,
    required int serviceId,
    required Emitter<OrderCreateState> emit,
  }) async {
    emit(const OrderCreateLoading());
    try {
      final Order order = await _createOrderUseCase(userId, serviceId);
      emit(OrderCreateSuccess(order: order));
    } on ApiException catch (error) {
      emit(OrderCreateError(errorMessage: error.message));
    } catch (_) {
      emit(
        const OrderCreateError(
          errorMessage: NetworkExceptionMessages.createOrderFailed,
        ),
      );
    }
  }
}
