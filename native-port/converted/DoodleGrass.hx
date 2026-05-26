
@:meta(Embed(source="/_assets/assets.swf",symbol="symbol4579"))

class DoodleGrass extends LevelDecals
{
    
    public function new(p : Dynamic)
    {
        super("doodleGrass", p.x, p.y, p.rotation, 1, 1, p.onRail, "nothing", -1);
        isTall = 20;
        isWide = 15;
        hitChar = hitBaddie = function(ex : Dynamic, ey : Dynamic, eRL : Dynamic, eUD : Dynamic, baddie : Dynamic) : Dynamic
                        {
                            if (myStarlingClip.currentFrame < 22 || myStarlingClip.currentFrame > 31 && myStarlingClip.currentFrame < 59 || myStarlingClip.currentFrame > 131 && myStarlingClip.currentFrame < 159)
                            {
                                if (eUD > 10 && Math.abs(eRL) < 10)
                                {
                                    myStarlingClip.currentFrame = 25;
                                }
                                else if (eRL < 0)
                                {
                                    myStarlingClip.currentFrame = 122;
                                }
                                else
                                {
                                    myStarlingClip.currentFrame = 22;
                                }
                            }
                            else if (myStarlingClip.currentFrame == 131)
                            {
                                myStarlingClip.currentFrame = 130;
                            }
                            else if (myStarlingClip.currentFrame == 31)
                            {
                                myStarlingClip.currentFrame = 30;
                            }
                            else if (Math.abs(eRL) > 10 && myStarlingClip.currentFrame != 130 && myStarlingClip.currentFrame != 30)
                            {
                                decalEnterFrame();
                            }
                        };
        decalEnterFrame = function() : Dynamic
                {
                    ++myStarlingClip.currentFrame;
                    if (myStarlingClip.currentFrame == 20 || myStarlingClip.currentFrame == 66 || myStarlingClip.currentFrame == 166)
                    {
                        myStarlingClip.currentFrame = 1;
                    }
                };
        cleanUp = function() : Dynamic
                {
                };
    }
}


