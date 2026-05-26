
@:meta(Embed(source="/_assets/assets.swf",symbol="symbol338"))

class Paywall extends StaticInteractObjects
{
    
    private var moveUD : Float = 0;
    
    public function new(p : Dynamic)
    {
        super("Paywall", p.x, p.y, 1, 1, 0, "nothing", 0);
        interactive = false;
        if (Main.hasKey())
        {
            hitChar = function(ex : Dynamic, ey : Dynamic, eRL : Dynamic, eUD : Dynamic, char : Dynamic) : Dynamic
                    {
                        interactive = true;
                    };
            InteractEnterFrame = function() : Dynamic
                    {
                        if (interactive)
                        {
                            moveUD = (anchorY - 150 - y) * 0.2;
                        }
                        else if (y + moveUD < anchorY)
                        {
                            moveUD += 2;
                        }
                        else
                        {
                            if (moveUD > 0)
                            {
                                Main.shakeRL = moveUD * 0.5;
                            }
                            moveUD = 0;
                            y = anchorY;
                        }
                        if (moveUD != 0)
                        {
                            y += moveUD;
                            myPayWall.y = y;
                        }
                        interactive = false;
                    };
        }
        else
        {
            hitChar = function(ex : Dynamic, ey : Dynamic, eRL : Dynamic, eUD : Dynamic, char : Dynamic) : Dynamic
                    {
                        new BigSpeechBubble(8, 11, function() : Dynamic
                        {
                        });
                        hitChar = function(ex : Dynamic, ey : Dynamic, eRL : Dynamic, eUD : Dynamic, char : Dynamic) : Dynamic
                                {
                                };
                    };
        }
        hitBaddie = function(ex : Dynamic, ey : Dynamic, eRL : Dynamic, eUD : Dynamic, baddie : Dynamic) : Dynamic
                {
                };
        myPayWall = new PayWallWall();
        myPayWall.x = x;
        myPayWall.y = y;
        Main.AllEverything.walls0.addChild(myPayWall);
        Backgrounds.backgroundsArray[0].addChild(this);
        isWide = 150;
        isTall = 500;
        InteractEnterFrameArray.push(this);
        if (Main.hasKey())
        {
            gotoAndStop(2);
        }
        else
        {
            gotoAndStop(1);
        }
    }
}


