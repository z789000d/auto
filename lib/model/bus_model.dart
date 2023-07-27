class BusModel {
  int? code;
  String? msg;
  List<BusData>? data;

  BusModel({this.code, this.msg, this.data});

  BusModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = <BusData>[];
      json['data'].forEach((v) {
        data!.add(BusData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['code'] = this.code;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BusData {
  double? azimuth;
  BusPosition? busPosition;
  int? busStatus;
  String? city;
  int? direction;
  int? dutyStatus;
  String? gPSTime;
  String? operatorID;
  String? operatorNo;
  String? plateNumb;
  String? routeID;
  RouteName? routeName;
  String? routeUID;
  double? speed;
  String? srcUpdateTime;
  String? subRouteID;
  RouteName? subRouteName;
  String? subRouteUID;
  String? updateTime;

  BusData(
      {this.azimuth,
        this.busPosition,
        this.busStatus,
        this.city,
        this.direction,
        this.dutyStatus,
        this.gPSTime,
        this.operatorID,
        this.operatorNo,
        this.plateNumb,
        this.routeID,
        this.routeName,
        this.routeUID,
        this.speed,
        this.srcUpdateTime,
        this.subRouteID,
        this.subRouteName,
        this.subRouteUID,
        this.updateTime});

  BusData.fromJson(Map<String, dynamic> json) {
    azimuth = json['Azimuth'];
    busPosition = json['BusPosition'] != null
        ? BusPosition.fromJson(json['BusPosition'])
        : null;
    busStatus = json['BusStatus'];
    city = json['City'];
    direction = json['Direction'];
    dutyStatus = json['DutyStatus'];
    gPSTime = json['GPSTime'];
    operatorID = json['OperatorID'];
    operatorNo = json['OperatorNo'];
    plateNumb = json['PlateNumb'];
    routeID = json['RouteID'];
    routeName = json['RouteName'] != null
        ? RouteName.fromJson(json['RouteName'])
        : null;
    routeUID = json['RouteUID'];
    speed = json['Speed'];
    srcUpdateTime = json['SrcUpdateTime'];
    subRouteID = json['SubRouteID'];
    subRouteName = json['SubRouteName'] != null
        ? RouteName.fromJson(json['SubRouteName'])
        : null;
    subRouteUID = json['SubRouteUID'];
    updateTime = json['UpdateTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['Azimuth'] = azimuth;
    if (busPosition != null) {
      data['BusPosition'] = busPosition!.toJson();
    }
    data['BusStatus'] = busStatus;
    data['City'] = city;
    data['Direction'] = direction;
    data['DutyStatus'] = dutyStatus;
    data['GPSTime'] = gPSTime;
    data['OperatorID'] = operatorID;
    data['OperatorNo'] = operatorNo;
    data['PlateNumb'] = plateNumb;
    data['RouteID'] = routeID;
    if (this.routeName != null) {
      data['RouteName'] = this.routeName!.toJson();
    }
    data['RouteUID'] = this.routeUID;
    data['Speed'] = this.speed;
    data['SrcUpdateTime'] = this.srcUpdateTime;
    data['SubRouteID'] = this.subRouteID;
    if (this.subRouteName != null) {
      data['SubRouteName'] = this.subRouteName!.toJson();
    }
    data['SubRouteUID'] = this.subRouteUID;
    data['UpdateTime'] = this.updateTime;
    return data;
  }
}

class BusPosition {
  String? geoHash;
  double? positionLat;
  double? positionLon;

  BusPosition({this.geoHash, this.positionLat, this.positionLon});

  BusPosition.fromJson(Map<String, dynamic> json) {
    geoHash = json['GeoHash'];
    positionLat = json['PositionLat'];
    positionLon = json['PositionLon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['GeoHash'] = this.geoHash;
    data['PositionLat'] = this.positionLat;
    data['PositionLon'] = this.positionLon;
    return data;
  }
}

class RouteName {
  String? en;
  String? zhTw;

  RouteName({this.en, this.zhTw});

  RouteName.fromJson(Map<String, dynamic> json) {
    en = json['En'];
    zhTw = json['Zh_tw'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['En'] = this.en;
    data['Zh_tw'] = this.zhTw;
    return data;
  }
}