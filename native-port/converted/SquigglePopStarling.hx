
class SquigglePopStarling extends StarlingInteract
{
    
    private var canPop : Bool = true;
    
    private var levelloaded : String;
    
    public var inky : Bool = false;
    
    private var fake : Bool;
    
    public function new(e : Dynamic, ex : Dynamic, ey : Dynamic, rot : Dynamic, scale : Dynamic, eRL : Dynamic, eUD : Dynamic, rail : Dynamic, id : Dynamic)
    {
        super(e, ex + Math.random() * 20, ey + Math.random() * 20, rot, scale, eRL, eUD, rail, id);
        isTall = 25;
        isWide = 25;
        predictOffsetY = 100;
    }
    
    override public function hitChar(ex : Float, ey : Float, eRL : Float, eUD : Float, char : Char) : Bool
    {
        distRL = x - ex;
        distUD = y - ey;
        angle = -Math.atan2(distRL, distUD);
        tempRot = angle / (Math.PI / 180);
        ax = Math.cos(angle) * distRL + Math.sin(angle) * distUD;
        ay = Math.cos(angle) * distUD - Math.sin(angle) * distRL;
        if (-ay < isTall + char.isTall)
        {
            tempRL = Math.cos(angle) * eRL + Math.sin(angle) * eUD;
            tempUD = Math.cos(angle) * eUD - Math.sin(angle) * eRL;
            if (tempUD < 0)
            {
                return false;
            }
            tempUD = -15;
            ay = -(char.isTall + isTall);
            char.x = x + (Math.cos(angle) * ax - Math.sin(angle) * ay);
            char.y = y + (Math.cos(angle) * ay + Math.sin(angle) * ax);
            if (Math.abs(tempRot) < 60)
            {
                angle = tempRot * 0.5 * Math.PI / 180;
            }
            if (eUD > 0)
            {
                char.FloatUp = 6;
            }
            else
            {
                char.FloatUp = 0;
            }
            char.moveRL = Math.cos(angle) * (tempRL / 2) - Math.sin(angle) * (tempUD / 2);
            char.moveUD = Math.cos(angle) * tempUD + Math.sin(angle) * (tempRL / 2);
            if (char.Status == "Jump")
            {
                char.rotter = 0;
            }
            if (char.moveUD > 2)
            {
                char.moveUD = 2;
            }
            else if (char.moveUD < -18)
            {
                char.moveUD = -18;
            }
            char.canQuickDrop = false;
            char.FloatLock = false;
            this.pop();
            if (char.Status == "Jump")
            {
                char.fliprot = char.moveRL * 1.3;
                if (Math.abs(char.fliprot) > 15)
                {
                    char.fliprot = char.makeOne(char.fliprot) * 15;
                }
                char.resetPencil();
                if (char.JumpIsDown() && char.moveUD < 0)
                {
                    char.char.gotoAndStop("normal");
                    char.char.char.gotoAndStop(3);
                }
                else
                {
                    char.char.gotoAndStop("dropJump");
                    char.char.char.gotoAndStop(4);
                }
                char.rotter = char.moveRL;
                char.placeHead(char.char.char);
            }
            return true;
        }
        return false;
    }
    
    override public function hitBaddie(ex : Float, ey : Float, eRL : Float, eUD : Float, bad : Baddies) : Bool
    {
        distRL = x - ex;
        distUD = y - ey;
        tempRot = -Math.atan2(distRL, distUD) / (Math.PI / 180);
        angle = tempRot * Math.PI / 180;
        ax = Math.cos(angle) * distRL + Math.sin(angle) * distUD;
        ay = Math.cos(angle) * distUD - Math.sin(angle) * distRL;
        if (-ay < isTall + bad.isTall)
        {
            tempRL = Math.cos(angle) * eRL + Math.sin(angle) * eUD;
            tempUD = -20;
            ay = -(bad.isTall + isTall);
            bad.spring = -10;
            bad.x = x + (Math.cos(angle) * ax - Math.sin(angle) * ay);
            bad.y = y + (Math.cos(angle) * ay + Math.sin(angle) * ax);
            bad.moveRL = Math.cos(angle) * (tempRL / 2) - Math.sin(angle) * (tempUD / 2);
            bad.moveUD = Math.cos(angle) * tempUD + Math.sin(angle) * (tempRL / 2);
            this.pop();
            return true;
        }
        return false;
    }
    
    public function currentGetAttacked(ex : Float, ey : Float, ang : Float, char : Collision, hitMove : String, hitPower : Float, pow : Float = 1) : Bool
    {
        angle = ang - 3.14;
        this.pop();
        return true;
    }
    
    public function pop() : Dynamic
    {
        if (dontCheat[this.levelloaded][ID] == null)
        {
            if (Math.cos(angle) > 0)
            {
                StarlingInteract.Spawn("looseSquiggle", x - 10 + -Math.sin(angle - 0.1) * 15, y, 0, 1, -Math.sin(angle - 0.1) * 6, 0, onRail);
                StarlingInteract.Spawn("looseSquiggle", x + -Math.sin(angle) * 20, y + 20, 0, 1, -Math.sin(angle) * 7, 0, onRail);
                StarlingInteract.Spawn("looseSquiggle", x + 10 + -Math.sin(angle + 0.1) * 18, y + 10, 0, 1, -Math.sin(angle + 0.1) * 6.5, 0, onRail);
            }
            else
            {
                StarlingInteract.Spawn("looseSquiggle", x - 10 + -Math.sin(angle - 0.1) * 15, y + Math.cos(angle - 0.1) * 15, 0, 1, -Math.sin(angle - 0.1) * 6, Math.cos(angle - 0.1) * 15, onRail);
                StarlingInteract.Spawn("looseSquiggle", x + -Math.sin(angle) * 20, y + Math.cos(angle) * 20, 0, 1, -Math.sin(angle) * 7, Math.cos(angle) * 20, onRail);
                StarlingInteract.Spawn("looseSquiggle", x + 10 + -Math.sin(angle + 0.1) * 18, y + Math.cos(angle + 0.1) * 18, 0, 1, -Math.sin(angle + 0.1) * 6.5, Math.cos(angle + 0.1) * 18, onRail);
            }
        }
        Sounds.playSound("Popper", x, 1.5, onRail);
        StarlingEffect.Spawn("popEffect", x, y, Math.random() * 3, 1, 0, 0, onRail);
    }
    
    public function smashKnockback(e : Float) : Float
    {
        return e;
    }
    
    override public function reset() : Void
    {
        canAttackArray.push(this);
        cameraCollideArray.push(this);
        this.levelloaded = Main.LoadIt;
    }
}


