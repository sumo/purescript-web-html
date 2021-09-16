"use strict";

exports.getUserMedia_ = function (mediaDevices) {
  return function (constraints) {
    return function () {
      return mediaDevices.getUserMedia(constraints);
    };
  };
};
