import 'package:bapp/model/barrage_model.dart';
import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/io.dart';

class BarrageSocket implements ISocket {
  static const String _url = 'wss://api.devio.org/uapi/fa/barrage/';

  IOWebSocketChannel? _channel;
  ValueChanged<List<BarrageModel>>? _callback;
  final int _intervalSeconds = 50;

  @override
  void close() {
    _channel?.sink.close();
  }

  @override
  ISocket listen(ValueChanged<List<BarrageModel>> callback) {
    _callback = callback;
    return this;
  }

  @override
  ISocket open(String vid) {
    _channel = IOWebSocketChannel.connect(
      _url + vid,
      headers: {'Authorization': 'Bearer 123456'},
      pingInterval: Duration(seconds: _intervalSeconds), // 心跳间隔
    );
    _channel?.stream.handleError((error) {
      print('connect error: $error');
    });
    _channel?.stream.listen((data) {
      print('listen: $data');
      _handleMessage(data);
    });
    return this;
  }

  @override
  ISocket send(String msg) {
    _channel?.sink.add(msg);
    return this;
  }

  /// 处理消息
  void _handleMessage(String data) {
    if (data.isEmpty) {
      return;
    }
    List<BarrageModel> list = BarrageModel.fromJsonString(data);
    if (list.isNotEmpty) {
      _callback?.call(list);
    }
  }
}

abstract class ISocket {
  /// 打开连接
  ISocket open(String vid);

  /// 发送消息
  ISocket send(String msg);

  /// 关闭连接
  void close();

  /// 监听消息
  ISocket listen(ValueChanged<List<BarrageModel>> callback);
}
