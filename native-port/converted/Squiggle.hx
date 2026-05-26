
@:meta(Embed(source="/_assets/assets.swf",symbol="symbol2557"))

class Squiggle extends StaticInteractObjects
{
    
    public function new(p : Dynamic)
    {
        super("Squiggle", p.x, p.y, 1, 1, p.onRail, "nothing", -1);
        rotter = Math.random() * 20 - 10;
        BallRes = 10;
        isTall = isWide = 10;
        bounce = 0.8;
        bounceThresh = 2;
        rotPerc = 360 / (Math.PI * (isTall * 2));
        overReach = 4;
        ID = p.ID;
        Backgrounds.backgroundsArray[onRail].addChild(this);
        hitChar = function(ex : Dynamic, ey : Dynamic, eRL : Dynamic, eUD : Dynamic, char : Dynamic) : Dynamic
                {
                    if (onRail < backgroundsN)
                    {
                        dontCheat[Main.LevelLoaded][ID] = true;
                    }
                    else
                    {
                        dontCheat[Main.LevelLoaded + "_" + onRail][ID] = true;
                    }
                    char.squiggleGet();
                    cachedEffects.spawnCachedEffect("SquigPop", x, y, Math.random() * 360, 1, 0, 0, onRail, char.parent);
                    killInteract.push(this);
                    hitChar = function() : Dynamic
                            {
                            };
                };
    }
}


