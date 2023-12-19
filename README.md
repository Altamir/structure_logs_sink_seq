# structure_logs_sink_seq

**structure_logs_sink_seq** is a Flutter package that provides a Sink implementation for sending structured logs to Seq Log. This allows you to seamlessly integrate logging into your Flutter applications and send logs to Seq for centralized monitoring.

## Installation

Add the following to your `pubspec.yaml` file:

```yaml
dependencies:
  structure_logs_sink_seq: ^current_version
```

## Usage

1. Import the package into your Dart file:

```dart
import 'package:structure_logs_sink_seq/structure_logs_sink_seq.dart';
```

2. Create an instance of the logger:

```dart
final logger = StructureLogger();
```

3. Add the Seq Sink, providing the Seq server URL and optional API key:

```dart
LogSink sink = SinkSeq(
  'https://your-seq-server-url',
  apiKey: 'your-api-key', // Optional, if your Seq server requires an API key
);
logger.addSink(sink);
```

4. Register logs using the `log` method:

```dart
await logger.log(
  "Welcome {name}, your level is {level}",
  level: LogLevel.debug,
  data: {"name": "John Doe", "level": 12},
);
```

Adjust the Seq server URL and API key according to your Seq configuration.

## Contributing

Contributions are welcome! Feel free to open issues or submit pull requests.

## License

This package is distributed under the [LICENSE](LICENSE).
