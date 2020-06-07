class Car {
    int id;
    String name;
    int releaseYear;
    int price;
    int renter;

   Car({
        this.id,
        this.name,
        this.releaseYear,
        this.price,
        this.renter
    });

    factory Car.fromJson(Map<String, dynamic> json) => Car(
        id: (json["id"]),
        name: json["name"],
        releaseYear: (json["release_year"]),
        price: (json["price"]),
        renter: json["renter"] ??  0,

        // TODO: add image link
        // imageLink: json["image_link"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "release_year": releaseYear,
        "price": price,
        "renter": renter
        // TODO: add image link
        // "image_link": imageLink,
    };
}