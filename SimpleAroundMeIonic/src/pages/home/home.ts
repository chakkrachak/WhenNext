import {Component, NgZone} from '@angular/core';

import {NavController} from 'ionic-angular';

declare var cordova: any;

@Component({
    selector: 'page-home',
    templateUrl: 'home.html'
})
export class HomePage {
    items: string[];

    constructor(public navCtrl: NavController, private zone: NgZone) {
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
        cordova.plugins.NavitiaSDKCordovaPlugin.StopSchedulesBuilder(function (stopSchedules) {
                alert(JSON.stringify(stopSchedules));
                that.zone.run(function () {
                        that.items = [];
                        that.items.push("DONE");
                    }
                )
            },
            function (err) {
                alert("Swift Actually working array too " + err);
            }
        );

    }
}
