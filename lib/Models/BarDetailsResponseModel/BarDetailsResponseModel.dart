class BarDetailsResponseModel {
  bool? success;
  String? message;
  Data? data;

  BarDetailsResponseModel({this.success, this.message, this.data});

  BarDetailsResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  BarDetails? barDetails;
  Review? review;
  Reservation? reservation;
  ExpressReservation? expressReservation;
  List<BarEvents>? barEvents;

  Data(
      {this.barDetails,
        this.review,
        this.reservation,
        this.expressReservation,
        this.barEvents});

  Data.fromJson(Map<String, dynamic> json) {
    barDetails = json['bar_details'] != null
        ? new BarDetails.fromJson(json['bar_details'])
        : null;
    review =
    json['review'] != null ? new Review.fromJson(json['review']) : null;
    reservation = json['reservation'] != null
        ? new Reservation.fromJson(json['reservation'])
        : null;
    expressReservation = json['express_reservation'] != null
        ? new ExpressReservation.fromJson(json['express_reservation'])
        : null;
    if (json['bar_events'] != null) {
      barEvents = <BarEvents>[];
      json['bar_events'].forEach((v) {
        barEvents!.add(new BarEvents.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.barDetails != null) {
      data['bar_details'] = this.barDetails!.toJson();
    }
    if (this.review != null) {
      data['review'] = this.review!.toJson();
    }
    if (this.reservation != null) {
      data['reservation'] = this.reservation!.toJson();
    }
    if (this.expressReservation != null) {
      data['express_reservation'] = this.expressReservation!.toJson();
    }
    if (this.barEvents != null) {
      data['bar_events'] = this.barEvents!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BarDetails {
  int? id;
  String? barOwnerId;
  String? venue;
  List<String>? barInfo;
  String? aboutUs;
  String? address;
  String? startTime;
  String? endTime;
  bool? havePromotion;
  bool? isLiked;
  String? coverImage;

  BarDetails(
      {this.id,
        this.barOwnerId,
        this.venue,
        this.barInfo,
        this.aboutUs,
        this.address,
        this.startTime,
        this.endTime,
        this.havePromotion,
        this.isLiked,
        this.coverImage});

  BarDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    barOwnerId = json['bar_owner_id'];
    venue = json['venue'];
    barInfo = json['bar_info'].cast<String>();
    aboutUs = json['about_us'];
    address = json['address'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    havePromotion = json['have_promotion'];
    isLiked = json['is_liked'];
    coverImage = json['cover_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['bar_owner_id'] = this.barOwnerId;
    data['venue'] = this.venue;
    data['bar_info'] = this.barInfo;
    data['about_us'] = this.aboutUs;
    data['address'] = this.address;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['have_promotion'] = this.havePromotion;
    data['is_liked'] = this.isLiked;
    data['cover_image'] = this.coverImage;
    return data;
  }
}

class Review {
  int? id;
  String? userId;
  String? barId;
  String? rating;

  Review({this.id, this.userId, this.barId, this.rating});

  Review.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    barId = json['bar_id'];
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['bar_id'] = this.barId;
    data['rating'] = this.rating;
    return data;
  }
}

class Reservation {
  List<Peak>? peak;
  List<NonPeak>? nonPeak;

  Reservation({this.peak, this.nonPeak});

  Reservation.fromJson(Map<String, dynamic> json) {
    if (json['peak'] != null) {
      peak = <Peak>[];
      json['peak'].forEach((v) {
        peak!.add(new Peak.fromJson(v));
      });
    }
    if (json['non_peak'] != null) {
      nonPeak = <NonPeak>[];
      json['non_peak'].forEach((v) {
        nonPeak!.add(new NonPeak.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.peak != null) {
      data['peak'] = this.peak!.map((v) => v.toJson()).toList();
    }
    if (this.nonPeak != null) {
      data['non_peak'] = this.nonPeak!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Peak {
  int? id;
  String? reservationId;
  String? reservationType;
  String? day;
  String? time;
  String? noOfPersons;
  String? price;
  String? createdAt;
  String? updatedAt;
  String? status;

  Peak(
      {this.id,
        this.reservationId,
        this.reservationType,
        this.day,
        this.time,
        this.noOfPersons,
        this.price,
        this.createdAt,
        this.updatedAt,
        this.status});

  Peak.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    reservationId = json['reservation_id'];
    reservationType = json['reservation_type'];
    day = json['day'];
    time = json['time'];
    noOfPersons = json['no_of_persons'];
    price = json['price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['reservation_id'] = this.reservationId;
    data['reservation_type'] = this.reservationType;
    data['day'] = this.day;
    data['time'] = this.time;
    data['no_of_persons'] = this.noOfPersons;
    data['price'] = this.price;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['status'] = this.status;
    return data;
  }
}
class NonPeak {
  int? id;
  String? reservationId;
  String? reservationType;
  String? day;
  String? time;
  String? noOfPersons;
  String? price;
  String? createdAt;
  String? updatedAt;
  String? status;

  NonPeak(
      {this.id,
        this.reservationId,
        this.reservationType,
        this.day,
        this.time,
        this.noOfPersons,
        this.price,
        this.createdAt,
        this.updatedAt,
        this.status});

  NonPeak.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    reservationId = json['reservation_id'];
    reservationType = json['reservation_type'];
    day = json['day'];
    time = json['time'];
    noOfPersons = json['no_of_persons'];
    price = json['price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['reservation_id'] = this.reservationId;
    data['reservation_type'] = this.reservationType;
    data['day'] = this.day;
    data['time'] = this.time;
    data['no_of_persons'] = this.noOfPersons;
    data['price'] = this.price;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['status'] = this.status;
    return data;
  }
}

class ExpressReservation {
  int? id;
  String? barOwnerId;
  String? barId;
  String? price;
  String? status;
  String? availability;
  String? createdAt;
  String? updatedAt;

  ExpressReservation(
      {this.id,
        this.barOwnerId,
        this.barId,
        this.price,
        this.status,
        this.availability,
        this.createdAt,
        this.updatedAt});

  ExpressReservation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    barOwnerId = json['bar_owner_id'];
    barId = json['bar_id'];
    price = json['price'];
    status = json['status'];
    availability = json['availability'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['bar_owner_id'] = this.barOwnerId;
    data['bar_id'] = this.barId;
    data['price'] = this.price;
    data['status'] = this.status;
    data['availability'] = this.availability;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class BarEvents {
  int? id;
  String? barOwnerId;
  String? barId;
  String? title;
  String? date;
  String? startTime;
  String? endTime;
  String? about;
  String? price;
  List<String>? images;
  String? numberOfTickets;
  bool? status;
  String? createdAt;
  String? updatedAt;

  BarEvents(
      {this.id,
        this.barOwnerId,
        this.barId,
        this.title,
        this.date,
        this.startTime,
        this.endTime,
        this.about,
        this.price,
        this.images,
        this.numberOfTickets,
        this.status,
        this.createdAt,
        this.updatedAt});

  BarEvents.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    barOwnerId = json['bar_owner_id'];
    barId = json['bar_id'];
    title = json['title'];
    date = json['date'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    about = json['about'];
    price = json['price'];
    images = json['images'].cast<String>();
    numberOfTickets = json['number_of_tickets'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['bar_owner_id'] = this.barOwnerId;
    data['bar_id'] = this.barId;
    data['title'] = this.title;
    data['date'] = this.date;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['about'] = this.about;
    data['price'] = this.price;
    data['images'] = this.images;
    data['number_of_tickets'] = this.numberOfTickets;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
