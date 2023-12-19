import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:structured_logger/structured_logger.dart';

import 'package:structure_logs_sink_seq/src/constants.dart';

class SinkSeq extends LogSink {
  /// The Seq server URL to send logs to.
  final String seqUrl;

  /// The optional API key for the Seq server.
  final String? apiKey;

  /// Identifica o device que esta gerando os logs, util para agrupar no seq
  final String? deviceIdentifier;

  SinkSeq(
    this.seqUrl, {
    this.apiKey,
    this.deviceIdentifier,
  }) : assert(
          Uri.parse(seqUrl).isAbsolute,
          'The provided seqUrl is not a valid URL',
        );

  @override
  Future<void> write(LogModel event) {
    Map<String, dynamic> data = _createClefEvent(
      event.mt,
      event.level,
      event.t,
      event.data ?? <String, dynamic>{},
    );

    return _sendToSeq(data);
  }

  Map<String, dynamic> _createClefEvent(
    String messageTemplate,
    String level,
    String timestamp,
    Map<String, dynamic> properties,
  ) {
    return {
      '@t': timestamp,
      '@mt': messageTemplate,
      '@l': level,
      ...properties,
    };
  }

  Future<void> _sendToSeq(Map<String, dynamic> clefEvent) async {
    final body = json.encode(clefEvent);

    try {
      final headers = {'ContentType': CONTENT_TYPE_CLEF};
      if (apiKey != null) {
        headers[SEQ_API_KEY] = apiKey!;
      }

      final response = await http.post(
        Uri.parse('$seqUrl/api/events/raw?clef'),
        headers: headers,
        body: body,
      );

      if (response.statusCode < 200 || response.statusCode >= 202) {
        if (kDebugMode) {
          print('$ERROR_SEND_TO_SEQ ${response.body}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('$ERROR_SEND_TO_SEQ $e');
      }
    }
  }
}
