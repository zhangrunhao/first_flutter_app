
// 分块传输整体流程

// 通过第一个分块检测服务器是否支持分块传输
import 'package:dio/dio.dart';

Future downloadWithChunks(
  url,
  savePath,
  {
    ProgressCallback onReceiveProgress,
  }
) async {
  /**
   * start: 当前块的起始位置, end: 结束位置
   * no: 代表当前第几块
   */
  Future<Response> downloadChunks (url, start, end, no) {

  }

  // // 通过第一个分块检测服务器是否支持分块传输
  // Response response = await downloadChunks(url, 0, firstChunkSize, 0) {

  // }
}
