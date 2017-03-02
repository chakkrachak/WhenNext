import { Component } from '@angular/core';
import { Platform } from 'ionic-angular';
import { StatusBar, Splashscreen } from 'ionic-native';
declare var cordova:any;

import { HomePage } from '../pages/home/home';


@Component({
  templateUrl: 'app.html'
})
export class MyApp {
  rootPage = HomePage;

  constructor(platform: Platform) {
    platform.ready().then(() => {
      // Okay, so the platform is ready and our plugins are available.
      // Here you can do any higher level native things you might need.
      StatusBar.styleDefault();
      Splashscreen.hide();
      alert("TEST");
      cordova.plugins.HelloPluginCordova.coolMethod("BIFFLE",
          function() {
            alert("WORKING");
          },
          function() {
            alert("Actually working too");
          });
    });
  }
}
