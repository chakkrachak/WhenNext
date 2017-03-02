import { Component } from '@angular/core';

import { NavController } from 'ionic-angular';

declare var cordova:any;

@Component({
  selector: 'page-home',
  templateUrl: 'home.html'
})
export class HomePage {
  items: string[];

  constructor(public navCtrl: NavController) {
      this.items = [
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
  }

  testDesEnfers() {
      var that = this;
      cordova.plugins.HelloPluginCordovaSwift.giveMeAnArray("PoulpinePilou",
          function(arrayResponse) {
              that.items = ['TUTU'];
          },
          function(err) {
              alert("Swift Actually working array too " + err);
          }
      );
  }
}
