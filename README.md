# teccod_test_task

Небольшой Flutter-проект для создания заказа через REST API.

## Что реализовано

- POST запрос на `/api/orders`
- Передача `userId` и `serviceId`
- Обработка `200`, `400+`, timeout (10 сек), отсутствия интернета
- Кастомное исключение `ApiException`
- Экран с состояниями `initial`, `loading`, `success`, `error`
- Повторная отправка после ошибки

## Быстрый запуск

```bash
flutter pub get
flutter run --dart-define=BASE_URL=https://your-api.com
```

Если `BASE_URL` не передан, используется значение по умолчанию из `AppConfig`.

## Архитектура

- `lib/core`
  - `config/app_config.dart` — базовый URL
  - `network/*` — HTTP клиент, парсинг ошибок, `ApiException`
- `lib/features/order_creation`
  - `data` — datasource + repository impl
  - `domain` — `Order`, repository contract, usecase
  - `presentation` — `OrderController` + `CreateOrderScreen`

## Основной экран

`CreateOrderScreen(userId: 1, serviceId: 2)` запускается из `main.dart`.

Экран:

- показывает кнопку `Создать заказ`
- блокирует кнопку во время запроса
- показывает `CircularProgressIndicator` при загрузке
- выводит текст ошибки при неуспехе
- при успехе показывает `orderId`, `status`, `paymentUrl` (`нет ссылки`, если `null`)
