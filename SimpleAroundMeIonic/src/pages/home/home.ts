import { Component } from '@angular/core';

import { NavController } from 'ionic-angular';

declare var cordova:any;

@Component({
  selector: 'page-home',
  templateUrl: 'home.html'
})
export class HomePage {
  items = [
    'Pokémon Yellow',
    'Super Metroid',
    'Mega Man X',
    'The Legend of Zelda',
    'Pac-Man',
    'Super Mario World',
    'Street Fighter II',
    'Half Life',
    'Final Fantasy VII',
    'Star Fox',
    'Tetris',
    'Donkey Kong III',
    'GoldenEye 007',
    'Doom',
    'Fallout',
    'GTA',
    'Halo'
  ];

  constructor(public navCtrl: NavController) {}

  testDesEnfers() {
      cordova.plugins.HelloPluginCordova.coolMethod("Poulpi",
          function(msg) {
              alert("WORKING " + msg);
          },
          function(err) {
              alert("Actually working too " + err);
          }
      );

      cordova.plugins.HelloPluginCordovaSwift.coolMethod("Poulpine",
          function(msg) {
              alert("Swift WORKING " + msg);
          },
          function(err) {
              alert("Swift Actually working too " + err);
          }
      );

      cordova.plugins.HelloPluginCordovaSwift.giveMeAnArray("PoulpinePilou",
          function(arrayResponse) {
              alert("Swift WORKING array " + arrayResponse[0]);
          },
          function(err) {
              alert("Swift Actually working array too " + err);
          }
      );
  }
}
