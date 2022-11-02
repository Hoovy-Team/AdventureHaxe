package;

import flixel.FlxG;
import flixel.ui.FlxBar;
import flixel.system.FlxAssets;
import openfl.Assets;
import flixel.text.FlxText;
import flixel.FlxGame;
import openfl.display.Sprite;
import openfl.display.FPS;
import openfl.Lib;
import openfl.display.Sprite;
import openfl.events.Event;
import flixel.FlxState;
import openfl.system.System;
import openfl.media.Sound;
import flixel.util.FlxAxes;

using StringTools;

class LoadState extends FlxState
{
    var loadNow:Bool = false;
    var cantLoad:Bool = false;
    var text:FlxText;

    //var cache:AssetCache = new AssetCache();

    override function create():Void 
    {
        FlxG.save.bind("data", "gameData");

        text = new FlxText(0, 0, 0, "", 18);
        text.screenCenter();
        add(text);
     
        loadNow = false;
        cantLoad = false;

        loadBar();

        trace("load game");

        super.create();
    }

    public function loadBar():Void {
        // loadAssets();
    }

    public function loadAssets():Void {
        loadNow = true;
    }

    override function update(elapsed:Float):Void 
    {
        if(loadNow = true && cantLoad = false){
            text.text = "Load Assets Now";
            loadAssets();
        }else if(loadNow = false && cantLoad = true){
            text.text = "Game cant load\nPlease restart game";
        }else if(loadNow = false && cantLoad = false){
            text.text = "Error load, exit now";
        }else if(loadNow = true && cantLoad = true){
            text.text = "Error load, exit now";
        }else{
            text.text = "Game cant load\nPlease restart game";
        }
    }
}