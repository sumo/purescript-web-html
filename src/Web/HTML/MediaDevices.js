"use strict";

exports.getUserMedia_ = (mediaDevices, constraints) => () => {
    console.log(constraints)
    return mediaDevices.getUserMedia(constraints);
};
