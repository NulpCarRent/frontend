class Car {
    int id;
    String name;
    int releaseYear;
    int price;
    int renter;
    String imageLink;
    bool available;

   Car({
        this.id,
        this.name,
        this.releaseYear,
        this.price,
        this.renter,
        this.imageLink,
        this.available
    });

    factory Car.fromJson(Map<String, dynamic> json) => Car(
        id: (json["id"]),
        name: json["name"],
        releaseYear: (json["release_year"]),
        price: (json["price"]),
        renter: json["renter"] ??  0,
        imageLink: json["picture"],
        available: json["available"]
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "release_year": releaseYear,
        "price": price,
        "renter": renter,
        "picture": imageLink,
        "available": available
    };
}