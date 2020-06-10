class Request {
    int id;
    String rentDate;
    String dueDate;
    int renter;
    int car;
    int firstPayment;

   Request({
        this.id,
        this.rentDate,
        this.dueDate,
        this.renter,
        this.car,
        this.firstPayment
    });

    factory Request.fromJson(Map<String, dynamic> json) => Request(
        id: (json["id"]),
        rentDate: json["rent_date"],
        dueDate: (json["due_date"]),
        renter: (json["renter"]),
        car: json["auto"] ??  0,
        firstPayment: json["first_payment"]
    );

    Map<String, dynamic> toJson() => {
        "rent_date": rentDate,
        "due_date": dueDate,
        "renter": renter,
        "auto": car,
        "first_payment": firstPayment
    };
}