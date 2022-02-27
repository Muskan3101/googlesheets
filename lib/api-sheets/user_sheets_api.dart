import 'package:googlesheets/models/user.dart';
import 'package:gsheets/gsheets.dart';

class UserSheetsApi {
  static const _credentials = r'''
  {
  "type": "service_account",
  "project_id": "friendly-basis-342404",
  "private_key_id": "00ff403c185a034dcb4fda9a7e46bf973a50023f",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQC0f/Om/r5ZxhzV\nLqzgP3D9Wq8hJ1Ncm72md01M0ncA1SWlLS6Vbs+vB2EraH6rQRvG3Pu/dprNaDVE\nfY/M2mlcBRY+77LTjpNRIRSeKZwY6sIMtkEi+l40VHbYSaukNWbbOqJnRxP0LB8n\nfICvPhNAGDU8n7iaDWsXuX9isREnJoiZHM46l7qlowbyeLb4ZStsiNtJ+l/RBMY7\n3qneahrIjjzzcE66qIvme6b+z8auE4PIoWx6ApUu4FvxKouJBMmAcVmHYLHMr7dl\na9xEInlxEwxddF58/jAMhOtzJ/aRR/Ln6+26N/n6Jv3ww+EogWI8s30tZDXwhGiK\nKaRYC7CFAgMBAAECggEAJrwOnZetYbaSGW2ay8TRio0baBH4YbdKS57uh73iq9sR\n6RB5HrhY+UasI5SZGkcuns5td/kL32ithbUsVtnIImc1DuyBg8Tk+FQRCKAFT5OR\ncQjrkYYJEVHO7ztgCi0rlYBPuboXHh8Z0G93biP0HZ0UT543D1gx0zWLkLJO7AeM\nWufilsGl8Ve7a0GEu/NoFxKh+IONqyEUdu56TlK2Ox4rCjvfjEJk0NFCvd6qi5S1\nx1Q3AoiHYpJdzW3aG0zZKUnonqCsKXwxATssTZ1kq8R+FkQh38xG1cJF4701x2mH\nE6Wwp/OLi39vHQv/lCiiQ+qv5vso92l0fYWtGiEYAQKBgQDozdGGamh6Xr8G16So\nKOXceTw75fjvY0GYc1eUtvb4qNWBF6f6WX3/JUtuEofv7LH5OAM9QMbDsDFfmkJO\np/Vpr11bEZf5So2U/OqILACo0Sy3dWMUSCgUEZ8CAfnGJ7sy+TCRSCyCu1KtZml8\nDUUzk6yVac/L0CSb4eD7UChDZQKBgQDGe//lG4njBpGjb6KMFv6BugVlOyGnf0J1\nSFQX1V/UHHAaW81k1QteGQhB950E4EQZ7VdxgOMZz8MTD1datdR2a/ZAtRrx/S0C\ntcDdG73gxG3ewip6xZ3He8Brzuc+mVNnJ9+wEwYo61W5KOBtQhychUKKPt05u9ox\n4cOpU1o2oQKBgCHJFNpEAQuZSnHMw9mfrdQ0R/iNZHYhWnisbI5piygFII8OhtM/\nP5jSqcK8r7uzBxUa+uVdzDrEDDZKpcrSdzwyNgMsZ3jHSArSNZszf5kAWlP5ljpw\nSli3QfNBpCUMyQ8ZuOGsrsD+PH5ruW1GY7+bc9VvOLfkahuxSTxPorg9AoGAKna6\n74QtwtFT9Thb+UauGoj2wIqfD5utVzQrMZIn11RiM3FyhuEBdpc6agqUoEduqnFZ\npOHjNFF7tacxlCmUk+VTINLeOellaNADvApEXEMKEn9N4UhIEjaKm0X/uSfKbSZd\nt+jKB5UZmOyC3z0mq+His3rxj3l+G+/mEWLQySECgYEAhFYbkc15j3FCtPtX1qWm\nfJl7XPPhyPC533Kx2We8hf+1emnGLIisY5WKkc9Eiq+JT5Wu4kU5+HkeNuuAPezD\nROUOaMkmoOnrBmWy33si+IZPaYTTPseqLWXNhuTJUQamKcluT1QshhdS1dVuhzG4\nw2hOwnpGg96ihSjqtaWHBBY=\n-----END PRIVATE KEY-----\n",
  "client_email": "googlesheets@friendly-basis-342404.iam.gserviceaccount.com",
  "client_id": "109432113896053308350",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/googlesheets%40friendly-basis-342404.iam.gserviceaccount.com"
}
  ''';
  static const _spreadSheetId = '12gxziFNXmbL3nr3zVZ9vyMG7GVfXmU3iFhRgUkIOvjs';
  static final _gsheets = GSheets(_credentials);
  static Worksheet? _userSheet;

  //initializing method
  static Future init() async {
    try {
      final spreadsheet = await _gsheets.spreadsheet(_spreadSheetId);
      _userSheet = await _getWorkSheet(spreadsheet, title: 'Sheet1');

      final firstRow = UserFields.getFields();
      _userSheet!.values.insertRow(1, firstRow);
    } catch (e) {
      print('init Error: $e');
    }
  }

  static Future<Worksheet?> _getWorkSheet(
    Spreadsheet spreadsheet, {
    required String title,
  }) async {
    try {
      return await spreadsheet.addWorksheet(title);
    } catch (e) {
      return spreadsheet.worksheetByTitle(title);
    }
  }

  static Future<int> getRowCount() async {
    if (_userSheet == null) return 0;
    final lastRow = await _userSheet!.values.lastRow();
    return lastRow == null ? 0 : int.tryParse(lastRow.first) ?? 0;
  }

  static Future<List<User>> getAll() async {
    if (_userSheet == null) return <User>[];
    final users = await _userSheet!.values.map.allRows();
    return users == null ? <User>[] : users.map(User.fromJson).toList();
  }

  static Future<User?> getById(int id) async {
    if (_userSheet == null) return null;
    final json = await _userSheet!.values.map.rowByKey(id, fromColumn: 1);
    return json == null ? null : User.fromJson(json);
  }

  static Future insert(List<Map<String, dynamic>> rowList) async {
    _userSheet!.values.map.appendRows(rowList);
  }

  static Future<bool> update(
    int id,
    Map<String, dynamic> user,
  ) async {
    if (_userSheet == null) return false;
    return _userSheet!.values.map.insertRowByKey(id, user);
  }

  static Future<bool> updateCell({
    required int id,
    required String key,
    required dynamic value,
  }) async {
    if (_userSheet == null) return false;
    return _userSheet!.values
        .insertValueByKeys(value, columnKey: key, rowKey: id);
  }
  static Future<bool> deleteById(int id) async{
    if(_userSheet == null) return false;
    final index = await _userSheet!.values.rowIndexOf(id);
    if(index == -1) return false;
    return _userSheet!.deleteRow(index);
  }
}
