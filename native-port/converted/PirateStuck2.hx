
@:meta(Embed(source="/_assets/assets.swf",symbol="symbol812"))

class PirateStuck2 extends PirateStuck1
{
    
    public function new(p : Dynamic)
    {
        super(p);
    }
    
    override public function buildThatWall() : Void
    {
        new AWall({
            x : 4000,
            y : 1082,
            scaleX : 1.18,
            scaleY : 3.12,
            rotation : 0,
            ID : 2,
            status : "Gate"
        });
    }
}


