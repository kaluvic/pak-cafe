import 'dart:convert';

OrderList orderListFromJson(String str) => OrderList.fromJson(json.decode(str));

String orderListToJson(OrderList data) => json.encode(data.toJson());

class OrderList {
    OrderList({
        required this.orderList,
    });

    List<OrderListElement> orderList;

    factory OrderList.fromJson(Map<String, dynamic> json) => OrderList(
        orderList: List<OrderListElement>.from(json["orderList"].map((x) => OrderListElement.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "orderList": List<dynamic>.from(orderList.map((x) => x.toJson())),
    };
}

class OrderListElement {
    OrderListElement({
        required this.orderId,
        required this.status,
        required this.time,
    });

    String orderId;
    int status;
    String time;

    factory OrderListElement.fromJson(Map<String, dynamic> json) => OrderListElement(
        orderId: json["orderId"],
        status: json["status"],
        time: json["time"],
    );

    Map<String, dynamic> toJson() => {
        "orderId": orderId,
        "status": status,
        "time": time,
    };
}
