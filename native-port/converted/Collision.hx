import flash.display.*;
import flash.geom.*;
import flash.media.SoundChannel;
import flash.utils.*;

class Collision extends MovieClip
{
    
    public static var MaxY : Int;
    
    public static var groundArray : Array<Dynamic>;
    
    public static var groundOffsetN : Int;
    
    private static var groundGrid : Dynamic;
    
    private static var gridMax : Int;
    
    private static var stageWidth : Int;
    
    private static var cameraX : Float;
    
    private static var cameraY : Float;
    
    private static var stageXs : Array<Dynamic>;
    
    private static var stageYs : Array<Dynamic>;
    
    public static var collisionOffsets : Array<Dynamic>;
    
    public static var relativeStageY : Int;
    
    public static var framin : Float = 1;
    
    private static var gridSize : Int = 400;
    
    public static var InteractObjectsArray : Array<Collision> = new Array<Collision>();
    
    public static var groundTestN : Int = 0;
    
    public static var groundTests : Array<Dynamic> = [0, 0];
    
    public static var testPlatsN : Int = 0;
    
    public var moveRL : Float = 0;
    
    public var moveUD : Float = 0;
    
    public var theX : Float = 0;
    
    public var theY : Float = 0;
    
    public var lastX : Float = 0;
    
    public var lastY : Float = 0;
    
    public var tickX : Float = 0;
    
    public var tickY : Float = 0;
    
    public var wantRL : Float = 0;
    
    public var wantUD : Float = 0;
    
    public var FloatUp : Int = 0;
    
    public var health : Int = 0;
    
    public var healthMax : Int = 0;
    
    public var showHealthBar : Bool;
    
    public var power : Float = 1;
    
    public var powerLevel : Float = 0;
    
    public var launchThresh : Int = 0;
    
    public var initialFloat : Int;
    
    public var fakeX : Float = 0;
    
    public var fakeY : Float = 0;
    
    public var fakeRL : Float = 0;
    
    public var fakeUD : Float = 0;
    
    public var tempRL : Float = 0;
    
    public var tempUD : Float = 0;
    
    public var platRL : Float = 0;
    
    public var platUD : Float = 0;
    
    public var platWallRL : Float = 0;
    
    public var platWallUD : Float = 0;
    
    public var platGround : Bool;
    
    public var platWall : Bool;
    
    public var groundRL : Float = 0;
    
    public var groundUD : Float = 0;
    
    public var wallRL : Float = 0;
    
    public var wallUD : Float = 0;
    
    public var wallWallRL : Float = 0;
    
    public var wallWallUD : Float = 0;
    
    public var wallGround : Bool;
    
    public var wallWall : Bool;
    
    public var groundFootR : Bool;
    
    public var groundFootL : Bool;
    
    public var onGround : Bool;
    
    public var almostGround : Bool;
    
    public var almostPlat : Bool;
    
    public var alreadyOnGround : Bool;
    
    public var dontLand : Bool = false;
    
    public var lastGround : String = "nothing";
    
    public var StompedOn : Dynamic;
    
    public var stompedOnX : Float;
    
    public var stompedOnY : Float;
    
    public var camDistR : Int = 10;
    
    public var camDistL : Int = 10;
    
    public var camDistU : Int = 100;
    
    public var camDistD : Int = 10;
    
    public var vOffset : Int = 0;
    
    public var distRL : Float = 0;
    
    public var distUD : Float = 0;
    
    public var shakeRL : Float = 0;
    
    public var shakeOrigin : Float = 0;
    
    public var nowDist : Float = 0;
    
    public var landSpeed : Float = 0;
    
    public var cheatSpeed : Float = 0;
    
    public var wantRot : Float = 0;
    
    public var tempRot : Float = 0;
    
    public var rampN : Int;
    
    public var wallX : Float = 0;
    
    public var wallY : Float = 0;
    
    public var wallRot : Float = 0;
    
    public var wallAngle : Float = 0;
    
    public var tempWallX : Float = 0;
    
    public var tempWallY : Float = 0;
    
    public var tempWallRot : Float = 0;
    
    public var tempWallAngle : Float = 0;
    
    public var tempXTotal : Float = 0;
    
    public var tempYTotal : Float = 0;
    
    public var rotItems : Float = 0;
    
    public var oldWallRot : Float = 0;
    
    public var oldFakeRL : Float = 0;
    
    public var oldFakeUD : Float = 0;
    
    public var angle : Float;
    
    public var tempAngle : Float;
    
    public var angle1 : Float = 0;
    
    public var angle2 : Float = 0;
    
    public var ex : Float = 0;
    
    public var ey : Float = 0;
    
    public var ax : Float = 0;
    
    public var ay : Float = 0;
    
    public var aRL : Float = 0;
    
    public var aUD : Float = 0;
    
    public var ex2 : Float = 0;
    
    public var ey2 : Float = 0;
    
    public var ax2 : Float = 0;
    
    public var ay2 : Float = 0;
    
    public var mass : Int = 20;
    
    public var downTime : Int = 0;
    
    public var hitPause : Int = 0;
    
    public var rotter : Float = 0;
    
    public var rotPerc : Float;
    
    public var combo : Int = 0;
    
    public var stunN : Int = 0;
    
    public var stunMax : Int = 0;
    
    public var facing : Int = 1;
    
    public var Still : Bool;
    
    public var tempX : Float;
    
    public var tempY : Float;
    
    public var platCacheX1 : Float;
    
    public var platCacheY1 : Float;
    
    public var platCacheX2 : Float;
    
    public var platCacheY2 : Float;
    
    public var spring : Float = 0;
    
    public var springDecay : Float = 0.8;
    
    public var springThresh : Float = 0.5;
    
    public var overReach : Int;
    
    public var onWall : Int;
    
    public var onWallPlat : Int;
    
    public var wallHanging : Bool;
    
    public var onLedge : Int;
    
    public var Jumper : Float = 0;
    
    public var rotAccel : Float;
    
    public var friction : Float = 1;
    
    public var gotoBuffer : String = "nothing";
    
    public var Status : String = "Wait";
    
    public var canStatus : String = "nothing";
    
    public var crossStatus : String = "nothing";
    
    public var isABall : Bool;
    
    public var onRail : Int = -1;
    
    public var accelUD : Float = 0;
    
    public var smokeN : Float = 0;
    
    public var smokeB : Int = 0;
    
    public var groundCompY : Int = -200;
    
    public var inVase : Dynamic;
    
    public var aPlatOn : Dynamic;
    
    public var aWallOn : Dynamic;
    
    public var hatVar0 : Int = 10;
    
    public var inky : Bool;
    
    public var scale : Float = 1;
    
    public var isAttacking : Bool;
    
    public var canAggressor : Bool;
    
    public var slippery : Bool;
    
    public var sliding : Bool;
    
    public var suppressJump : Bool;
    
    public var originX : Float;
    
    public var originY : Float;
    
    public var BallRes : Int;
    
    public var isTall : Int;
    
    public var isWide : Int;
    
    public var wasTall : Int;
    
    public var bounce : Float;
    
    public var bounceThresh : Int;
    
    public var maxRL : Float;
    
    public var springy : Int;
    
    public var hurtPower : Float = 0;
    
    public var springTall : Float = 0;
    
    public var originalSpringTall : Int;
    
    public var canBowlOver : Bool;
    
    public var ItIs : String;
    
    public var RedHurt : Int;
    
    public var myVisible : Dynamic = [];
    
    @:allow()
    private var currentSound : SoundChannel;
    
    @:allow()
    private var soundLooper : Timer;
    
    @:allow()
    private var soundLoopFunc : Dynamic;
    
    @:allow()
    private var oTimer : Int = 0;
    
    public var ground : Sprite;
    
    public var walls : Sprite;
    
    public var platforms : Sprite;
    
    public var groundsArray : Array<Dynamic> = [];
    
    public var platformsArray : Array<Dynamic> = [];
    
    public var wallsArray : Array<Dynamic> = [];
    
    private var quickRadian : Float = 0.017453292519943295;
    
    public var isSmash : Bool;
    
    public var aPlatSides : Array<Dynamic> = new Array<Dynamic>();
    
    public var CheckGroundGround : Dynamic = this.CheckGroundGroundSimple;
    
    public function springBounce() : Dynamic
    {
    }
    public function moveSpringBounce() : Dynamic
    {
    }
    private var superTest : Int = 0;
    
    public function new(rail : Int = -20)
    {
        super();
        if (rail > -20)
        {
            this.onRail = rail;
        }
        this.setGroundRail();
    }
    
    @:allow()
    private static function getSpeed(eRL : Dynamic, eUD : Dynamic) : Dynamic
    {
        return Math.sqrt(eRL * eRL + eUD * eUD);
    }
    
    public static function sendVars(ex : Float, ey : Float, sx : Array<Dynamic>, sy : Array<Dynamic>) : Void
    {
        cameraX = ex;
        cameraY = ey;
        stageXs = sx;
        stageYs = sy;
    }
    
    public static function InteractCollisions() : Void
    {
        var i : Dynamic = as3hx.Compat.parseInt(InteractObjectsArray.length - 1);
        while (i >= 0)
        {
            Reflect.field(InteractObjectsArray, Std.string(i)).InteractCollision();
            Reflect.setField(InteractObjectsArray, Std.string(i), Reflect.field(InteractObjectsArray, Std.string(i)).x).myVisible.x;
            Reflect.setField(InteractObjectsArray, Std.string(i), Reflect.field(InteractObjectsArray, Std.string(i)).y).myVisible.y;
            Reflect.setField(InteractObjectsArray, Std.string(i), Reflect.field(InteractObjectsArray, Std.string(i)).moveRL).myVisible.moveRL;
            Reflect.setField(InteractObjectsArray, Std.string(i), Reflect.field(InteractObjectsArray, Std.string(i)).moveUD).myVisible.moveUD;
            Reflect.setField(InteractObjectsArray, Std.string(i), Reflect.field(InteractObjectsArray, Std.string(i)).rotation).myVisible.rotation;
            i--;
        }
    }
    
    public static function ballCollision(ball : Dynamic, ball2 : Dynamic) : Dynamic
    {
        var dx : Float = ball.x - ball2.x;
        var dy : Float = ball.y - ball2.y;
        if (ball.onRail == ball2.onRail)
        {
            if (Math.abs(dx) < ball.isTall + ball2.isTall && Math.abs(dy) < ball.isTall + ball2.isTall)
            {
                return Math.sqrt(dx * dx + dy * dy) < ball.isTall + ball2.isTall;
            }
        }
        return false;
    }
    
    public static function solveBalls(ball : Collision, ball2 : Collision) : Bool
    {
        var magnitude_1 : Float = Math.NaN;
        var magnitude_2 : Float = Math.NaN;
        var dx : Float = Math.NaN;
        var dy : Float = Math.NaN;
        var dist : Float = Math.NaN;
        var bothTall : Float = Math.NaN;
        var collisionision_angle : Float = Math.NaN;
        var direction_1 : Float = Math.NaN;
        var direction_2 : Float = Math.NaN;
        var new_xspeed_1 : Float = Math.NaN;
        var final_yspeed_1 : Float = Math.NaN;
        var new_xspeed_2 : Float = Math.NaN;
        var final_yspeed_2 : Float = Math.NaN;
        var final_xspeed_1 : Float = Math.NaN;
        var final_xspeed_2 : Float = Math.NaN;
        var cosAngle : Float = Math.NaN;
        var sinAngle : Float = Math.NaN;
        var cosAngle2 : Float = Math.NaN;
        var sinAngle2 : Float = Math.NaN;
        if (ballCollision(ball, ball2))
        {
            magnitude_1 = Math.sqrt(ball.moveRL * ball.moveRL + ball.moveUD * ball.moveUD);
            magnitude_2 = Math.sqrt(ball2.moveRL * ball2.moveRL + ball2.moveUD * ball2.moveUD);
            dx = ball.x - ball2.x;
            dy = ball.y - ball2.y;
            dist = Math.sqrt(dx * dx + dy * dy);
            bothTall = ball.isTall + ball2.isTall;
            collisionision_angle = Math.atan2(dy, dx);
            ball.spring = -magnitude_1 / 2;
            ball2.spring = -magnitude_2 / 2;
            direction_1 = Math.atan2(ball.moveUD, ball.moveRL);
            direction_2 = Math.atan2(ball2.moveUD, ball2.moveRL);
            new_xspeed_1 = magnitude_1 * Math.cos(direction_1 - collisionision_angle);
            final_yspeed_1 = magnitude_1 * Math.sin(direction_1 - collisionision_angle);
            new_xspeed_2 = magnitude_2 * Math.cos(direction_2 - collisionision_angle);
            final_yspeed_2 = magnitude_2 * Math.sin(direction_2 - collisionision_angle);
            final_xspeed_1 = ((ball.mass - ball2.mass) * new_xspeed_1 + (ball2.mass + ball2.mass) * new_xspeed_2) / (ball.mass + ball2.mass);
            final_xspeed_2 = ((ball.mass + ball.mass) * new_xspeed_1 + (ball2.mass - ball.mass) * new_xspeed_2) / (ball.mass + ball2.mass);
            cosAngle = Math.cos(collisionision_angle);
            sinAngle = Math.sin(collisionision_angle);
            cosAngle2 = Math.cos(collisionision_angle + Math.PI / 2);
            sinAngle2 = Math.sin(collisionision_angle + Math.PI / 2);
            if (final_xspeed_1 - final_xspeed_2 > 5)
            {
                Sounds.playSound("BadStomp", ball.x, Math.abs(final_xspeed_1 - final_xspeed_2) * 0.1, ball.onRail);
            }
            ball.moveRL = cosAngle * final_xspeed_1 + cosAngle2 * final_yspeed_1;
            ball.moveUD = sinAngle * final_xspeed_1 + sinAngle2 * final_yspeed_1;
            ball2.moveRL = cosAngle * final_xspeed_2 + cosAngle2 * final_yspeed_2;
            ball2.moveUD = sinAngle * final_xspeed_2 + sinAngle2 * final_yspeed_2;
            ball.x += (bothTall - dist) / 2 * cosAngle;
            ball.y += (bothTall - dist) / 2 * sinAngle;
            ball2.x -= (bothTall - dist) / 2 * cosAngle;
            ball2.y -= (bothTall - dist) / 2 * sinAngle;
            return true;
        }
        return false;
    }
    
    public static function solveUneven(ball : Dynamic, ball2 : Dynamic) : Dynamic
    {
        var b1RL : Float = Math.NaN;
        var b1UD : Float = Math.NaN;
        var b2RL : Float = Math.NaN;
        var b2UD : Float = Math.NaN;
        var dx : Float = Math.NaN;
        var dy : Float = Math.NaN;
        var i : Int = 0;
        var dist : Float = Math.NaN;
        var angle : Float = Math.NaN;
        if (ballCollision(ball, ball2))
        {
            if (ball.nowSpeed() == 0)
            {
                b1RL = b1UD = 0;
            }
            else
            {
                b1RL = ball.moveRL / ball.nowSpeed();
                b1UD = ball.moveUD / ball.nowSpeed();
            }
            if (ball2.nowSpeed() == 0)
            {
                b2RL = b2UD = 0;
            }
            else
            {
                b2RL = ball2.moveRL / ball2.nowSpeed();
                b2UD = ball2.moveUD / ball2.nowSpeed();
            }
            dx = ball.x - ball2.x;
            dy = ball.y - ball2.y;
            for (i in 0...50)
            {
                if (Math.sqrt(dx * dx + dy * dy) < 30)
                {
                    ball.x -= b1RL;
                    ball.y -= b1UD;
                    ball2.x -= b2RL;
                    ball2.y -= b2UD;
                    dx = ball.x - ball2.x;
                    dy = ball.y - ball2.y;
                }
            }
            dist = Math.sqrt(dx * dx + dy * dy);
            angle = -Math.atan2(-dx, -dy);
            ball.aRL = Math.cos(angle) * ball.moveRL + Math.sin(angle) * ball.moveUD;
            ball.aUD = -25;
            ball.moveRL = Math.cos(angle) * ball.aRL - Math.sin(angle) * ball.aUD;
            ball.moveUD = Math.cos(angle) * ball.aUD + Math.sin(angle) * ball.aRL;
            ball2.aRL = Math.cos(angle) * ball2.moveRL + Math.sin(angle) * ball2.moveUD;
            ball2.aUD = 10;
            ball2.moveRL = Math.cos(angle) * ball2.aRL - Math.sin(angle) * ball2.aUD;
            ball2.moveUD = -20;
            ball2.downTime = 5;
            ball.rotter = ball.moveRL * ball.rotPerc;
            ball2.rotter = ball2.moveRL * ball2.rotPerc;
            ball.CheckGroundAir();
            ball.CheckGroundPlatforms(false);
            ball.CheckAllAutos(false);
            ball2.CheckGroundAir();
            ball2.CheckGroundPlatforms(false);
            ball2.CheckAllAutos(false);
            return true;
        }
        return false;
    }
    
    public static function rotCompare(rot1 : Dynamic, rot2 : Dynamic) : Float
    {
        if (Math.abs(rot1 - rot2) > 180)
        {
            if (rot1 > rot2)
            {
                rot1 -= 360;
            }
            else
            {
                rot1 += 360;
            }
        }
        return rot1 - rot2;
    }
    
    public static function angleCompare(rot1 : Dynamic, rot2 : Dynamic) : Float
    {
        if (Math.abs(rot1 - rot2) > 3.141592653589793)
        {
            if (rot1 > rot2)
            {
                rot1 -= 6.283185307179586;
            }
            else
            {
                rot1 += 6.283185307179586;
            }
        }
        return rot1 - rot2;
    }
    
    public static function CreateCollisionGrid() : Dynamic
    {
        var ex : Int = 0;
        var ey : Int = 0;
        var i : Int = 0;
        var n : Int = 0;
        if (Main.AllEverything["ground" + 0] == null)
        {
            trace("no ground");
        }
        else if (Main.AllEverything["ground" + 0].numChildren > 1)
        {
            trace("grid collision");
            stageWidth = as3hx.Compat.parseInt(Math.round((Main.MaxX - Main.MinX) / gridSize) + 2);
            ex = Math.floor(Main.MinX / gridSize);
            ey = as3hx.Compat.parseInt(Math.floor(Main.MinY / gridSize) - 1);
            groundOffsetN = -(ex + ey * stageWidth);
            groundGrid = [];
            while (i < Main.AllEverything["ground" + 0].numChildren)
            {
                if (Type.getClassName(Main.AllEverything["ground" + 0].getChildAt(i)) == "flash.display::MovieClip")
                {
                    fileGroundPiece(Main.AllEverything["ground" + 0].getChildAt(i));
                }
                i++;
            }
            while (n < groundGrid.length)
            {
                if (Reflect.field(groundGrid, Std.string(n)) == null)
                {
                    Reflect.setField(groundGrid, Std.string(n), []);
                }
                n++;
            }
            gridMax = groundGrid.length;
        }
        else
        {
            groundGrid = [];
        }
    }
    
    private static function fileGroundPiece(e : Dynamic) : Dynamic
    {
        var xn : Int = 0;
        var bounds : Rectangle = e.getBounds(e);
        var x1 : Int = Math.floor((e.x + bounds.x - 5) / gridSize);
        var x2 : Int = Math.floor((e.x + bounds.x + bounds.width + 5) / gridSize);
        var y1 : Int = Math.floor((e.y + bounds.y - 5) / gridSize);
        var y2 : Int = Math.floor((e.y + bounds.y + bounds.height + 5) / gridSize);
        for (yn in y1...y2 + 1)
        {
            for (xn in x1...x2 + 1)
            {
                addGround(e, xn + yn * stageWidth + groundOffsetN);
            }
        }
    }
    
    private static function addGround(e : Dynamic, n : Dynamic) : Dynamic
    {
        if (Reflect.field(groundGrid, Std.string(n)) == null)
        {
            Reflect.setField(groundGrid, Std.string(n), []);
        }
        if (Reflect.field(groundGrid, Std.string(n)).indexOf(e) == -1)
        {
            Reflect.field(groundGrid, Std.string(n)).push(e);
        }
    }
    
    public static function staticGroundHitTest(ex : Float, ey : Float, rail : Int) : Bool
    {
        return Main.AllEverything["walls" + rail].hitTestPoint(ex, ey, true);
    }
    
    public static function hitTestAllRaw(ex : Dynamic, ey : Dynamic, rail : Dynamic) : Bool
    {
        return cast(Main.AllEverything["ground" + rail].hitTestPoint(ex, ey, true), Bool) || cast(Main.AllEverything["platforms" + rail].hitTestPoint(ex, ey, true), Bool) || cast(Main.AllEverything["walls" + rail].hitTestPoint(ex, ey, true), Bool);
    }
    
    public function firstCircleCheck(ex : Dynamic, ey : Dynamic, eUD : Dynamic) : Dynamic
    {
        return this.testOnlyGround(ex, ey);
    }
    
    public function secondCircleCheck(ex : Dynamic, ey : Dynamic, eUD : Dynamic) : Dynamic
    {
        return this.testAllGrounds(ex, ey);
    }
    
    public function checkAfterMove() : Bool
    {
    }
    
    @:allow()
    private function nowSpeed() : Dynamic
    {
        return Math.sqrt(this.moveRL * this.moveRL + this.moveUD * this.moveUD);
    }
    
    private function InteractCollision() : Void
    {
        if (this.CheckAllAir())
        {
            this.rotter = (this.fakeRL - this.platRL - this.wallRL) * this.rotPerc;
            this.wallRL = this.wallUD = this.platRL = this.platUD = 0;
        }
        else
        {
            this.wallRot = 0;
            this.rotter += (this.moveRL * 0.1 - this.rotter) / 20;
        }
    }
    
    public function interactRemoveFromArray(e : Dynamic) : Void
    {
        if (InteractObjectsArray.length == 1)
        {
            InteractObjectsArray = new Array<Collision>();
        }
        else if (Lambda.indexOf(InteractObjectsArray, e) < InteractObjectsArray.length - 1)
        {
            InteractObjectsArray[Lambda.indexOf(InteractObjectsArray, e)] = InteractObjectsArray.pop();
        }
        else
        {
            InteractObjectsArray.pop();
        }
    }
    
    public function setGroundRail() : Dynamic
    {
        this.ground = Main.AllEverything["ground" + this.onRail];
        this.platforms = Main.AllEverything["platforms" + this.onRail];
        this.walls = Main.AllEverything["walls" + this.onRail];
    }
    
    public function resetCombo() : Void
    {
        if (this.combo > 1)
        {
            Achievements.SendScore("maxCombo", this.combo);
        }
        this.combo = 0;
    }
    
    public function hideAll() : Void
    {
    }
    
    public function standardIdleBounce() : Void
    {
        this.spring += (this.originalSpringTall - this.springTall) / this.springy;
        if (Math.abs(this.spring) > this.springThresh)
        {
            this.spring *= 0.8;
        }
    }
    
    public function standardIdleMoveBounce() : Void
    {
        if (this.hitPause == 0)
        {
            this.springTall += this.spring * framin;
        }
        scaleY = this.springTall / this.originalSpringTall * this.scale;
        scaleX = (this.scale - scaleY + this.scale) * this.makeOne(scaleX);
        if (!this.hasSmoke || this.RedHurt > 1)
        {
            this.baddie.y = (this.isTall - this.springTall * 0.5) / scaleY;
        }
    }
    
    public function standardSpringBounce() : Void
    {
        this.spring += (this.originalSpringTall - this.springTall) / this.springy;
        if (Math.abs(this.spring) > this.springThresh)
        {
            this.spring *= this.springDecay;
        }
    }
    
    public function standardMoveSpringBounce() : Void
    {
        if (this.hitPause == 0)
        {
            this.springTall += this.spring * framin;
        }
        if (this.springTall > this.originalSpringTall * 1.8)
        {
            this.springTall = this.originalSpringTall * 1.5;
        }
        if (this.springTall < 12)
        {
            this.springTall = 12;
            this.spring = 0;
        }
        else if (this.springTall / this.originalSpringTall > 1.8)
        {
            this.springTall -= this.spring * Main.framin;
            this.spring = 0;
        }
        scaleY = this.springTall / (this.isTall * 2) * this.scale;
        scaleX = (this.scale - scaleY + this.scale) * this.makeOne(scaleX);
    }
    
    public function stompedMoveSpringBounce() : Void
    {
        if (this.hitPause == 0)
        {
            this.springTall += this.spring * framin;
        }
        if (this.springTall > this.originalSpringTall * 1.8)
        {
            this.springTall = this.originalSpringTall * 1.5;
        }
        if (this.springTall < 12)
        {
            this.springTall = 12;
            this.spring = 0;
        }
        else if (this.springTall / this.originalSpringTall > 2)
        {
            this.springTall = this.originalSpringTall * 2;
            this.spring = 0;
        }
        if (this.hasSmoke)
        {
            scaleY = this.springTall / this.originalSpringTall;
            if (this.springTall < this.originalSpringTall)
            {
                scaleX = ((1 - scaleY) * 3 + 1) * this.facing;
            }
            else
            {
                scaleX = ((1 - scaleY) * 0.8 + 1) * this.facing;
            }
        }
        else
        {
            this.baddie.scaleY = this.springTall / this.originalSpringTall;
            if (this.springTall < this.originalSpringTall)
            {
                this.baddie.scaleX = (1 - cast((this), MovieClip).baddie.scaleY) * 3 + 1;
            }
            else
            {
                this.baddie.scaleX = (1 - cast((this), MovieClip).baddie.scaleY) * 0.8 + 1;
            }
            this.baddie.y = this.isTall - this.springTall * 0.5;
            if (scaleX * this.facing < 0)
            {
                scaleX *= -1;
            }
        }
    }
    
    public function wholeMoveSpringBounce() : Void
    {
        if (this.hitPause == 0)
        {
            this.springTall += this.spring * framin;
        }
        if (this.springTall < 12)
        {
            this.springTall = 12;
            this.spring = 0;
        }
        else if (this.springTall / this.originalSpringTall > 1.8)
        {
            this.springTall -= this.spring * Main.framin;
            this.spring = 0;
        }
        scaleX = scaleY = this.springTall / (this.isTall * 2) * this.scale;
    }
    
    public function bossHeadSpringBounce() : Void
    {
        this.spring += (this.originalSpringTall - this.springTall) / this.springy;
        if (Math.abs(this.spring) > this.springThresh)
        {
            this.spring *= 0.8;
        }
        this.springTall += this.spring;
        this.baddie.scaleY = this.springTall / this.originalSpringTall * this.scale;
        this.baddie.scaleX = (this.scale - this.baddie.scaleY + this.scale) * this.makeOne(this.baddie.scaleX);
        this.baddie.y = (this.originalSpringTall - this.springTall) * 0.5;
        StarlingTemporary.setScales(this.bodyCacheN, this.baddie.scaleX, this.baddie.scaleY);
        StarlingTemporary.justGetWithN(this.bodyCacheN).y = this.baddie.y;
    }
    
    public function CheckAllGrounds() : Bool
    {
        var repeat : Int = 0;
        this.moveRL = this.RLx(this.fakeRL);
        this.moveUD = this.RLy(this.fakeRL);
        this.onGround = false;
        repeat = as3hx.Compat.parseInt(Math.floor(this.nowSpeed() * framin / 15) + 1);
        for (i in 0...repeat)
        {
            x += this.moveRL * framin / repeat;
            y += this.moveUD * framin / repeat;
            rotation += this.rotter * framin / repeat;
            this.groundCompY = -200;
            this.onWall = 0;
            this.onWallPlat = 0;
            if (this.CheckAllAutos(this.Status != "Roll"))
            {
                this.onGround = true;
            }
            if (this.CheckThoseGrounds())
            {
                if (this.aPlatOn != null)
                {
                    this.fakeRL += this.platRL;
                    aPlat.aPlatOnClear(this);
                }
                if (this.aWallOn != null)
                {
                    this.fakeRL += this.wallRL;
                    aWall.aWallOnClear(this);
                }
                if (!this.onGround)
                {
                    if (this.platUD != 0)
                    {
                        this.platRL = this.platUD = 0;
                    }
                    if (this.wallUD != 0)
                    {
                        this.wallRL = this.wallUD = 0;
                    }
                }
                this.onGround = true;
            }
            this.checkAfterMove();
            this.lastX = x;
            this.lastY = y;
        }
        return this.onGround;
    }
    
    public function CheckAllAir() : Bool
    {
        this.wallAngle = this.wallRot = 0;
        this.onGround = false;
        var repeat : Int = as3hx.Compat.parseInt(Math.floor(this.nowSpeed() * framin / 15) + 1);
        for (i in 0...repeat)
        {
            x += this.moveRL * framin / repeat;
            y += this.moveUD * framin / repeat;
            rotation += this.rotter * framin / repeat;
            if (rotation > 180)
            {
                rotation -= 360;
            }
            if (rotation < -180)
            {
                rotation += 360;
            }
            if (!this.onGround)
            {
                this.groundCompY = -200;
                this.onWall = 0;
                this.onWallPlat = 0;
                if (this.CheckAllAutos(false))
                {
                    this.onGround = true;
                    canAutoLook = false;
                }
                if (this.CheckWalls(this.moveRL * framin / repeat, this.moveUD * framin / repeat))
                {
                    if (this.onWall * this.moveRL > 0)
                    {
                        if (Math.abs(this.moveRL) > 5 && this.isWide > 10)
                        {
                            this.wallX = x + (this.isWide + 3) * this.onWall;
                            this.wallY = y;
                            this.landPuffs(5 + Math.abs(this.moveRL * 0.2), -1.57 * this.onWall, 0.5 + Math.abs(this.moveRL * 0.02));
                            if (this.bounce > 0)
                            {
                                Sounds.playSound("BadStomp", x, Math.abs(this.moveRL) * 0.03, this.onRail);
                            }
                        }
                        this.fakeRL = this.moveRL;
                        if (Math.abs(this.moveRL) > Math.abs(this.landSpeed))
                        {
                            this.landSpeed = this.moveRL;
                        }
                        this.moveRL *= -this.bounce;
                        this.spring = -Math.abs(this.moveRL);
                        this.resetCombo();
                    }
                }
                this.CheckHeadWalls();
                if (this.CheckGroundAir())
                {
                    this.onGround = true;
                }
                else if (this.CheckGroundWalls(false))
                {
                    this.onGround = true;
                }
                else if (this.CheckGroundPlatforms(false))
                {
                    this.onGround = true;
                }
            }
            if (this.checkAfterMove())
            {
                return false;
            }
            this.lastX = x;
            this.lastY = y;
        }
        if (this.wallRot == 0)
        {
            this.lastGround = "nothing";
        }
        return this.onGround;
    }
    
    public function CheckAllPaused() : Dynamic
    {
        this.wallAngle = this.wallRot = 0;
        this.onWallPlat = 0;
        this.groundCompY = -200;
        if (this.CheckAllAutos(this.onGround))
        {
            this.onGround = true;
            canAutoLook = false;
        }
        if (this.CheckWalls(this.moveRL, this.moveUD))
        {
            if (this.onWall * this.moveRL > 0)
            {
                if (Math.abs(this.moveRL) > 5 && this.isWide > 10)
                {
                    this.wallX = x + (this.isWide + 3) * this.onWall;
                    this.wallY = y;
                    this.landPuffs(5 + Math.abs(this.moveRL * 0.2), -1.57 * this.onWall, 0.5 + Math.abs(this.moveRL * 0.02));
                }
                this.fakeRL = this.moveRL;
                this.moveRL *= -this.bounce;
                this.resetCombo();
            }
        }
        this.CheckHeadWalls();
        if (this.CheckGroundAir())
        {
            this.onGround = true;
        }
        else if (this.CheckGroundWalls(false))
        {
            this.onGround = true;
        }
        else if (this.CheckGroundPlatforms(false))
        {
            this.onGround = true;
        }
        if (this.checkAfterMove())
        {
            return false;
        }
        return this.onGround;
    }
    
    public function CheckAllZip() : Bool
    {
        this.wallAngle = this.wallRot = 0;
        this.onGround = false;
        this.onWallPlat = 0;
        for (i in 0...6)
        {
            x += this.moveRL * framin;
            y += this.moveUD * framin;
            if (rotation > 180)
            {
                rotation -= 360;
            }
            if (rotation < -180)
            {
                rotation += 360;
            }
            if (!this.onGround)
            {
                this.groundCompY = -200;
                if (this.CheckAllAutos(false))
                {
                    this.onGround = true;
                    canAutoLook = false;
                }
                if (this.CheckWalls(this.moveRL * framin / 6, this.moveUD * framin / 6))
                {
                    if (this.onWall * this.moveRL > 0)
                    {
                        if (Math.abs(this.moveRL) > 5 && this.isWide > 10)
                        {
                            this.wallX = x + (this.isWide + 3) * this.onWall;
                            this.wallY = y;
                            this.landPuffs(5 + Math.abs(this.moveRL * 0.2), -1.57 * this.onWall, 0.5 + Math.abs(this.moveRL * 0.02));
                        }
                        this.fakeRL = this.moveRL;
                        if (Math.abs(this.moveRL) > Math.abs(this.landSpeed))
                        {
                            this.landSpeed = this.moveRL;
                        }
                        this.moveRL *= -this.bounce;
                        this.spring = -Math.abs(this.moveRL);
                        this.resetCombo();
                    }
                }
                this.CheckHeadWalls();
                if (this.CheckGroundAir())
                {
                    this.onGround = true;
                }
                else if (this.CheckGroundWalls(false))
                {
                    this.onGround = true;
                }
                else if (this.CheckGroundPlatforms(false))
                {
                    this.onGround = true;
                }
            }
            if (this.checkAfterMove())
            {
                return false;
            }
            this.lastX = x;
            this.lastY = y;
            if (this.smokeN > 0)
            {
                this.smokeN -= Math.abs(this.fakeRL) * framin;
            }
            else
            {
                this.smokeN += 90;
                StarlingEffect.Spawn("inkZipTrail" + as3hx.Compat.parseInt(Math.random() * 3), x, y, rotation * this.quickRadian - 1.57 * scaleX, 1, 0, 0, this.onRail);
            }
        }
        if (this.wallRot == 0)
        {
            this.lastGround = "nothing";
        }
        if (this.onGround)
        {
            if (this.Status == "ZipAir")
            {
                this.Status = "Zip";
            }
        }
        else if (this.Status == "Zip")
        {
            this.Status = "ZipAir";
        }
        return this.onGround;
    }
    
    public function JustMove(eRL : Float, eUD : Float) : Bool
    {
        var repeat : Int = as3hx.Compat.parseInt(Math.floor(getSpeed(eRL, eUD) / 15) + 1);
        this.moveRL = eRL / repeat;
        this.moveUD = eUD / repeat;
        for (i in 0...repeat)
        {
            x += this.moveRL;
            y += this.moveUD;
            if (rotation > 180)
            {
                rotation -= 360;
            }
            if (rotation < -180)
            {
                rotation += 360;
            }
            if (!this.onGround)
            {
                this.groundCompY = -200;
                this.onWall = 0;
                this.onWallPlat = 0;
                if (this.CheckAllAutos(false))
                {
                    this.onGround = true;
                    canAutoLook = false;
                }
                if (this.CheckWalls(eRL / repeat, eUD / repeat))
                {
                }
                this.CheckHeadWalls();
                if (this.CheckGroundAir())
                {
                    this.onGround = true;
                }
                else if (this.CheckGroundWalls(false))
                {
                    this.onGround = true;
                }
                else if (this.CheckGroundPlatforms(false))
                {
                    this.onGround = true;
                }
            }
            this.lastX = x;
            this.lastY = y;
        }
        if (this.wallRot == 0)
        {
            this.lastGround = "nothing";
        }
        this.moveRL = this.moveUD = 0;
        return this.onGround;
    }
    
    public function CheckMovingStuff() : Void
    {
        aWall.CheckWalls(this);
        aPlat.CheckPlats(this);
    }
    
    public function resetOnPlatSides() : Dynamic
    {
        for (i in 0...aPlat.PlatArray.length)
        {
            this.aPlatSides[i] = 0;
        }
    }
    
    public function CheckWalls(eRL : Float, eUD : Float) : Bool
    {
        if (this.checkForWalls(x + this.isWide + 5, y, eUD, this.isTall - 10) && this.checkForWalls(x - this.isWide - 5, y, eUD, this.isTall - 10))
        {
            if (Math.abs(this.moveRL) <= 20)
            {
                return false;
            }
            while (this.checkForWalls(x + this.isWide + 5, y, eUD, this.isTall - 10) && this.checkForWalls(x - this.isWide - 5, y, eUD, this.isTall - 10))
            {
                x += this.RLx(-eRL * 0.1);
                y += this.RLy(-eRL * 0.1);
            }
        }
        if (this.checkForWalls(x + this.isWide + 5, y, eUD, this.isTall - 10) && this.moveRL + this.wallRL + this.platRL + this.groundRL > -10)
        {
            this.onWall = 1;
        }
        if (this.checkForWalls(x - this.isWide - 5, y, eUD, this.isTall - 10) && this.moveRL + this.wallRL + this.platRL + this.groundRL < 10)
        {
            this.onWall = -1;
        }
        if (this.onWall == 0)
        {
            return false;
        }
        this.tempRL = 0;
        while (this.checkForWalls(x + (this.isWide + 1) * this.onWall, y, eUD, this.isTall - 5))
        {
            ++this.tempRL;
            x -= this.onWall;
        }
        if (this.onWallPlat * this.onWall == -1)
        {
            this.squish();
        }
        return true;
    }
    
    public function CheckBallWalls() : Dynamic
    {
        this.onWall = 0;
        if (cast(this.wallsHitTest(x + (this.isWide + 1), y), Bool) && this.moveRL > -5)
        {
            this.onWall = 1;
            this.wallX = x + (this.isWide + 1);
        }
        if (cast(this.wallsHitTest(x - (this.isWide + 1), y), Bool) && this.moveRL < 5)
        {
            this.onWall = -1;
            this.wallX = x - (this.isWide + 1);
        }
        if (this.onWall * this.moveRL > 0)
        {
            while (this.wallsHitTest(this.wallX, y))
            {
                this.wallX -= this.onWall;
            }
            this.ax = x - this.wallX;
            this.ax += this.isWide * this.onWall;
            this.ax *= -this.bounce;
            this.ax -= this.isWide * this.onWall;
            x = this.wallX + this.ax;
            this.fakeRL = this.moveRL;
            this.moveRL *= -this.bounce;
            this.resetCombo();
            return true;
        }
        return false;
    }
    
    public function squish() : Void
    {
    }
    
    public function CheckGroundAir() : Dynamic
    {
        if (this.getGroundRot(false, true))
        {
            this.wallX = this.tempWallX;
            this.wallY = this.tempWallY;
            this.wallAngle = this.tempWallAngle;
            this.wallRot = this.tempWallRot;
            this.groundCompY = this.ay;
            if (Math.abs(this.wallRot) < 80 && this.Status != "Roll")
            {
                if (this.ay > -(this.isTall + 1) && this.aUD > -1 || this.CheckHead())
                {
                    this.lastGround = "ground";
                    this.onLedge = 0;
                    return this.landAngleStuff(false);
                }
                return false;
            }
            if (this.Status == "Roll")
            {
                if (this.ay > -(this.isTall + 10) && this.aUD > -5)
                {
                    this.rotter = (Math.cos(this.wallAngle) * this.moveRL + Math.sin(this.wallAngle) * this.moveUD) * this.rotPerc;
                }
                this.groundRL = this.groundUD = 0;
            }
            if (this.ay > -this.isTall && this.aUD > 0)
            {
                this.lastGround = "ground";
                this.onLedge = 0;
                this.landAngleStuff(false);
                return true;
            }
            return false;
        }
        return false;
    }
    
    private function CheckThoseGrounds() : Bool
    {
        if (this.CheckGroundGround())
        {
            this.lastGround = "ground";
            return true;
        }
        if (this.CheckGroundWalls(true))
        {
            this.lastGround = "walls";
            return true;
        }
        if (this.CheckGroundPlatforms(true))
        {
            this.lastGround = "platforms";
            return true;
        }
        this.lastGround = "nothing";
        return false;
    }
    
    public function CheckGroundGroundSimple() : Dynamic
    {
        if (this.CheckWalls(this.moveRL, this.moveUD))
        {
            if ((this.onWall + this.onWallPlat) * this.facing > 0)
            {
                this.facing *= -1;
                this.spring = 1.5 * this.scale;
            }
            if (this.onWall * this.fakeRL > 0)
            {
                this.fakeRL *= -this.bounce;
            }
        }
        if (this.CheckHead())
        {
            if (this.groundHitTest(x + this.UDx(this.isTall + 20), y + this.UDy(this.isTall + 20)))
            {
                while (!this.groundHitTest(x + this.UDx(this.isTall + this.overReach), y + this.UDy(this.isTall + this.overReach)))
                {
                    x += this.UDx(2);
                    y += this.UDy(2);
                }
            }
        }
        if (this.getGroundRot(true, true))
        {
            if (this.ay < this.groundCompY)
            {
                return false;
            }
            this.wallX = this.tempWallX;
            this.wallY = this.tempWallY;
            this.wallAngle = this.tempWallAngle;
            this.wallRot = this.tempWallRot;
            this.groundCompY = this.ay;
            if (this.aPlatOn != null)
            {
                aPlat.aPlatOnClear(this);
            }
            if (this.aWallOn != null)
            {
                aWall.aWallOnClear(this);
            }
            this.ay = -this.isTall;
            x = this.wallX + (Math.cos(this.wallAngle) * this.ax - Math.sin(this.wallAngle) * this.ay);
            y = this.wallY + (Math.cos(this.wallAngle) * this.ay + Math.sin(this.wallAngle) * this.ax);
            if (this.testAllSimple(x + this.RLx(this.isWide + 20) * this.makeOne(this.fakeRL) + this.UDx(this.isWide + 10), y + this.RLy(this.isWide + 20) * this.makeOne(this.fakeRL) + this.UDy(this.isWide + 10)))
            {
                this.onLedge = 0;
            }
            else
            {
                this.onLedge = this.makeOne(this.fakeRL);
            }
            if (this.fakeRL * this.wallRot > 0 && Math.abs(this.wallRot) > 90 && Math.abs(this.oldWallRot) < 90)
            {
                this.wallAngle = this.makeOne(this.wallRot) * 1.57;
                this.wallRot = this.makeOne(this.wallRot) * 90;
                return false;
            }
            return true;
        }
        return false;
    }
    
    public function CheckGroundGroundChar() : Dynamic
    {
        if (this.CheckWalls(this.moveRL, this.moveUD))
        {
            if (this.moveUD < -5)
            {
                y -= this.tempRL;
                return false;
            }
            if (this.onWall * this.moveRL > 0)
            {
                if (Math.abs(this.moveRL) > 5 && this.isWide > 10)
                {
                    this.wallX = x + (this.isWide + 3) * this.onWall;
                    this.wallY = y;
                    this.landPuffs(5 + Math.abs(this.moveRL * 0.2), -1.57 * this.onWall, 0.5 + Math.abs(this.moveRL * 0.02));
                }
                this.fakeRL = this.moveRL = this.wallRL = this.platRL = 0;
            }
        }
        if (this.CheckHead())
        {
            if (this.groundHitTest(x + this.UDx(this.isTall + 20), y + this.UDy(this.isTall + 20)))
            {
                while (!this.groundHitTest(x + this.UDx(this.isTall + this.overReach), y + this.UDy(this.isTall + this.overReach)))
                {
                    x += this.UDx(2);
                    y += this.UDy(2);
                }
            }
        }
        var temp : Int = as3hx.Compat.parseInt(2 + this.friction * 8);
        if (cast(this.firstCircleCheck(this.footX() + this.RLx(this.isWide * 2) + this.UDx(temp), this.footY() + this.RLy(this.isWide * 2) + this.UDy(temp), this.moveUD), Bool) || cast(this.firstCircleCheck(this.footX() + this.UDx(temp), this.footY() + this.UDy(temp), this.moveUD), Bool) || cast(this.firstCircleCheck(this.footX() + this.RLx(-this.isWide * 2) + this.UDx(temp), this.footY() + this.RLy(-this.isWide * 2) + this.UDy(temp), this.moveUD), Bool))
        {
            this.groundFootR = this.testAllGrounds(this.footX() + this.RLx(this.isWide + Math.abs(this.fakeRL)) + this.UDx(10), this.footY() + this.RLy(this.isWide + Math.abs(this.fakeRL)) + this.UDy(10));
            this.groundFootL = this.testAllGrounds(this.footX() - this.RLx(this.isWide + Math.abs(this.fakeRL)) + this.UDx(10), this.footY() - this.RLy(this.isWide + Math.abs(this.fakeRL)) + this.UDy(10));
            if (this.groundFootR && this.groundFootL || this.lastGround != "ground")
            {
                if (!this.getGroundRot(true, true))
                {
                    return false;
                }
                if (this.wantRL * this.fakeRL <= 0 && Math.abs(this.fakeRL) < 10 && Math.abs(this.wallRot) > 120)
                {
                    return false;
                }
                if (this.ay < this.groundCompY)
                {
                    return false;
                }
                this.wallX = this.tempWallX;
                this.wallY = this.tempWallY;
                this.wallAngle = this.tempWallAngle;
                this.wallRot = this.tempWallRot;
                if (this.aPlatOn != null)
                {
                    aPlat.aPlatOnClear(this);
                }
                if (this.aWallOn != null)
                {
                    aWall.aWallOnClear(this);
                }
                this.ay = -this.isTall;
                x = this.wallX + (Math.cos(this.wallAngle) * this.ax - Math.sin(this.wallAngle) * this.ay);
                y = this.wallY + (Math.cos(this.wallAngle) * this.ay + Math.sin(this.wallAngle) * this.ax);
                this.onLedge = 0;
                if (Math.abs(this.wallRot) > 90 && this.wallRot * this.fakeRL > 0 && rotCompare(this.oldWallRot, this.wallRot) * this.makeOne(this.fakeRL) < -5)
                {
                    return false;
                }
                if (this.fakeRL * this.wallRot > 0 && Math.abs(this.wallRot) > 90 && Math.abs(this.oldWallRot) < 90)
                {
                    this.wallAngle = this.makeOne(this.wallRot) * 1.57;
                    this.wallRot = this.makeOne(this.wallRot) * 90;
                    return false;
                }
                return true;
            }
            if (this.groundFootR || this.groundFootL)
            {
                if (this.groundFootR)
                {
                    this.onLedge = -1;
                }
                else if (this.groundFootL)
                {
                    this.onLedge = 1;
                }
                return true;
            }
            if (this.testAllGrounds(this.footX() + this.UDx(10), this.footY() + this.UDy(10)))
            {
                if (this.getGroundRot(true, true))
                {
                    this.wallX = this.tempWallX;
                    this.wallY = this.tempWallY;
                    this.wallAngle = this.tempWallAngle;
                    this.wallRot = this.tempWallRot;
                    if (this.wantRL * this.fakeRL <= 0 && Math.abs(this.wallRot) > 100)
                    {
                        return false;
                    }
                    this.ay = -this.isTall;
                    x = this.wallX + (Math.cos(this.wallAngle) * this.ax - Math.sin(this.wallAngle) * this.ay);
                    y = this.wallY + (Math.cos(this.wallAngle) * this.ay + Math.sin(this.wallAngle) * this.ax);
                    this.onLedge = 0;
                    return true;
                }
                return false;
            }
            return false;
        }
        return false;
    }
    
    private function engageGroundPlatforms(already : Bool) : Bool
    {
        if (cast(this.platformsHitTest(x - this.isWide, y + this.isTall + 5), Bool) || cast(this.platformsHitTest(x + this.isWide, y + this.isTall + 5), Bool))
        {
            return true;
        }
        if (this.lastGround == "walls")
        {
            return false;
        }
        if (cast(this.platformsHitTest(x - this.isWide, y + this.isTall + 40), Bool) || cast(this.platformsHitTest(x + this.isWide, y + this.isTall + 40), Bool))
        {
            return true;
        }
        return false;
    }
    
    public function CheckGroundPlatforms(alreadyOn : Dynamic) : Bool
    {
        var platWide : Int = 0;
        var i : Int = 0;
        if (this.engageGroundPlatforms(cast(alreadyOn, Bool) && this.lastGround == "platforms"))
        {
            if (cast(alreadyOn, Bool) && this.lastGround == "platforms")
            {
                if (cast(this.groundPlatsAll(x, this.platCacheY1, -this.isWide), Bool) && cast(this.groundPlatsAll(x, this.platCacheY2, this.isWide), Bool))
                {
                    this.onLedge = 0;
                }
                else if (this.groundPlatsAll(x, this.platCacheY1, -this.isWide))
                {
                    this.onLedge = 1;
                }
                else
                {
                    if (!this.groundPlatsAll(x, this.platCacheY2, this.isWide))
                    {
                        return false;
                    }
                    this.onLedge = -1;
                }
            }
            else if (cast(this.groundPlatsAll(x, y + this.isTall, -this.isWide), Bool) && cast(this.groundPlatsAll(x, y + this.isTall, this.isWide), Bool))
            {
                this.onLedge = 0;
            }
            else if (this.groundPlatsAll(x, y + this.isTall, -this.isWide))
            {
                this.onLedge = 1;
            }
            else
            {
                if (!this.groundPlatsAll(x, y + this.isTall, this.isWide))
                {
                    return false;
                }
                this.onLedge = -1;
            }
            if (this.onLedge == 0)
            {
                this.platCacheX1 = x - this.isWide;
                this.platCacheX2 = x + this.isWide;
                if (!(alreadyOn && this.lastGround == "platforms"))
                {
                    this.platCacheY1 = y + this.isTall;
                    this.platCacheY2 = y + this.isTall;
                }
                this.platCacheY1 += this.findPlatPoint(this.platCacheX1, this.platCacheY1);
                this.platCacheY2 += this.findPlatPoint(this.platCacheX2, this.platCacheY2);
            }
            else if (!(cast(alreadyOn, Bool) && this.lastGround == "platforms"))
            {
                if (this.onLedge == 1)
                {
                    platWide = as3hx.Compat.parseInt(this.isWide * 2);
                    this.platCacheX2 = x - this.isWide;
                    this.platCacheY2 = y + this.isTall;
                    this.platCacheY2 += this.findPlatPoint(this.platCacheX2, this.platCacheY2);
                    i = 0;
                    while (i < this.isWide * 2)
                    {
                        platWide -= 5;
                        if (!this.testAllGrounds(this.platCacheX2 + 5, this.platCacheY2 + 20))
                        {
                            break;
                        }
                        this.platCacheX2 += 5;
                        while (this.testAllGrounds(this.platCacheX2, this.platCacheY2 - 1))
                        {
                            --this.platCacheY2;
                        }
                        while (!this.testAllGrounds(this.platCacheX2, this.platCacheY2))
                        {
                            ++this.platCacheY2;
                        }
                        i += 5;
                    }
                    this.platCacheX1 = x - this.isWide;
                    this.platCacheY1 = y + this.isTall;
                    this.platCacheY1 += this.findPlatPoint(this.platCacheX1, this.platCacheY1);
                    i = 0;
                    while (i < platWide)
                    {
                        if (!this.testAllGrounds(this.platCacheX1 - 5, this.platCacheY1 + 20))
                        {
                            break;
                        }
                        this.platCacheX1 -= 5;
                        while (this.testAllGrounds(this.platCacheX1, this.platCacheY1 - 1))
                        {
                            --this.platCacheY1;
                        }
                        while (!this.testAllGrounds(this.platCacheX1, this.platCacheY1))
                        {
                            ++this.platCacheY1;
                        }
                        i += 5;
                    }
                    if (platWide == 0)
                    {
                        this.onLedge = 0;
                    }
                }
                else if (this.onLedge == -1)
                {
                    platWide = as3hx.Compat.parseInt(this.isWide * 2);
                    this.platCacheX1 = x + this.isWide;
                    this.platCacheY1 = y + this.isTall;
                    this.platCacheY1 += this.findPlatPoint(this.platCacheX1, this.platCacheY1);
                    i = 0;
                    while (i < this.isWide * 2)
                    {
                        platWide -= 5;
                        if (!this.testAllGrounds(this.platCacheX1 - 5, this.platCacheY1 + 20))
                        {
                            break;
                        }
                        this.platCacheX1 -= 5;
                        while (this.testAllGrounds(this.platCacheX1, this.platCacheY1 - 1))
                        {
                            --this.platCacheY1;
                        }
                        while (!this.testAllGrounds(this.platCacheX1, this.platCacheY1))
                        {
                            ++this.platCacheY1;
                        }
                        i += 5;
                    }
                    this.platCacheX2 = x + this.isWide;
                    this.platCacheY2 = y + this.isTall;
                    this.platCacheY2 += this.findPlatPoint(this.platCacheX2, this.platCacheY2);
                    i = 0;
                    while (i < platWide)
                    {
                        if (!this.testAllGrounds(this.platCacheX2 + 5, this.platCacheY2 + 20))
                        {
                            break;
                        }
                        this.platCacheX2 += 5;
                        while (this.testAllGrounds(this.platCacheX2, this.platCacheY2 - 1))
                        {
                            --this.platCacheY2;
                        }
                        while (!this.testAllGrounds(this.platCacheX2, this.platCacheY2))
                        {
                            ++this.platCacheY2;
                        }
                        i += 5;
                    }
                    if (platWide == 0)
                    {
                        this.onLedge = 0;
                    }
                }
            }
            this.tempWallRot = -Math.atan2(this.platCacheX2 - this.platCacheX1, this.platCacheY2 - this.platCacheY1) / this.quickRadian + 90;
            this.tempWallX = (this.platCacheX1 + this.platCacheX2) / 2;
            this.tempWallY = (this.platCacheY1 + this.platCacheY2) / 2;
            this.tempWallAngle = this.tempWallRot * this.quickRadian;
            this.ex = x - this.tempWallX;
            this.ey = y - this.tempWallY;
            this.ax = Math.cos(this.tempWallAngle) * this.ex + Math.sin(this.tempWallAngle) * this.ey;
            this.ay = Math.cos(this.tempWallAngle) * this.ey - Math.sin(this.tempWallAngle) * this.ex;
            this.aRL = Math.cos(this.tempWallAngle) * this.moveRL + Math.sin(this.tempWallAngle) * this.moveUD;
            this.aUD = Math.cos(this.tempWallAngle) * this.moveUD - Math.sin(this.tempWallAngle) * this.moveRL;
            if (this.ay < this.groundCompY)
            {
                return false;
            }
            if (-this.ay < this.isTall + 5 && this.aUD > -0.5 && -this.ay + this.aUD * 2 + 2 > this.isTall || cast(alreadyOn, Bool))
            {
                this.lastGround = "platforms";
                this.wallX = this.tempWallX;
                this.wallY = this.tempWallY;
                this.wallAngle = this.tempWallAngle;
                this.wallRot = this.tempWallRot;
                this.landAngleStuff(alreadyOn);
                return true;
            }
            return false;
        }
        return false;
    }
    
    private function findPlatPoint(ex : Dynamic, ey : Dynamic) : Dynamic
    {
        var tempY : Dynamic = 0;
        while (this.testAllGrounds(ex, ey + tempY - 5))
        {
            tempY -= 5;
        }
        while (this.testAllGrounds(ex, ey + tempY - 1))
        {
            tempY--;
        }
        while (!this.testAllGrounds(ex, ey + tempY + 5))
        {
            tempY += 5;
        }
        while (!this.testAllGrounds(ex, ey + tempY))
        {
            tempY++;
        }
        return tempY;
    }
    
    public function CheckAllAutos(ground : Dynamic) : Dynamic
    {
        var tempBool : Bool = false;
        this.platGround = this.platWall = false;
        this.wallGround = this.wallWall = false;
        this.almostPlat = false;
        if (!aWall.WallCollision(x, y, this.moveRL, this.moveUD, this, ground))
        {
            if (this.aWallOn != null)
            {
                if (this.aWallOn.getStatus() == "Mushy")
                {
                    this.oldFakeUD = -12;
                }
                else
                {
                    this.oldFakeUD = this.wallUD;
                }
                aWall.aWallOnClear(this);
            }
            if (this.Status != "Roll" && this.hitPause == 0)
            {
                if (this.wallRL != 0)
                {
                    this.addAutoRL(this.wallRL);
                }
                if (this.wallUD != 0)
                {
                    this.Jumper -= this.wallUD * 0.8;
                    this.moveUD += this.wallUD;
                }
            }
            this.wallRL = 0;
            this.wallUD = 0;
        }
        if (!aPlat.PlatCollision(x, y, this.moveRL, this.moveUD, this, ground))
        {
            if (this.aPlatOn != null)
            {
                aPlat.aPlatOnClear(this);
            }
            if (this.Status != "Roll" && this.hitPause == 0)
            {
                if (this.platRL != 0)
                {
                    this.addAutoRL(this.platRL);
                }
                if (this.platUD != 0)
                {
                    this.Jumper -= this.platUD * 0.8;
                    this.moveUD += this.platUD;
                }
            }
            this.platRL = 0;
            this.platUD = 0;
        }
        this.wasTall = this.isTall;
        return this.platGround || this.wallGround;
    }
    
    public function addAutoRL(rl : Float) : Void
    {
        if (rl * this.fakeRL < -1 || rl * this.wantRL < -1)
        {
            this.fakeRL += rl * 0.8;
        }
        else if (this.wantRL == 0 && this.fakeRL == 0)
        {
            this.fakeRL += rl * 0.8;
        }
        else
        {
            this.fakeRL += rl;
        }
        this.moveRL += rl;
    }
    
    private function platformsSpecialTest(ex : Dynamic, ey : Dynamic) : Dynamic
    {
        return this.platformsHitTest(ex, ey + 5) || this.platformsHitTest(ex, ey + 20);
    }
    
    private function groundPlatsAll(ex : Float, ey : Float, rl : Float) : Dynamic
    {
        return this.platformsHitTest(ex + rl, ey + 20) || this.platformsHitTest(ex + rl, ey + 40) || this.wallsHitTest(ex + rl, ey + 20) || this.groundHitTest(ex + this.RLx(rl), ey + this.RLy(rl) + 20);
    }
    
    public function CheckGroundWalls(alreadyLanded : Dynamic) : Dynamic
    {
        if (this.moveUD < -5)
        {
            return false;
        }
        if (cast(this.wallsHitTest(x + this.isWide, y + this.isTall + 5), Bool) || cast(this.wallsHitTest(x, y + this.isTall + 5), Bool) || cast(this.wallsHitTest(x - this.isWide, y + this.isTall + 5), Bool))
        {
            this.onLedge = 0;
            if (!this.testAll(x - this.isWide, y + this.isTall + 5))
            {
                this.onLedge = -1;
            }
            else if (!this.testAll(x + this.isWide, y + this.isTall + 5))
            {
                this.onLedge = 1;
            }
            this.tempWallX = x;
            this.tempWallY = y + this.isTall + 5;
            while (cast(this.wallsHitTest(x + this.isWide, this.tempWallY), Bool) || cast(this.wallsHitTest(x, this.tempWallY), Bool) || cast(this.wallsHitTest(x - this.isWide, this.tempWallY), Bool))
            {
                --this.tempWallY;
            }
            this.groundCompY = this.ay;
            this.ay = y - this.tempWallY;
            if (this.ay >= -this.isTall && this.moveUD >= 0 || cast(alreadyLanded, Bool))
            {
                this.lastGround = "walls";
                return this.cheapLandAngleStuff(alreadyLanded);
            }
            return false;
        }
        return false;
    }
    
    @:allow()
    private function CheckHeadWalls() : Dynamic
    {
        if (this.moveUD > 0)
        {
            return false;
        }
        if (cast(this.wallsHitTest(x + this.isWide - 2, y - this.isTall), Bool) && cast(!this.wallsHitTest(x + this.isWide - 2, y - this.isTall - this.moveUD + 5), Bool) || cast(this.wallsHitTest(x - this.isWide + 2, y - this.isTall), Bool) && cast(!this.wallsHitTest(x - this.isWide + 2, y - this.isTall - this.moveUD + 5), Bool))
        {
            this.wallX = x;
            this.wallY = y - this.isTall;
            while (cast(this.wallsHitTest(x + this.isWide - 2, this.wallY), Bool) || cast(this.wallsHitTest(x - this.isWide + 2, this.wallY), Bool))
            {
                ++this.wallY;
            }
            this.ay = y - this.wallY;
            this.aUD = this.moveUD;
            this.landSpeed = -this.aUD;
            this.aUD *= -this.bounce;
            if (this.Status == "Roll")
            {
                this.rotter = this.moveRL * this.rotPerc;
            }
            else if (this.ItIs == "Char")
            {
                if (this.landSpeed > 2)
                {
                    Main.shakeScreen(1, 0, true);
                    Sounds.playSound("BadStomp", x, this.landSpeed * 0.2, this.onRail);
                }
            }
            if (this.landSpeed > 5 && this.isWide > 10)
            {
                this.landPuffs(this.landSpeed * 0.4, 3.14, this.isTall / 35);
            }
            if (this.aUD < this.bounceThresh)
            {
                this.ay = this.isTall;
                this.aUD = 0;
            }
            else
            {
                this.ay -= this.isTall;
                this.ay *= -this.bounce;
                this.ay += this.isTall;
            }
            y = this.wallY + this.ay;
            this.FloatUp = true;
            this.moveUD = this.aUD;
            this.resetCombo();
            return true;
        }
        return false;
    }
    
    @:allow()
    private function getGroundRot(onlyGround : Dynamic, firstRun : Dynamic) : Bool
    {
        var i : Int = 0;
        this.tempXTotal = this.tempYTotal = this.rotItems = 0;
        if (this.lastGround == "ground")
        {
            if (this.groundHitTest(x + this.UDx(this.isTall + this.overReach), y + this.UDy(this.isTall + this.overReach)))
            {
                this.tempXTotal = this.tempYTotal = 0;
                this.rotItems = 100;
            }
            else
            {
                for (i in 0...this.BallRes)
                {
                    this.angle = Math.PI * (i + 0.5) * (2 / this.BallRes);
                    this.tempX = -Math.sin(this.angle);
                    this.tempY = Math.cos(this.angle);
                    if (this.groundHitTest(x + this.tempX * (this.isTall + this.overReach), y + this.tempY * (this.isTall + this.overReach)))
                    {
                        ++this.rotItems;
                        this.tempXTotal += this.tempX;
                        this.tempYTotal += this.tempY;
                        if (this.rotItems > this.BallRes * 0.8)
                        {
                            break;
                        }
                    }
                }
            }
        }
        else
        {
            for (i in 0...this.BallRes)
            {
                this.angle = Math.PI * (i + 0.5) * (2 / this.BallRes);
                this.tempX = -Math.sin(this.angle);
                this.tempY = Math.cos(this.angle);
                if (this.firstCircleCheck(x + this.tempX * (this.isTall + this.overReach), y + this.tempY * (this.isTall + this.overReach), this.moveUD))
                {
                    ++this.rotItems;
                    this.tempXTotal += this.tempX;
                    this.tempYTotal += this.tempY;
                    if (this.rotItems > this.BallRes * 0.8)
                    {
                        break;
                    }
                }
            }
        }
        if (this.rotItems == 100)
        {
            this.tempX = -Math.sin(this.angle1);
            this.tempY = Math.cos(this.angle1);
            while (!this.secondCircleCheck(x + this.tempX * (this.isTall + this.overReach) - this.tempY * 5, y + this.tempY * (this.isTall + this.overReach) + this.tempX * 5, this.moveUD))
            {
                this.angle1 += 0.1;
                this.tempX = -Math.sin(this.angle1);
                this.tempY = Math.cos(this.angle1);
            }
            while (this.secondCircleCheck(x + this.tempX * (this.isTall + this.overReach), y + this.tempY * (this.isTall + this.overReach), this.moveUD))
            {
                this.angle1 -= 0.1;
                this.tempX = -Math.sin(this.angle1);
                this.tempY = Math.cos(this.angle1);
                if (this.angle1 < -50)
                {
                    this.moveRL = this.moveUD = this.fakeRL = this.fakeUD = 0;
                    trace("------------- angle1-");
                    while (this.secondCircleCheck(x, y, 0))
                    {
                        --y;
                    }
                    return this.getGroundRot(onlyGround, firstRun);
                }
            }
            this.tempXTotal = this.tempX * (this.isTall + this.overReach);
            this.tempYTotal = this.tempY * (this.isTall + this.overReach);
            this.tempX = -Math.sin(this.angle2);
            this.tempY = Math.cos(this.angle2);
            while (!this.secondCircleCheck(x + this.tempX * (this.isTall + this.overReach) + this.tempY * 5, y + this.tempY * (this.isTall + this.overReach) - this.tempX * 5, this.moveUD))
            {
                this.angle2 -= 0.1;
                this.tempX = -Math.sin(this.angle2);
                this.tempY = Math.cos(this.angle2);
            }
            while (this.secondCircleCheck(x + this.tempX * (this.isTall + this.overReach), y + this.tempY * (this.isTall + this.overReach), this.moveUD))
            {
                this.angle2 += 0.1;
                this.tempX = -Math.sin(this.angle2);
                this.tempY = Math.cos(this.angle2);
                if (this.angle2 > 50)
                {
                    trace("------------- angle2+");
                    return this.getGroundRot(onlyGround, firstRun);
                }
            }
            this.ex = this.tempX * (this.isTall + this.overReach) - this.tempXTotal;
            this.ey = this.tempY * (this.isTall + this.overReach) - this.tempYTotal;
            this.tempWallAngle = -Math.atan2(this.ex, this.ey) - 1.57;
            this.tempWallRot = this.tempWallAngle / this.quickRadian;
        }
        else
        {
            if (this.rotItems > this.BallRes * 0.8)
            {
                trace("toofast");
                if (Math.abs(this.moveRL) < 10 && Math.abs(this.moveUD) < 10)
                {
                    y -= 5;
                }
                else
                {
                    x -= this.moveRL * 0.2;
                    y -= this.moveUD * 0.2;
                }
                return this.getGroundRot(onlyGround, firstRun);
            }
            if (this.rotItems <= 0)
            {
                this.almostGround = false;
                return false;
            }
            this.angle = -Math.atan2(this.tempXTotal / this.rotItems, this.tempYTotal / this.rotItems);
            this.tempX = -Math.sin(this.angle);
            this.tempY = Math.cos(this.angle);
            this.angle1 = this.angle;
            while (this.secondCircleCheck(x + this.tempX * (this.isTall + this.overReach), y + this.tempY * (this.isTall + this.overReach), this.moveUD))
            {
                this.angle1 -= 0.2;
                this.tempX = -Math.sin(this.angle1);
                this.tempY = Math.cos(this.angle1);
            }
            this.tempXTotal = this.tempX * (this.isTall + this.overReach);
            this.tempYTotal = this.tempY * (this.isTall + this.overReach);
            this.tempX = -Math.sin(this.angle);
            this.tempY = Math.cos(this.angle);
            this.angle2 = this.angle;
            while (this.secondCircleCheck(x + this.tempX * (this.isTall + this.overReach), y + this.tempY * (this.isTall + this.overReach), this.moveUD))
            {
                this.angle2 += 0.2;
                this.tempX = -Math.sin(this.angle2);
                this.tempY = Math.cos(this.angle2);
            }
            this.ex = this.tempX * (this.isTall + this.overReach) - this.tempXTotal;
            this.ey = this.tempY * (this.isTall + this.overReach) - this.tempYTotal;
            this.tempWallAngle = -Math.atan2(this.ex, this.ey) - 1.57;
            this.tempWallRot = this.tempWallAngle / this.quickRadian;
        }
        if (this.tempWallRot < -180)
        {
            this.tempWallRot += 360;
        }
        this.tempWallX = x + this.rotX(this.isTall + 2, this.tempWallRot + 180);
        this.tempWallY = y + this.rotY(this.isTall + 2, this.tempWallRot + 180);
        this.tempX = Math.sin(this.tempWallAngle);
        this.tempY = Math.cos(this.tempWallAngle);
        while (this.secondCircleCheck(this.tempWallX + this.tempX, this.tempWallY - this.tempY, this.moveUD))
        {
            this.tempWallX += this.tempX;
            this.tempWallY -= this.tempY;
        }
        if (firstRun != null)
        {
            this.aRL = this.tempY * this.moveRL + this.tempX * this.moveUD;
            this.aUD = this.tempY * this.moveUD - this.tempX * this.moveRL;
            if (Math.cos(this.tempWallAngle) * this.moveUD - Math.sin(this.tempWallAngle) * this.moveRL > 0 || cast(onlyGround, Bool))
            {
                if (aGround.CheckGrounds(this.tempWallX - this.tempX * 10, this.tempWallY + this.tempY * 10, this))
                {
                    return this.getGroundRot(onlyGround, false);
                }
                if (this.Status != "Roll")
                {
                    if (this.groundRL != 0 || this.groundUD != 0)
                    {
                        this.fakeRL += this.groundRL;
                        eRL = Math.cos(this.tempWallAngle) * this.groundRL - Math.sin(this.tempWallAngle) * this.groundUD;
                        eUD = Math.cos(this.tempWallAngle) * this.groundUD + Math.sin(this.tempWallAngle) * this.groundRL;
                        this.moveRL += eRL;
                        this.moveUD += eUD;
                        this.groundRL = this.groundUD = 0;
                        return this.getGroundRot(onlyGround, false);
                    }
                }
            }
        }
        this.ex = x - this.tempWallX;
        this.ey = y - this.tempWallY;
        this.ax = this.tempY * this.ex + this.tempX * this.ey;
        this.ay = this.tempY * this.ey - this.tempX * this.ex;
        this.aRL = this.tempY * this.moveRL + this.tempX * this.moveUD;
        this.aUD = this.tempY * this.moveUD - this.tempX * this.moveRL;
        this.almostGround = true;
        return true;
    }
    
    @:allow()
    private function getCustomRot(e : Dynamic) : Dynamic
    {
        var i : Int = 0;
        var rot : Float = Math.NaN;
        this.tempXTotal = this.tempYTotal = this.rotItems = 0;
        for (i in 0...this.BallRes)
        {
            this.angle = Math.PI * (i + 0.5) * (2 / this.BallRes);
            this.tempX = -Math.sin(this.angle);
            this.tempY = Math.cos(this.angle);
            if (e.hitTestPoint(x + this.tempX * (this.isTall + 20), y + this.tempY * (this.isTall + 20), true))
            {
                ++this.rotItems;
                this.tempXTotal += this.tempX;
                this.tempYTotal += this.tempY;
                if (this.rotItems > this.BallRes * 0.8)
                {
                    break;
                }
            }
        }
        if (this.rotItems > 0)
        {
            this.angle = -Math.atan2(this.tempXTotal / this.rotItems, this.tempYTotal / this.rotItems);
            this.tempX = -Math.sin(this.angle);
            this.tempY = Math.cos(this.angle);
            this.angle1 = this.angle;
            while (e.hitTestPoint(x + this.tempX * (this.isTall + 20), y + this.tempY * (this.isTall + 20), true))
            {
                this.angle1 -= 0.1;
                this.tempX = -Math.sin(this.angle1);
                this.tempY = Math.cos(this.angle1);
            }
            this.tempXTotal = x + this.tempX * (this.isTall + 20);
            this.tempYTotal = y + this.tempY * (this.isTall + 20);
            this.tempX = -Math.sin(this.angle);
            this.tempY = Math.cos(this.angle);
            this.angle2 = this.angle;
            while (e.hitTestPoint(x + this.tempX * (this.isTall + 20), y + this.tempY * (this.isTall + 20), true))
            {
                this.angle2 += 0.1;
                this.tempX = -Math.sin(this.angle2);
                this.tempY = Math.cos(this.angle2);
            }
            this.ex = x + this.tempX * (this.isTall + 20) - this.tempXTotal;
            this.ey = y + this.tempY * (this.isTall + 20) - this.tempYTotal;
            this.tempWallRot = -Math.atan2(this.ex, this.ey) / this.quickRadian - 90;
            if (this.tempWallRot < -180)
            {
                this.tempWallRot += 360;
            }
            return this.tempWallRot;
        }
        return false;
    }
    
    @:allow()
    private function testAllGrounds(ex : Dynamic, ey : Dynamic) : Bool
    {
        if (this.groundHitTest(ex, ey))
        {
            return true;
        }
        if (this.platformsHitTest(ex, ey))
        {
            return true;
        }
        if (cast(this.wallsHitTest(ex, ey), Bool) && !this.wallsHitTest(ex, y))
        {
            return true;
        }
        return false;
    }
    
    private function testAllSimple(ex : Dynamic, ey : Dynamic) : Bool
    {
        if (this.groundHitTest(ex, ey))
        {
            return true;
        }
        if (this.platformsHitTest(ex, ey))
        {
            return true;
        }
        if (this.wallsHitTest(ex, ey))
        {
            return true;
        }
        return false;
    }
    
    @:allow()
    private function checkForWalls(ex : Dynamic, ey : Dynamic, eUD : Dynamic, tall : Dynamic) : Bool
    {
        if (cast(this.wallsHitTest(ex, ey - tall), Bool) && cast(this.wallsHitTest(ex, ey - tall - eUD), Bool))
        {
            return true;
        }
        if (cast(this.wallsHitTest(ex, ey), Bool) && cast(this.wallsHitTest(ex, ey - eUD), Bool))
        {
            return true;
        }
        if (cast(this.wallsHitTest(ex, ey + tall), Bool) && cast(this.wallsHitTest(ex, ey + tall - eUD), Bool))
        {
            return true;
        }
        return false;
    }
    
    @:allow()
    private function checkForWallsRail(ex : Dynamic, ey : Dynamic, eRL : Dynamic, eUD : Dynamic, rail : Dynamic) : Bool
    {
        if (cast(Main.AllEverything["walls" + rail].hitTestPoint(ex, ey - eUD, true), Bool) && cast(Main.AllEverything["walls" + rail].hitTestPoint(ex, ey - eUD - eRL, true), Bool))
        {
            return true;
        }
        if (cast(Main.AllEverything["walls" + rail].hitTestPoint(ex, ey + eUD, true), Bool) && cast(Main.AllEverything["walls" + rail].hitTestPoint(ex, ey + eUD - eRL, true), Bool))
        {
            return true;
        }
        return false;
    }
    
    @:allow()
    private function landAngleStuff(ground : Dynamic) : Bool
    {
        this.landSpeed = this.aUD;
        this.cheatSpeed = this.moveRL;
        this.alreadyOnGround = true;
        if (this.landSpeed > 5)
        {
            if (this.isWide > 10)
            {
                this.landPuffs(this.landSpeed * 0.4, this.wallAngle, this.isTall / 35);
            }
            else
            {
                StarlingEffect.Spawn("smokePuff", this.wallX, this.wallY, this.wallAngle, 0.25 + Math.random() * 0.3, this.UDx(-3), this.UDy(-3), this.onRail);
            }
        }
        if (this.hitPause > 0 || this.dontLand && this.moveUD < 0)
        {
            x = this.wallX + (Math.cos(this.wallAngle) * this.ax - Math.sin(this.wallAngle) * this.ay);
            y = this.wallY + (Math.cos(this.wallAngle) * this.ay + Math.sin(this.wallAngle) * this.ax);
            this.aUD *= -1;
            this.moveRL = Math.cos(this.wallAngle) * this.aRL - Math.sin(this.wallAngle) * this.aUD;
            this.moveUD = Math.cos(this.wallAngle) * this.aUD + Math.sin(this.wallAngle) * this.aRL;
            return false;
        }
        if (this.Status == "Stomp")
        {
            return true;
        }
        this.aUD *= -this.bounce;
        if (this.Status == "Roll")
        {
            this.rotter = this.aRL * this.rotPerc;
        }
        if (-this.aUD < this.bounceThresh && Math.abs(this.wallRot) < 80)
        {
            this.ay = -this.isTall;
            this.aUD = 0;
        }
        else
        {
            this.spring = this.aUD / 2;
            this.ay += this.isTall;
            this.ay *= -this.bounce;
            this.ay -= this.isTall;
            if (this.isWide > 10)
            {
                if (this.mass > 80)
                {
                    Sounds.playSound("Hit", x, this.landSpeed * 0.03, this.onRail);
                }
                else
                {
                    Sounds.playSound("BadStomp", x, this.landSpeed * 0.2, this.onRail);
                }
            }
        }
        if (0.6108652381980153 > 1.5707963267948966 - Math.abs(angleCompare(this.wallAngle, -Math.atan2(this.moveRL, this.moveUD))))
        {
            this.fakeRL = this.nowSpeed() * this.makeOne(this.aRL);
            this.fakeUD = 0;
        }
        else
        {
            this.fakeRL = this.aRL;
            this.fakeUD = this.aUD;
        }
        x = this.wallX + (Math.cos(this.wallAngle) * this.ax - Math.sin(this.wallAngle) * this.ay);
        y = this.wallY + (Math.cos(this.wallAngle) * this.ay + Math.sin(this.wallAngle) * this.ax);
        this.moveRL = Math.cos(this.wallAngle) * this.aRL - Math.sin(this.wallAngle) * this.aUD;
        this.moveUD = Math.cos(this.wallAngle) * this.aUD + Math.sin(this.wallAngle) * this.aRL;
        this.resetCombo();
        return this.aUD == 0;
    }
    
    @:allow()
    private function cheapLandAngleStuff(ground : Bool = false) : Dynamic
    {
        this.wallAngle = this.wallRot = 0;
        this.wallX = this.tempWallX;
        this.wallY = this.tempWallY;
        this.aRL = this.moveRL;
        this.aUD = this.moveUD;
        this.cheatSpeed = this.moveRL;
        this.aUD -= this.wallUD;
        this.landSpeed = this.aUD;
        this.aUD *= -this.bounce;
        this.aUD += this.wallUD;
        if (!ground && this.landSpeed > 5 && this.isWide > 10)
        {
            this.landPuffs(this.landSpeed * 0.4, 0, this.isTall / 35);
        }
        if (this.Status == "Roll")
        {
            this.rotter = this.aRL * this.rotPerc;
        }
        this.fakeRL = this.moveRL = this.aRL;
        this.resetCombo();
        if (this.hitPause > 0)
        {
            this.ay = -this.isTall;
            y = this.wallY + this.ay;
            return;
        }
        if (-this.aUD < this.bounceThresh)
        {
            this.ay = -this.isTall;
            this.fakeUD = this.moveUD = this.aUD = 0;
            y = this.wallY + this.ay;
            return true;
        }
        this.ay += this.isTall;
        this.ay *= -this.bounce;
        this.ay -= this.isTall;
        this.fakeUD = this.moveUD = this.aUD;
        y = this.wallY + this.ay;
        if (this.isWide > 10)
        {
            Sounds.playSound("BadStomp", x, this.landSpeed * 0.2, this.onRail);
        }
        return false;
    }
    
    @:allow()
    private function testOnlyGround(ex : Dynamic, ey : Dynamic) : Dynamic
    {
        return this.groundHitTest(ex, ey);
    }
    
    @:allow()
    private function testAllButPlats(ex : Dynamic, ey : Dynamic) : Dynamic
    {
        if (this.groundHitTest(ex, ey))
        {
            return true;
        }
        if (this.wallsHitTest(ex, ey))
        {
            return true;
        }
        return false;
    }
    
    @:allow()
    private function testAll(ex : Dynamic, ey : Dynamic) : Dynamic
    {
        if (this.groundHitTest(ex, ey))
        {
            return true;
        }
        if (this.platformsHitTest(ex, ey))
        {
            return true;
        }
        if (this.wallsHitTest(ex, ey))
        {
            return true;
        }
        return false;
    }
    
    public function standardBeABall(ex : Dynamic, ey : Dynamic, eRL : Dynamic, eUD : Dynamic, ax : Dynamic, ay : Dynamic, char : Dynamic) : String
    {
        this.distRL = x - ex;
        this.distUD = y - ey;
        this.angle = char.wallAngle;
        ax = Math.cos(this.angle) * this.distRL + Math.sin(this.angle) * this.distUD;
        ay = Math.cos(this.angle) * this.distUD - Math.sin(this.angle) * this.distRL;
        if (Math.abs(ay) > this.isTall + char.isTall)
        {
            return "nothing";
        }
        if (char.Jumper > 0)
        {
            this.angle = char.wallAngle;
            ax = this.makeOne(ax) * 6;
            this.moveRL = Math.cos(this.angle) * ax - Math.sin(this.angle) * (-char.Jumper * 1.5);
            this.moveUD = Math.cos(this.angle) * (-char.Jumper * 1.5) + Math.sin(this.angle) * ax;
            x += this.moveRL;
            y += this.moveUD;
            this.rotter = Math.abs(this.moveUD) * 1 * this.makeOne(this.moveRL);
            this.hitPause = char.hitPause = 2;
            this.hurtPower = 40;
            this.downTime = 5;
            this.spring = 5;
            Main.shakeScreen(4, 0, true);
            return "Hit";
        }
        if (char.Status == "Jump")
        {
            if (Math.abs(ax) < this.isWide + char.isWide + 5)
            {
                Main.shakeScreen(2 + Math.abs(-eUD + this.moveUD) * 0.1, 0, true);
                this.moveRL = (x - ex) / 10 + eRL;
                this.moveUD -= eUD;
                this.moveUD *= -0.2;
                this.moveUD += eUD;
                this.moveUD = -(Math.abs(this.moveUD) + 5);
                this.FloatUp = char.FloatUp;
                this.rotter = Math.abs(this.moveUD) * 3 * this.makeOne(this.moveRL);
                this.spring = -5;
                this.hurtPower = 40;
                this.downTime = 10;
                this.shakeRL = 10;
                this.moveRL += 5 * char.wantRL;
                if (char.moveUD < 0)
                {
                    char.moveUD += 5;
                }
                this.addToFollow(30, ex, ey);
                return "Hit";
            }
            return "nothing";
        }
        if (char.isTall < 20)
        {
            if (Math.abs(eRL) > 5)
            {
                this.fakeRL = 0;
                this.tempUD = -(20 + Math.abs(eRL * 0.5));
                Main.shakeScreen(-this.tempUD / 5, 0, true);
                this.shakeRL = -this.tempUD * 0.5;
                this.moveRL = Math.cos(this.wallAngle) * this.fakeRL - Math.sin(this.wallAngle) * this.tempUD;
                this.moveUD = Math.cos(this.wallAngle) * this.tempUD + Math.sin(this.wallAngle) * this.fakeRL;
                this.hurtPower = 20;
                this.rotter = this.tempUD * char.scaleX * 3;
                this.downTime = 5;
                return "Hit";
            }
            this.distRL = x - char.x;
            this.distUD = y - char.y;
            this.angle = (-Math.atan2(this.distRL, this.distUD) / this.quickRadian + 180) * this.quickRadian;
            this.tempRL = Math.cos(this.angle) * this.moveRL + Math.sin(this.angle) * this.moveUD;
            this.tempUD = Math.cos(this.angle) * this.moveUD - Math.sin(this.angle) * this.moveRL;
            Main.shakeScreen(this.tempUD / 5, 0, true);
            this.tempUD *= -0.8;
            this.hurtPower = 20;
            ax = Math.cos(this.angle) * this.distRL + Math.sin(this.angle) * this.distUD;
            ay = Math.cos(this.angle) * this.distUD - Math.sin(this.angle) * this.distRL;
            if (ay > -(char.isTall + this.isTall))
            {
                ay = -(char.isTall + this.isTall);
            }
            x = char.x + (Math.cos(this.angle) * ax - Math.sin(this.angle) * ay);
            y = char.y + (Math.cos(this.angle) * ay + Math.sin(this.angle) * ax);
            this.moveRL = Math.cos(this.angle) * this.tempRL - Math.sin(this.angle) * this.tempUD;
            this.moveUD = Math.cos(this.angle) * this.tempUD + Math.sin(this.angle) * this.tempRL;
            if (this.tempUD < -5)
            {
                this.hurtPower = 20;
                this.rotter = this.tempUD * char.scaleX * 3;
                this.downTime = 5;
                return "Hit";
            }
        }
        else
        {
            if (Math.abs(ax) >= this.isWide + char.isWide)
            {
                return "nothing";
            }
            if (ay > -20)
            {
                if ((this.moveRL - eRL) * ax <= 0)
                {
                    ax = (this.isWide + char.isWide) * this.makeOne(ax);
                }
                if (this.canBowlOver && Math.abs(this.moveRL) > Math.abs(eRL) && Math.abs(this.moveRL) > 5 && ax * this.moveRL < 0)
                {
                    if (char.downTime == 0)
                    {
                        char.downTime = 30;
                        this.tempRL = this.moveRL * 0.5;
                        this.tempUD = -char.smashKnockback(10 + Math.abs(this.moveRL));
                        char.rotter = -this.moveRL * 1.5;
                        char.damageChar(10 + Math.abs(this.moveRL));
                        this.angle = char.wallRot * (Math.PI / 180);
                        Sounds.playSound("BadStomp", x, Math.abs(this.fakeRL) * 0.2, this.onRail);
                        char.hurtChar(0, 20, 1, Math.cos(this.angle) * this.tempRL - Math.sin(this.angle) * this.tempUD, -(Math.cos(this.angle) * this.tempUD + Math.sin(this.angle) * this.tempRL), true, false, false);
                        if (Math.abs(this.fakeRL) < 15)
                        {
                            this.moveUD -= 5;
                            this.moveRL *= -1;
                        }
                    }
                }
                else
                {
                    if (char.Status == "Kick")
                    {
                        this.tempRL = eRL * 1.5;
                        this.tempUD = -(12 + Math.abs(eRL));
                        this.angle = char.rotation * this.quickRadian;
                        this.moveRL = Math.cos(this.angle) * this.tempRL - Math.sin(this.angle) * this.tempUD;
                        this.moveUD = Math.cos(this.angle) * this.tempUD + Math.sin(this.angle) * this.tempRL;
                        this.rotter = this.moveRL * 3;
                        this.hurtPower = 20;
                        this.shakeRL = -this.tempUD;
                        Main.shakeScreen(-this.tempUD / 10, 0, true);
                        char.moveUD = -10;
                        char.FloatUp = 2;
                        char.char.gotoAndStop(1);
                        char.placeHead(char.char);
                        this.downTime = 5;
                        this.hitPause = char.hitPause = 2;
                        return "Hit";
                    }
                    if (char.wantRL * eRL > 0 && Math.abs(char.fakeRL) > 5 && ax * char.wantRL > 0 && char.Status != "Pencil" && char.Status != "PencilAir")
                    {
                        this.tempRL = eRL * 2;
                        this.tempUD = -(18 + Math.abs(eRL) * 0.5);
                        if (Math.abs(rotation) > 30)
                        {
                            this.angle = char.rotation * this.quickRadian;
                        }
                        else
                        {
                            this.angle = 0;
                        }
                        this.distRL = x - char.x;
                        this.distUD = y - char.y;
                        this.hurtPower = 30;
                        this.spring = -this.tempUD * 0.25;
                        char.fakeRL *= 0.75;
                        char.moveRL *= 0.75;
                        char.Jumper = 12;
                        char.FloatUp = 2;
                        char.gotoBuffer = "Kick";
                        this.downTime = 10;
                        Main.shakeScreen(12 * char.scaleX, 0, true);
                        this.shakeRL = 20 * char.scaleX;
                        this.moveRL = Math.cos(this.angle) * this.tempRL - Math.sin(this.angle) * this.tempUD;
                        this.moveUD = Math.cos(this.angle) * this.tempUD + Math.sin(this.angle) * this.tempRL;
                        this.rotter = this.moveRL * 3;
                        this.hitPause = char.hitPause = 1;
                        return "Hit";
                    }
                    this.angle = char.rotation * this.quickRadian;
                    this.fakeRL = Math.cos(this.angle) * this.moveRL + Math.sin(this.angle) * this.moveUD;
                    if ((this.fakeRL - eRL) * ax > 0)
                    {
                        return "nothing";
                    }
                    this.fakeRL -= eRL;
                    Main.shakeScreen(this.fakeRL * 0.2, 0, true);
                    Sounds.playSound("BadStomp", x, Math.abs(this.fakeRL) * 0.03, this.onRail);
                    this.fakeRL *= -0.5;
                    this.fakeRL += eRL;
                    this.downTime = 5;
                    this.moveRL = Math.cos(this.angle) * this.fakeRL;
                    this.moveUD = Math.sin(this.angle) * this.fakeRL;
                    this.hurtPower = 0;
                }
            }
            else
            {
                this.distRL = x - char.x;
                this.distUD = y - (char.y + char.isTall);
                this.angle = (-Math.atan2(this.distRL, this.distUD) / this.quickRadian + 180) * this.quickRadian;
                ax = Math.cos(this.angle) * this.distRL + Math.sin(this.angle) * this.distUD;
                ay = Math.cos(this.angle) * this.distUD - Math.sin(this.angle) * this.distRL;
                if (ay > -(char.isTall + this.isTall) * 1.6)
                {
                    ay = -(char.isTall + this.isTall) * 1.6;
                }
                x = char.x + (Math.cos(this.angle) * ax - Math.sin(this.angle) * ay);
                y = char.y + char.isTall + (Math.cos(this.angle) * ay + Math.sin(this.angle) * ax);
                Main.shakeScreen(2 + Math.abs(-eUD + this.moveUD) * 0.1, 0, true);
                if (Math.abs(eRL) >= 5)
                {
                    this.angle = (char.wallRot + 45 * this.makeOne(eRL)) * this.quickRadian;
                    this.fakeRL = 0;
                    this.tempUD = -Math.abs(eRL) * 1.5;
                    this.hurtPower = 20;
                    this.moveRL = Math.cos(this.angle) * this.fakeRL - Math.sin(this.angle) * this.tempUD;
                    this.moveUD = Math.cos(this.angle) * this.tempUD + Math.sin(this.angle) * this.fakeRL;
                    this.rotter = this.moveRL * 3;
                    this.downTime = 5;
                    return "Hit";
                }
                this.tempRL = Math.cos(this.angle) * this.moveRL + Math.sin(this.angle) * this.moveUD;
                this.tempUD = Math.cos(this.angle) * this.moveUD - Math.sin(this.angle) * this.moveRL;
                this.tempUD *= -0.8;
                this.downTime = 20;
                if (this.tempUD < 0)
                {
                    this.moveRL = Math.cos(this.angle) * this.tempRL - Math.sin(this.angle) * this.tempUD;
                    this.moveUD = Math.cos(this.angle) * this.tempUD + Math.sin(this.angle) * this.tempRL;
                    this.rotter = this.tempUD * char.scaleX * 3;
                    this.hitPause = char.hitPause = 1;
                    this.hurtPower = 20;
                    return "Hit";
                }
                this.hurtPower = 60;
                this.spring = Math.abs(eRL) * 0.2;
                this.downTime = Math.abs(eRL);
                this.moveRL += 7 * char.wantRL;
                this.rotter = this.moveRL * 3;
            }
            this.CheckBallWalls();
            this.groundCompY = -200;
            this.CheckAllAutos(false);
            this.CheckGroundAir();
            this.CheckGroundPlatforms(false);
            if (this.onWall != 0)
            {
                this.distRL = x - char.x;
                this.distUD = y - char.y;
                this.angle = char.wallAngle;
                ax = Math.cos(this.angle) * this.distRL + Math.sin(this.angle) * this.distUD;
                ay = Math.cos(this.angle) * this.distUD - Math.sin(this.angle) * this.distRL;
                if (Math.abs(ax) < char.isWide + this.isWide)
                {
                    ax = (char.isWide + this.isWide) * -this.onWall;
                    char.x = x + (Math.cos(this.angle) * ax - Math.sin(this.angle) * ay);
                    char.y = y + (Math.cos(this.angle) * ay + Math.sin(this.angle) * ax);
                    char.fakeRL = char.moveRL = this.moveRL = this.fakeRL = 0;
                }
            }
        }
    }
    
    public function getAttackedShared(ex : Dynamic, ey : Dynamic, angle : Dynamic, char : Dynamic, hitMove : Dynamic, hitPower : Dynamic) : Float
    {
        this.shakeRL = this.smashKnockback(hitPower) + 10;
        if (hitMove == "PokeDown")
        {
            char.hitPause = 2;
        }
        this.downTime = 4;
        if (hitPower < this.launchThresh && this.health > 0 && this.Status != "Fly" && this.onGround)
        {
            if (this.inky)
            {
                this.fakeRL = this.moveRL = hitPower * this.makeOne(x - ex);
                this.fakeUD = this.moveUD = 0;
            }
        }
        else
        {
            this.rotter = hitPower * char.scaleX * 3;
            if (this.health == 0 && Math.abs(this.rotter) < 80)
            {
                this.rotter = this.makeOne(this.rotter) * 80;
            }
            if (false && this.ItIs == "Char" && this.isSmash)
            {
                if (hitPower < 18)
                {
                    this.tempUD = -(hitPower * 0.5 + 10) * this.smashKnockback() * 0.75;
                }
                else
                {
                    this.tempUD = -(hitPower * 0.5 + 10) * this.smashKnockback();
                }
            }
            else if (hitMove == "SwipeUp")
            {
                this.tempUD = -hitPower * 1.2;
                if (this.health > 0 && this.Status != "Jump")
                {
                    this.tempUD *= 1.5;
                }
            }
            else if (hitPower < 20)
            {
                if (this.health == 0)
                {
                    this.tempUD = -hitPower;
                }
                else
                {
                    this.tempUD = -hitPower * 0.6;
                }
            }
            else if (hitPower < 25)
            {
                this.tempUD = -hitPower * 1.2;
            }
            else
            {
                this.tempUD = -hitPower;
            }
            this.tempUD = -this.smashKnockback(-this.tempUD, hitPower);
            this.fakeRL = this.moveRL = -Math.sin(angle) * this.tempUD;
            this.fakeUD = this.moveUD = Math.cos(angle) * this.tempUD;
            if (this.onGround && this.moveUD > 0)
            {
                this.fakeRL = Math.cos(this.wallAngle) * this.moveRL + Math.sin(this.wallAngle) * this.tempUD;
                this.fakeUD = -15;
                this.moveRL = Math.cos(this.wallAngle) * this.fakeUD - Math.sin(this.wallAngle) * this.fakeUD;
                this.moveUD = Math.cos(this.wallAngle) * this.fakeUD + Math.sin(this.wallAngle) * this.fakeUD;
            }
            if (hitPower < 20)
            {
                this.moveRL += char.moveRL * 0.8;
            }
        }
        return -this.tempUD;
    }
    
    public function smashKnockback(e : Float, hit : Float = 0) : Float
    {
        return e;
    }
    
    @:allow()
    private function footSlide(ex : Dynamic, ey : Dynamic, esX : Dynamic, rot : Dynamic, eRL : Dynamic, eslip : Dynamic) : Dynamic
    {
        var rand : Float = Math.NaN;
        if (this.smokeN > 0)
        {
            this.smokeN -= Math.abs(eRL) * 0.5;
        }
        else
        {
            rand = 0.1 + Math.random() * 0.4 + Math.abs(eRL) * 0.02;
            rot -= scaleX * (0.1 + Math.random() * 1);
            StarlingEffect.Spawn("smokePuff", ex, ey, rot, -scaleX * rand, this.RLx(this.groundRL) + this.UDx(-3 * rand), this.RLy(this.groundRL) + this.UDy(-3 * rand), this.onRail);
            this.smokeN = 20;
        }
    }
    
    @:allow()
    private function landPuffs(land : Dynamic, rot : Dynamic, scale : Dynamic, up : Int = 0) : Dynamic
    {
        var xUD : Float = this.rotXRand((-2 + up) * scale, rot + 3.14);
        var yUD : Float = this.rotYRand((-2 + up) * scale, rot + 3.14);
        if (this.onLedge < 1)
        {
            StarlingEffect.Spawn("smokePuff", this.wallX + xUD, this.wallY + yUD, rot + 0.7, scale, this.rotXRand(land * scale, rot + 1.57) + xUD, this.rotYRand(land * scale, rot + 1.57) + yUD, this.onRail);
            StarlingEffect.Spawn("smokePuff", this.wallX + xUD, this.wallY + yUD, rot + 0.35, scale * 0.5, (this.rotXRand(land * scale, rot + 1.57) + xUD) * 0.5, (this.rotYRand(land * scale, rot + 1.57) + yUD) * 0.5, this.onRail);
        }
        if (this.onLedge > -1)
        {
            StarlingEffect.Spawn("smokePuff", this.wallX + xUD, this.wallY + yUD, rot - 0.7, -scale, -this.rotXRand(land * scale, rot + 1.57) + xUD, -this.rotYRand(land * scale, rot + 1.57) + yUD, this.onRail);
            StarlingEffect.Spawn("smokePuff", this.wallX + xUD, this.wallY + yUD, rot - 0.35, -scale * 0.5, (-this.rotXRand(land * scale, rot + 1.57) + xUD) * 0.5, (-this.rotYRand(land * scale, rot + 1.57) + yUD) * 0.5, this.onRail);
        }
    }
    
    public function RotToAccel(rot : Dynamic) : Dynamic
    {
        this.rotAccel = Math.sin(rot * this.quickRadian);
        this.friction = Math.abs(Math.cos(rot * this.quickRadian));
    }
    
    public function normalSlow() : Dynamic
    {
        if (Math.abs(this.fakeRL) > 0.5 * this.friction)
        {
            this.fakeRL -= this.makeOne(this.fakeRL) * 0.5 * this.friction;
        }
        else
        {
            this.fakeRL = 0;
        }
    }
    
    public function slideSlow(e : Dynamic) : Dynamic
    {
        if (Math.abs(this.fakeRL) > 0.75 * e * this.friction)
        {
            this.fakeRL -= this.makeOne(this.fakeRL) * 0.75 * e * this.friction;
        }
        else
        {
            this.fakeRL = 0;
        }
        this.fakeRL *= 0.985;
    }
    
    public function slideAir(e : Dynamic) : Dynamic
    {
        if (Math.abs(this.moveRL) > e)
        {
            this.moveRL -= this.makeOne(this.moveRL) * e;
        }
        else
        {
            this.moveRL = 0;
        }
        this.moveRL *= 0.985;
    }
    
    public function inRange() : Bool
    {
        return Math.abs(x - cameraX) < stageXs[this.onRail] + this.isWide + 100 && Math.abs(y - cameraY) < stageYs[this.onRail] + this.isTall + 100;
    }
    
    public function fallOffscreen() : Dynamic
    {
        return y > Main.cameraY + Main.stageYs[this.onRail] + 200;
    }
    
    public function rotX(spread : Dynamic, rot : Dynamic) : Float
    {
        return this.rotXRand(spread, rot * this.quickRadian);
    }
    
    public function rotY(spread : Dynamic, rot : Dynamic) : Float
    {
        return this.rotYRand(spread, rot * this.quickRadian);
    }
    
    public function rotXRand(spread : Dynamic, rot : Dynamic) : Float
    {
        return spread * Math.sin(rot);
    }
    
    public function rotYRand(spread : Dynamic, rot : Dynamic) : Float
    {
        return -(spread * Math.cos(rot));
    }
    
    @:allow()
    private function RLx(ex : Dynamic) : Float
    {
        return ex * Math.sin(this.wallAngle + 1.57);
    }
    
    @:allow()
    private function RLy(ey : Dynamic) : Float
    {
        return -ey * Math.cos(this.wallAngle + 1.57);
    }
    
    @:allow()
    private function UDx(ex : Dynamic) : Float
    {
        return ex * Math.sin(this.wallAngle + 3.14);
    }
    
    @:allow()
    private function UDy(ey : Dynamic) : Float
    {
        return -ey * Math.cos(this.wallAngle + 3.14);
    }
    
    @:allow()
    private function realRL() : Float
    {
        return this.RLx(this.fakeRL);
    }
    
    @:allow()
    private function realUD() : Float
    {
        return this.RLy(this.fakeRL);
    }
    
    @:allow()
    private function footX() : Float
    {
        return x + this.UDx(this.isTall);
    }
    
    @:allow()
    private function footY() : Float
    {
        return y + this.UDy(this.isTall);
    }
    
    @:allow()
    private function makeOne(e : Dynamic) : Int
    {
        if (e == 0)
        {
            return 0;
        }
        return as3hx.Compat.parseInt(e / Math.abs(e));
    }
    
    @:allow()
    private function CheckHead() : Bool
    {
        if ((cast(this.groundHitTest(x + this.UDx(-45), y + this.UDy(-45)), Bool) || cast(this.wallsHitTest(x + this.isWide, y - 45), Bool) || cast(this.wallsHitTest(x - this.isWide, y - 45), Bool)) && (cast(this.groundHitTest(x + this.UDx(45), y + this.UDy(45)), Bool) || cast(this.wallsHitTest(x + this.isWide, y + 45), Bool) || cast(this.wallsHitTest(x - this.isWide, y + 45), Bool)))
        {
            return true;
        }
        return false;
    }
    
    public function addToFollow(b : Int, ex : Float = -10000, ey : Float = -10000) : Void
    {
    }
    
    public function canWallHang() : Bool
    {
        return false;
    }
    
    public function groundHitTest(ex : Float, ey : Float) : Bool
    {
        return this.ground.hitTestPoint(ex, ey, true);
    }
    
    public function simpleGroundHitTest(ex : Float, ey : Float) : Bool
    {
        return this.ground.hitTestPoint(ex, ey, true);
    }
    
    public function gridGroundHitTest(ex : Dynamic, ey : Dynamic) : Dynamic
    {
        var i : Int = 0;
        var pos : Int = as3hx.Compat.parseInt(Math.floor(ex / gridSize) + Math.floor(ey / gridSize) * stageWidth + groundOffsetN);
        if (pos < 0 || pos > gridMax)
        {
            return false;
        }
        var o : Array<Dynamic> = Reflect.field(groundGrid, Std.string(pos));
        var n : Int = o.length;
        while (i < n)
        {
            if (o[i].hitTestPoint(ex, ey, true))
            {
                return true;
            }
            i++;
        }
        return false;
    }
    
    public function platformsHitTest(ex : Dynamic, ey : Dynamic) : Dynamic
    {
        return this.platforms.hitTestPoint(ex, ey, true);
    }
    
    public function wallsHitTest(ex : Dynamic, ey : Dynamic) : Dynamic
    {
        return this.walls.hitTestPoint(ex, ey, true);
    }
    
    public function allGroundsHitTest(ex : Dynamic, ey : Dynamic) : Bool
    {
    }
    
    @:allow()
    private function checkDist(baddie : Dynamic) : Dynamic
    {
        return Math.sqrt((baddie.x - x) * (baddie.x - x) + (baddie.y - y) * (baddie.y - y));
    }
}


