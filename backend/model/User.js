const mongoose = require("mongoose");
const { isEmail } = require("validator");
const bcrypt = require("bcrypt");

// Vehicle schema
const vehicleSchema = new mongoose.Schema({
  name: {
    type: String,
  },
  vehicleNamePlate: {
    type: String,
    required: true,
  },
  wheels: {
    type: Number,
    required: true,
  },
});

const userSchema = new mongoose.Schema({
  email: {
    type: String,
    required: [true, "Please enter an email"],
    unique: true, // for this use code
    lowercase: true,
    validate: [isEmail, "Please enter a valid email"],
  },
  password: {
    type: String,
    required: [true, "Please enter an password"],
    minlength: [8, "Password must be atleast 8 letters"],
  },
  firstname: {
    type: String,
  },
  lastname: {
    type: String,
  },
  username: {
    type: String,
  },
  mobile: {
    type: String,
  },
  vehicles: [vehicleSchema],
});

// * Fire the function before doc save to DB
userSchema.pre("save", async function (next) {
  var salt = await bcrypt.genSalt();
  this.password = await bcrypt.hash(this.password, salt);
  next();
});

// ? Static method to login in user
userSchema.statics.login = async function (email, password) {
  const user = await this.findOne({ email });
  if (user) {
    const auth = await bcrypt.compare(password, user.password);
    if (auth) {
      return user;
    }
    throw Error("Incorrect Password");
  }
  throw Error("Incorrect Email");
};

const User = mongoose.model("user", userSchema);

module.exports = User;
