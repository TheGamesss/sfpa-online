import com.kongregate.air.*;
import flash.events.Event;

class Achievements
{
    
    public static var mKongregate : KongregateAPI;
    
    private static var sendKong : Bool;
    
    private static var steamAdapter : FRESteamWorksAdapter;
    
    private static var nameVector : Array<String> = new Array<String>();
    
    private static var timerVector : Array<Int> = new Array<Int>();
    
    private static var countVector : Array<Int> = new Array<Int>();
    
    public static var KongregateConstants : Dynamic = { };
    
    public function new()
    {
        super();
    }
    
    public static function track(e : String, t : Int, max : Int, reset : Bool = false) : Void
    {
        var i : Int = as3hx.Compat.parseInt(Lambda.indexOf(nameVector, e));
        if (i == -1)
        {
            nameVector.push(e);
            timerVector.push(t);
            countVector.push(1);
        }
        else
        {
            if (reset)
            {
                timerVector[i] = t;
            }
            ++countVector[i];
            if (countVector[i] == max)
            {
                unlock(e);
            }
        }
    }
    
    public static function clearTracked(e : String) : Void
    {
        var i : Int = as3hx.Compat.parseInt(Lambda.indexOf(nameVector, e));
        if (i > -1)
        {
            spliceAll(i);
        }
    }
    
    public static function counter() : Void
    {
        var i : Dynamic = as3hx.Compat.parseInt(nameVector.length - 1);
        while (i >= 0)
        {
            --Reflect.field(timerVector, Std.string(i));
            if (Reflect.field(timerVector, Std.string(i)) == 0)
            {
                spliceAll(i);
            }
            i--;
        }
    }
    
    public static function spliceAll(i : Int) : Void
    {
        nameVector.splice(i, 1)[0];
        timerVector.splice(i, 1)[0];
        countVector.splice(i, 1)[0];
    }
    
    public static function unlock(e : String) : Void
    {
        trace("Steam " + e);
        FRESteamWorksAdapter.setAchievement(e);
    }
    
    public static function SendScore(stat : String, e : Int) : Dynamic
    {
        trace("Send Score: " + stat + " " + e);
        if (sendKong)
        {
            mKongregate.stats.submit(stat, e);
        }
    }
    
    public static function startKong() : Void
    {
        KongregateAPI.settings.steamAdapter = steamAdapter = new FRESteamWorksAdapter();
        KongregateConstants.gameId = 281966;
        KongregateConstants.gameApiKey = "858df123-ea94-4c5b-80a9-d1bf5dbabf63";
        KongregateAPI.settings.adjustEnvironment = "production";
        KongregateAPI.settings.adjustAppToken = "j3h2m6zmwmio";
        KongregateAPI.settings.adjustEventTokenMap = {
                    install : "bynkpu",
                    sale : "noe9ht",
                    session : "41q1j2"
                };
        mKongregate = KongregateAPI.initialize(Main.stageRoot.stage, KongregateConstants.gameId, KongregateConstants.gameApiKey);
        mKongregate.addEventListener(KongregateAPI.API_EVENT, KongCallback);
    }
    
    private static function KongCallback(e : Event) : Void
    {
        trace("- " + e.name);
        var _sw0_ = (e.name);        

        switch (_sw0_)
        {
            case KongregateAPI.KONGREGATE_EVENT_USER_CHANGED:
                trace(mKongregate.services.getUsername());
            case KongregateAPI.KONGREGATE_EVENT_READY:
                sendKong = true;
                Main.stageRoot.StartMain();
            case KongregateAPI.KONGREGATE_EVENT_GAME_AUTH_CHANGED:
        }
    }
    
    public static function KongButton() : Void
    {
        mKongregate.mobile.openKongregateWindow();
    }
}


