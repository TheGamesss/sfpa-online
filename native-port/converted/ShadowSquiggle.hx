
@:meta(Embed(source="/_assets/assets.swf",symbol="symbol3676"))

class ShadowSquiggle extends StaticInteractObjects
{
    
    public function new(p : Dynamic)
    {
        super("shadowSquiggle", p.x, p.y, 1, 1, p.onRail, "nothing", -1);
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
                    StarlingInteract.dontCheat[Main.LevelLoaded][ID] = true;
                    char.squiggleGet();
                    StarlingEffect.spawnStarlingEffect("SquigPop", x, y, Math.random() * 3, 1, eRL * 0.25, eUD * 0.25, onRail);
                    killInteract.push(this);
                    hitChar = function() : Dynamic
                            {
                            };
                };
    }
}


