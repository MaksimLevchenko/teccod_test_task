import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teccod_test_task/features/order_creation/domain/usecases/create_order_usecase.dart';
import 'package:teccod_test_task/features/order_creation/presentation/controller/order_controller.dart';
import 'package:teccod_test_task/features/order_creation/presentation/controller/order_controller_state.dart';

class CreateOrderScreen extends StatefulWidget {
  final int userId;
  final int serviceId;

  const CreateOrderScreen({
    super.key,
    required this.userId,
    required this.serviceId,
  });

  @override
  State<CreateOrderScreen> createState() => _CreateOrderScreenState();
}

class _CreateOrderScreenState extends State<CreateOrderScreen> {
  late final OrderController _orderController;

  @override
  void initState() {
    super.initState();
    _orderController = OrderController(
      createOrderUseCase: context.read<CreateOrderUseCase>(),
    );
  }

  @override
  void dispose() {
    _orderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _orderController,
      builder: (BuildContext context, Widget? child) {
        final bool isLoading =
            _orderController.state == OrderControllerState.loading;
        final bool isError = _orderController.state == OrderControllerState.error;
        final bool isSuccess =
            _orderController.state == OrderControllerState.success;
        final String paymentUrlText =
            _orderController.order?.paymentUrl ?? 'нет ссылки';

        return Scaffold(
          appBar: AppBar(
            title: const Text('Создание заказа'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        if (_orderController.state ==
                            OrderControllerState.initial)
                          const Text('Нажмите кнопку, чтобы создать заказ.'),
                        if (isLoading) const CircularProgressIndicator(),
                        if (isError)
                          Text(
                            _orderController.errorMessage ??
                                'Не удалось создать заказ.',
                            textAlign: TextAlign.center,
                          ),
                        if (isSuccess && _orderController.order != null)
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text('orderId: ${_orderController.order!.orderId}'),
                              Text('status: ${_orderController.order!.status}'),
                              Text('paymentUrl: $paymentUrlText'),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: isLoading
                      ? null
                      : () {
                          _orderController.submitOrder(
                            widget.userId,
                            widget.serviceId,
                          );
                        },
                  child: const Text('Создать заказ'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
