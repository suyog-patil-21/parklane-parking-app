
function randomBetween(min, max) {  
    return Math.floor(
      Math.random() * (max - min) + min
    )
  }

module.exports = randomBetween;