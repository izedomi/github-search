

class User{

    int id;
    String name;
    String email;
    String phoneNo;
    String dob;
    String address;
    String city;
    String state;
    String gender;
    String imagePath;
  
  User({
    this.id, 
    this.name,
    this.email, 
    this.phoneNo, 
    this.dob, 
    this.address,
    this.city,
    this.state,
    this.gender,
    this.imagePath,

  });

  factory User.createUser(Map<String, dynamic> json){
      return User(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        phoneNo: json['phone_no'],
        dob: json["dob"],
        address: json["address"],
        city: json["city"],
        state: json["gender"],
        gender: json["gender"],
        imagePath: json["image_path"],
      );   
  }

}