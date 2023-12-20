import 'package:flutter_test/flutter_test.dart';
import 'package:structure_logs_sink_seq/structure_logs_sink_seq.dart';
import 'package:structured_logger/structured_logger.dart';

void main() {
  test('Cria log e envia para server local', () async {
    final logger = StructureLogger();
    LogSink sink = SinkSeq('https://5kc902xw-5341.brs.devtunnels.ms',
        apiKey: 'WIuUi1x2qzhdybcPoxT4',
        deviceIdentifier: 'device-identifier-test');
    logger.addSink(sink);

    await logger.log(
      "Seja bem vindo {name}, seu nível é {level}",
      level: LogLevel.debug,
      data: {"name": "John Doe", "level": 12},
    );
  });
}
