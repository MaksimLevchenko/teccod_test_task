class AppConfig {
  final String baseUrl;

  const AppConfig({required this.baseUrl});

  factory AppConfig.fromEnvironment() {
    const String baseUrl =
        String.fromEnvironment('BASE_URL', defaultValue: 'https://example.com');
    return const AppConfig(baseUrl: baseUrl);
  }
}
