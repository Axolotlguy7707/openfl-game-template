package core;

import openfl.geom.Rectangle;
import haxe.Timer;
import openfl.display.Sprite;
import openfl.events.Event;
import core.Scene;

class Game extends Sprite {

    public static var instance:Game;

    public static inline var GAME_WIDTH:Int = 1280;
    public static inline var GAME_HEIGHT:Int = 720;

    var lastTime:Float;
    public var currentScene:Scene;

    public function new(startingScene: Scene) {
        super();

        instance = this;

        lastTime = Timer.stamp();

        addEventListener(Event.ENTER_FRAME, update);

        currentScene = startingScene;
        this.addChild(currentScene);

        scrollRect = new Rectangle(0, 0, GAME_WIDTH, GAME_HEIGHT);
    }

    function onAddedToStage(e:Event) {
        stage.addEventListener(Event.RESIZE, onResize);
        onResize(null);
    }

    function onResize(e:Event) {
        var scale = Math.min(
            stage.stageWidth / GAME_WIDTH,
            stage.stageHeight / GAME_HEIGHT
        );

        scaleX = scale;
        scaleY = scale;

        x = (stage.stageWidth - GAME_WIDTH * scale) / 2;
        y = (stage.stageHeight - GAME_HEIGHT * scale) / 2;
    }

    function update(e:Event) {
        var now = Timer.stamp();
        var delta = now - lastTime;
        lastTime = now;

        if (currentScene != null) {
            currentScene.update(delta);
        }
    }
}
