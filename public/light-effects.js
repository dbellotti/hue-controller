var dungeon = function() {
  clearIntervals();

  let flameOn = function() {
    let i = getRandomInt(0, 2)
    if ( i === 0 ) {
      changeScene("Fire 1");
    } else if ( i === 1 ){
      changeScene("Fire 2");
    } else {
      changeScene("Fire 3");
    }
  }

  let flameLength = getRandomInt(0, 1000);
  window.setInterval(flameOn, flameLength);
}

var lightning = function() {
  let strikeLength = getRandomInt(0, 700);

  $.post("/select_scene", { scene: "Lighting" }).then(function() {
    return setTimeout(function() {
      changeScene("The Calm Before the Storm");
    }, strikeLength);
  });
}

var storm = function() {
  clearIntervals();

  changeScene("The Calm Before the Storm");

  let cycleLength = getRandomInt(0, 25000);
  window.setInterval(lightning, cycleLength)
  //lightningStrike(2);
  //lightningStrike(6);
  //lightningStrike(12);
  //lightningStrike(19);
  //lightningStrike(24);
  //lightningStrike(28);
  //lightningStrike(49);
  //lightningStrike(58);
  //lightningStrike(92);
}

var singleDoorStrike = function(time_secs) {
      setTimeout(function () { changeScene("Lighting");                  }, 1000 * time_secs);
      setTimeout(function () { changeScene("The Calm Before the Storm"); }, 1000 * time_secs + 0.25);
}
var doubleDoorStrike = function(time_secs) {
      setTimeout(function () { changeScene("Lighting");                  }, 1000 * time_secs);
      calmTime = time_secs + Math.random() * 0.25;
      setTimeout(function () { changeScene("The Calm Before the Storm"); }, 1000 * calmTime);
      setTimeout(function () { changeScene("Lighting");                  }, 1000 * calmTime + 0.5);
      setTimeout(function () { changeScene("The Calm Before the Storm"); }, 1000 * calmTime + 0.75);
}

var lightningStrike = function(time_secs) {
    var strikes = [
      singleDoorStrike,
      doubleDoorStrike,
    ];
    var i = getRandomInt(0, strikes.length - 1);

    console.log("random value: %d", i);
    strikes[i](time_secs);
}

// Utilities

var changeScene = function(scene) {
  console.log("Changing Scene: " + scene);

  $.post("/select_scene", { scene: scene } );
};

var getRandomInt = function(min, max) {
  return Math.floor(Math.random() * (max - min + 1) + min);
}

var clearIntervals = function() {
  console.log("going clear");
  for (var i = 1; i < 99999; i++)
    window.clearInterval(i);
}

