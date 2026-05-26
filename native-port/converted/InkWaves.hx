
@:meta(Embed(source="/_assets/assets.swf",symbol="symbol429"))

class InkWaves extends LevelDecals
{
    
    public function new()
    {
        super();
        isTall = 20;
        isWide = 40;
        Backgrounds.backgroundsArray[0].addChild(this);
        hitChar = hitBaddie = function(ex : Dynamic, ey : Dynamic, eRL : Dynamic, eUD : Dynamic, baddie : Dynamic) : Dynamic
                        {
                        };
        cleanUp = function() : Dynamic
                {
                };
    }
}


