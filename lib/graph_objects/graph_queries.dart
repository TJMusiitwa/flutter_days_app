const String getBreakfastMenu = """
    query getBreakfastMenu {
      Breakfast {
        id
        name
        description
        price
        image
  }
}  
    """;

const String getDrinks = """
query getDrinks {
  Drinks {
    id
    name
    description
    price
    image
  }
}
  """;

const String getLocationsList = """
query getLocationsList {
  Cafe_Locations(order_by: {location_name: asc}) {
    location_id
    location_name
    location_latitude
    location_longitude
    location_image
    location_contact1
    location_contact2
  }
}""";

const String getCafeLocations = """
  query getCafeLocations {
  Cafe_Locations(order_by: {location_name: asc}) {
    location_name
    location_contact1
    location_contact2
    location_image
  }
}
""";
const String getMainMeals = """
  query getMainMeals {
  Meals {
    id
    name
    description
    price
    image
  }
}
  """;

const String getDessertsMenu = """
  query myDesserts {
  Desserts {
    id
    name
    description
    price
    image
  }
}
  """;
