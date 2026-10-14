abstract class DatabaseTransaction {
  Future<Map<String, dynamic>?> get({
    required String path,
    required String docId,
  });

  void set({
    required String path,
    required String docId,
    required Map<String, dynamic> data,
    bool merge = false,
  });
}