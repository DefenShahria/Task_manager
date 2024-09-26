class Networkresponse{
  final int statusCode;
  final bool issuccess;
  final Map<String, dynamic>? responseJson;

  Networkresponse(this.issuccess,this.statusCode, this.responseJson);
}