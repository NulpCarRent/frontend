class Request {
    int id;
    DateTime rentDate;
    DateTime dueDate;
    int renter;
    int car;

   Request({
        this.id,
        this.rentDate,
        this.dueDate,
        this.renter,
        this.car,
    });

    factory Request.fromJson(Map<String, dynamic> json) => Request(
        id: (json["id"]),
        rentDate: json["rent_date"],
        dueDate: (json["due_date"]),
        renter: (json["renter"]),
        car: json["auto"] ??  0
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "rent_date": rentDate,
        "due_date": dueDate,
        "renter": renter,
        "auto": car
    };
}