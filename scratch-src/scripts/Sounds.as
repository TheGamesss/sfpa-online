package
{
   import flash.events.*;
   import flash.media.*;
   import flash.net.*;
   import flash.utils.*;
   
   public class Sounds
   {
      
      private static var loadN:uint;
      
      private static var soundNum:int;
      
      private static var sound:Sound;
      
      public static var BackgroundMusic:Sound;
      
      public static var BackgroundChannel:SoundChannel;
      
      public static var pausedBackgroundPosition:Number;
      
      public static var oldPausedBackgroundPosition:Number;
      
      public static var tempPausedBackgroundPosition:Number;
      
      public static var musicFadeToVolume:Number;
      
      private static var fadeAccel:Number;
      
      private static var musicAfterFade:String;
      
      private static var crossFade:Boolean;
      
      private static var oldBackgroundMusic:Sound;
      
      private static var oldBackgroundChannel:SoundChannel;
      
      private static var musicPlayAfter:String;
      
      private static var tempBackgroundMusic:Sound;
      
      private static var tempBackgroundChannel:SoundChannel;
      
      public static var superSource:aPlat;
      
      public static var superLoop:SoundChannel;
      
      private static var soundsArray:Array = ["DoorOpen","DoorClose","Coin_0","Coin_1","Coin_2","Coin_3","Coin_4","CatTear","JustCat","TearWrap","BadStomp_0","BadStomp_1","BadStomp_2","BadStomp_3","Kick","Spring","Ow","Bonk","Crash","Rolling","deathStrings","extraLife","scribble","sharpener","fanfare","success","Swosh_0","Swosh_1","Swosh_2","Swosh_3","MedSwosh_0","MedSwosh_1","MedSwosh_2","MedSwosh_3","HeavySwosh_0","HeavySwosh_1","Impact_0","Impact_1","Impact_2","Impact_3","Jump_0","Jump_1","Jump_2","Jump_3","Jump_4","Land_0","Land_1","Land_2","Footstep_0","Footstep_1","Footstep_2","Footstep_3","Footstep_4","Footstep_5","Footstep_6","Footstep_7","Footstep_8","Footstep_9","PoleLand","Twirl_0","Twirl_1","Twirl_2","Twirl_3","Twirl_4","Twirl_5","HurtLand","JustHurtLand","Sliding","PinCrash","EnterBox","ExitBox","InkBoardStart_0","InkBoardStart_1","InkBoardSliding","PenCharge_0","PenCharge_1","PenCharge_2","InkShot_0","InkShot_1","InkShot_2","InkShot_3","InkShot_4","InkShot_5","InkShot_6","InkShot_7"
      ,"InkShot_8","InkShot_9","InkBurst_0","InkBurst_1","InkBurst_2","InkBurst_3","InkSpit_0","InkSpit_1","InkSpit_2","InkHurt_0","InkHurt_1","InkHurt_2","BreakBlock_0","BreakBlock_1","BreakBlock_2","BreakBlock_3","InkLand_0","InkLand_1","InkLand_2","InkLand_3","InkLand_4","InkLand_5","Popper","Pause","UnPause","JumpWind","HangLand_0","HangLand_1","HangStep_0","HangStep_1","HangStep_2","HangStep_3","HangStep_4","HangStep_5","HangStep_6","HangStep_7","HangStep_8","HangStep_9","Hit_0","Hit_1","Hit_2","Hit_3","HangSlide","FallInInk_0","FallInInk_1","InkJump_0","InkJump_1","InkJump_2","InkJump_3","InkJump_4","InkJump_5","InkBoom_0","InkBoom_1","InkBoom_2","InkExplode_0","InkExplode_1","InkExplode_2","InkExplode_3","InkSplat_0","InkSplat_1","InkSplat_2","InkSplat_3","PillarImpact_0","PillarImpact_1","PillarImpact_2","PillarImpact_3","PillarCrack","InkRocket","InkVeinLoop","LowRumble","VolcanoExplode","NinjaJump_0","NinjaJump_1","NinjaJump_2","NinjaJump_3","NinjaJump_4","NinjaJump_5","NinjaSwipe_0"
      ,"NinjaSwipe_1","NinjaSwipe_2","NinjaSwipe_3","SpiderDie_0","SpiderDie_1","SpiderDie_2","NinjaDie_0","NinjaDie_1","NinjaDie_2","MouseDie_0","MouseDie_1","MouseDie_2","MouseShoot_0","MouseShoot_1","MouseShoot_2","MouseShoot_3","CutieStomp_0","CutieStomp_1","CutieStomp_2","CutieStomp_3","CutieStomp_4","AirshipStart","AirshipLoop"];
      
      public static var allSounds:Object = {};
      
      public static var soundsVariance:Object = {};
      
      public static var sfxVol:Number = 1;
      
      public static var musicVol:Number = 1;
      
      public static var musicPlaying:String = "nothing";
      
      public static var musicFadeVolume:Number = 0;
      
      private static var oldMusicFadeVolume:Number = 0;
      
      private static var tempTransform:SoundTransform = new SoundTransform();
      
      private static var tempVol:Number = 0;
      
      private static var tempPan:Number = 0;
      
      public static var superSound:String = "nothing";
      
      public static function playSound(sound:*, ex:*, vol:*, rail:*):*
      {
      }
      public function Sounds()
      {
         super();
      }
      
      public static function startLoadSounds() : *
      {
         soundNum = -1;
         playSound = reallyPlaySound;
         loadSoundsLocal();
      }
      
      public static function playMusic(level:*, accel:Number = 0.02) : Boolean
      {
         return playDirect(getMusic(level),accel);
      }
      
      private static function loadSoundsLocal() : *
      {
         var i:uint = 0;
         var classReference:Class = null;
         while(i < soundsArray.length)
         {
            classReference = getDefinitionByName(soundsArray[i]) as Class;
            allSounds[soundsArray[i]] = new classReference();
            if(soundsArray[i].substr(0,6) == "Impact")
            {
               soundsVariance["Impact"] = 4;
            }
            else if(soundsArray[i].substr(0,4) == "Coin")
            {
               soundsVariance["Coin"] = 5;
            }
            else if(soundsArray[i].substr(0,4) == "Jump")
            {
               soundsVariance["Jump"] = 5;
            }
            else if(soundsArray[i].substr(0,4) == "Land")
            {
               soundsVariance["Land"] = 3;
            }
            else if(soundsArray[i].substr(0,5) == "Swosh")
            {
               soundsVariance["Swosh"] = 4;
            }
            else if(soundsArray[i].substr(0,8) == "MedSwosh")
            {
               soundsVariance["MedSwosh"] = 4;
            }
            else if(soundsArray[i].substr(0,10) == "HeavySwosh")
            {
               soundsVariance["HeavySwosh"] = 2;
            }
            else if(soundsArray[i].substr(0,8) == "Footstep")
            {
               soundsVariance["Footstep"] = 10;
            }
            else if(soundsArray[i].substr(0,3) == "Hit")
            {
               soundsVariance["Hit"] = 4;
            }
            else if(soundsArray[i].substr(0,8) == "BadStomp")
            {
               soundsVariance["BadStomp"] = 4;
            }
            else if(soundsArray[i].substr(0,9) == "NinjaJump")
            {
               soundsVariance["NinjaJump"] = 6;
            }
            else if(soundsArray[i].substr(0,10) == "NinjaSwipe")
            {
               soundsVariance["NinjaSwipe"] = 4;
            }
            else if(soundsArray[i].substr(0,9) == "SpiderDie")
            {
               soundsVariance["SpiderDie"] = 3;
            }
            else if(soundsArray[i].substr(0,8) == "NinjaDie")
            {
               soundsVariance["NinjaDie"] = 3;
            }
            else if(soundsArray[i].substr(0,8) == "MouseDie")
            {
               soundsVariance["MouseDie"] = 3;
            }
            else if(soundsArray[i].substr(0,10) == "MouseShoot")
            {
               soundsVariance["MouseShoot"] = 4;
            }
            else if(soundsArray[i].substr(0,7) == "InkBoom")
            {
               soundsVariance["InkBoom"] = 3;
            }
            else if(soundsArray[i].substr(0,10) == "InkExplode")
            {
               soundsVariance["InkExplode"] = 4;
            }
            else if(soundsArray[i].substr(0,12) == "PillarImpact")
            {
               soundsVariance["PillarImpact"] = 4;
            }
            else if(soundsArray[i].substr(0,8) == "HangLand")
            {
               soundsVariance["HangLand"] = 2;
            }
            else if(soundsArray[i].substr(0,8) == "HangStep")
            {
               soundsVariance["HangStep"] = 10;
            }
            else if(soundsArray[i].substr(0,5) == "Twirl")
            {
               soundsVariance["Twirl"] = 6;
            }
            else if(soundsArray[i].substr(0,13) == "InkBoardStart")
            {
               soundsVariance["InkBoardStart"] = 2;
            }
            else if(soundsArray[i].substr(0,9) == "PenCharge")
            {
               soundsVariance["PenCharge"] = 3;
            }
            else if(soundsArray[i].substr(0,10) == "BreakBlock")
            {
               soundsVariance["BreakBlock"] = 4;
            }
            else if(soundsArray[i].substr(0,7) == "InkShot")
            {
               soundsVariance["InkShot"] = 10;
            }
            else if(soundsArray[i].substr(0,8) == "InkBurst")
            {
               soundsVariance["InkBurst"] = 4;
            }
            else if(soundsArray[i].substr(0,8) == "InkSplat")
            {
               soundsVariance["InkSplat"] = 4;
            }
            else if(soundsArray[i].substr(0,7) == "InkSpit")
            {
               soundsVariance["InkSpit"] = 3;
            }
            else if(soundsArray[i].substr(0,7) == "InkHurt")
            {
               soundsVariance["InkHurt"] = 3;
            }
            else if(soundsArray[i].substr(0,7) == "InkLand")
            {
               soundsVariance["InkLand"] = 6;
            }
            else if(soundsArray[i].substr(0,7) == "InkJump")
            {
               soundsVariance["InkJump"] = 6;
            }
            else if(soundsArray[i].substr(0,9) == "FallInInk")
            {
               soundsVariance["FallInInk"] = 2;
            }
            else
            {
               soundsVariance[soundsArray[i]] = 0;
            }
            i++;
         }
      }
      
      public static function playDirect(music:*, accel:Number = 0.02, limit:Number = 1, after:String = "loop", startAt:uint = 0) : Boolean
      {
         var classReference:Class = null;
         if(music != musicPlaying)
         {
            if(BackgroundMusic != null)
            {
               stopMusic();
               BackgroundMusic = null;
               BackgroundChannel = null;
            }
            if(music != "nothing")
            {
               classReference = getDefinitionByName(music) as Class;
               BackgroundMusic = new classReference();
               BackgroundChannel = BackgroundMusic.play(startAt);
               BackgroundChannel.soundTransform = new SoundTransform(0);
               BackgroundChannel.addEventListener(Event.SOUND_COMPLETE,resetPosition);
               musicPlayAfter = after;
               if(musicVol == 0)
               {
                  BackgroundChannel.stop();
                  pausedBackgroundPosition = 0;
               }
               if(music.substr(0,9) == "Challenge")
               {
                  musicFadeVolume = 0.1;
               }
               else
               {
                  musicFadeVolume = 0.01;
               }
               musicFadeToVolume = limit;
               fadeAccel = accel;
               musicAfterFade = "nothing";
               Main.stageRoot.fadingMusic = true;
            }
            musicPlaying = music;
            return true;
         }
         return false;
      }
      
      public static function playOnce(music:String) : void
      {
         var classReference:Class = getDefinitionByName(music) as Class;
         tempBackgroundMusic = new classReference();
         tempBackgroundChannel = tempBackgroundMusic.play(0,1,new SoundTransform(musicVol));
         tempBackgroundChannel.addEventListener(Event.SOUND_COMPLETE,clearTemp);
      }
      
      public static function tempForcePosition(e:uint) : void
      {
         tempBackgroundChannel.stop();
         tempBackgroundMusic.play(e);
      }
      
      private static function clearTemp(e:Event) : void
      {
         tempBackgroundChannel.removeEventListener(Event.SOUND_COMPLETE,clearTemp);
         tempBackgroundMusic = null;
         tempBackgroundChannel = null;
      }
      
      public static function musicEnterFrame() : void
      {
         if(musicFadeToVolume == 0 && musicFadeVolume - fadeAccel > 0)
         {
            musicFadeVolume -= fadeAccel;
            updateMusic(cosCurve(musicFadeVolume) * oldMusicFadeVolume);
         }
         else if(musicFadeVolume + fadeAccel < 1)
         {
            musicFadeVolume += fadeAccel;
            updateMusic(cosCurve(musicFadeVolume) * musicFadeToVolume);
            if(crossFade)
            {
               updateOldMusic((1 - cosCurve(musicFadeVolume)) * oldMusicFadeVolume);
            }
         }
         else
         {
            oldMusicFadeVolume = musicFadeToVolume;
            if(musicAfterFade != "nothing")
            {
               playDirect(musicAfterFade,fadeAccel);
               musicAfterFade = "nothing";
            }
            else
            {
               Main.stageRoot.fadingMusic = false;
               if(musicFadeToVolume == 0)
               {
                  stopMusic();
               }
               else
               {
                  updateMusic(musicFadeToVolume);
                  if(crossFade)
                  {
                     oldStopMusic();
                     crossFade = false;
                  }
               }
            }
         }
      }
      
      private static function cosCurve(e:Number) : Number
      {
         return 1 - Math.cos(e * 1.57);
      }
      
      public static function stopMusic() : void
      {
         BackgroundChannel.removeEventListener(Event.SOUND_COMPLETE,resetPosition);
         BackgroundChannel.stop();
         BackgroundMusic = null;
         BackgroundChannel = null;
      }
      
      public static function oldStopMusic() : void
      {
         oldBackgroundChannel.removeEventListener(Event.SOUND_COMPLETE,resetPosition);
         oldBackgroundChannel.stop();
         oldBackgroundMusic = null;
         oldBackgroundChannel = null;
      }
      
      public static function fadeOutMusic(music:String = "nothing", accel:Number = 0.02, fadeType:String = "crossFade", limit:Number = 1, after:String = "loop") : Boolean
      {
         if(music != musicPlaying && musicPlaying != "nothing")
         {
            musicFadeVolume = 1;
            musicFadeToVolume = 0;
            fadeAccel = accel;
            if(music == "nothing")
            {
               fadeType = "nothing";
            }
            crossFade = fadeType == "crossFade" || fadeType == "crossSync";
            if(oldBackgroundMusic != null)
            {
               oldStopMusic();
               oldBackgroundMusic = null;
               oldBackgroundChannel = null;
            }
            if(fadeType == "crossFade")
            {
               oldBackgroundMusic = BackgroundMusic;
               oldBackgroundChannel = BackgroundChannel;
               BackgroundMusic = null;
               BackgroundChannel = null;
               playDirect(music,fadeAccel,limit,after);
            }
            else if(fadeType == "crossSync")
            {
               oldBackgroundMusic = BackgroundMusic;
               oldBackgroundChannel = BackgroundChannel;
               BackgroundMusic = null;
               BackgroundChannel = null;
               playDirect(music,fadeAccel,limit,after,oldBackgroundChannel.position);
            }
            else
            {
               musicPlaying = music;
               if(fadeType == "startAfter")
               {
                  musicAfterFade = music;
               }
               else
               {
                  musicAfterFade = "nothing";
               }
            }
            musicPlayAfter = after;
            Main.stageRoot.fadingMusic = true;
            return true;
         }
         if((fadeType == "crossFade" || fadeType == "crossSync") && musicPlaying != music)
         {
            musicFadeToVolume = limit;
            fadeAccel = accel;
            playDirect(music,fadeAccel,limit,after);
            musicPlayAfter = after;
            Main.stageRoot.fadingMusic = true;
            return true;
         }
         return false;
      }
      
      public static function getMusic(loadit:*, door:int = 0) : *
      {
         var temp:String = null;
         if(loadit == "return")
         {
            loadit = Main.getReturnLevel();
         }
         if(Main.DirIt == "World 4")
         {
            temp = loadit.substr(0,6);
            if(temp == "Menus0")
            {
               return "Wind_Cave";
            }
            if(temp == "Level0")
            {
               if(loadit == "Level0-a")
               {
                  if(Main.LevelLoaded == "Level0-b")
                  {
                     return "Wind_High";
                  }
                  return "Wind_Cave";
               }
               if(loadit == "Level0-h" || loadit == "Level0-i" || loadit == "Level0-j")
               {
                  if(Char.hasPen)
                  {
                     return "Cave_Moving";
                  }
                  return "Wind_Cave";
               }
               return "Cave_Mystery";
            }
            if(temp == "Level1")
            {
               if(loadit == "Level1-a")
               {
                  if(door == 0)
                  {
                     return "Wind_Cave";
                  }
                  return "PlainsMusic";
               }
               if(loadit == "Level1-h")
               {
                  return "Erupt_Intro";
               }
               if(loadit == "Level1-i")
               {
                  return "Village_Intro";
               }
               if(loadit == "Level1-j" || loadit == "Level1-k")
               {
                  return "Village_2";
               }
               return "PlainsMusic";
            }
            if(temp == "Villa0")
            {
               if(loadit == "Villa0-a" || loadit == "Villa0-b")
               {
                  if(door == 1)
                  {
                     return "Lounge_Inside";
                  }
                  return "Village_Intro";
               }
               if(loadit == "Villa0-c" || loadit == "Villa0-d" || loadit == "Villa0-e")
               {
                  return "Village_2";
               }
               if(loadit == "Villa0-f")
               {
                  return "Village_Elfman";
               }
               return "nothing";
            }
            if(temp == "Level2")
            {
               if(loadit == "Level2-e" && Main.LevelLoaded == "Level2-f")
               {
                  return "Wind_Cave";
               }
               if(loadit == "Level2-f" && Main.LevelLoaded == "Level2-g")
               {
                  return "Wind_Cave";
               }
               if(loadit == "Level2-g" && Main.LevelLoaded == "Level2-h")
               {
                  return "Wind_Cave";
               }
               if(loadit == "Level2-h" && Main.LevelLoaded == "Level2-i")
               {
                  return "Wind_Cave";
               }
               if(loadit == "Level2-i" || loadit == "Level2-j")
               {
                  return "Village_Intro";
               }
               return "Pirate_Music";
            }
            if(temp == "Level3")
            {
               if(loadit == "Level3-a")
               {
                  return "Wind_High";
               }
               if(loadit == "Level3-j")
               {
                  if(Main.world4Progress.volcanoUnlocked)
                  {
                     return "Wind_Cave";
                  }
                  return "Village_Elfman";
               }
               if(loadit == "Level3-k")
               {
                  if(Main.world4Progress.volcanoUnlocked)
                  {
                     return "Wind_Cave";
                  }
                  return "BossMusic";
               }
               return "SpireMusic";
            }
            if(temp == "Level4")
            {
               if(loadit == "Level4-h")
               {
                  return "Village_Elfman";
               }
               if(musicPlaying == "Volcano_Slow" || musicPlaying == "Volcano_Fast")
               {
                  return musicPlaying;
               }
               return "Volcano_Slow";
            }
            if(temp == "Level5")
            {
               return "FinalBoss_Intro";
            }
            if(loadit == "bonus")
            {
               return "Challenge0" + (int(Math.random() * 3) + 1);
            }
            if(loadit.substr(0,5) == "Bonus")
            {
               return "Challenge0" + (int(Math.random() * 3) + 1);
            }
            if(loadit == "Arena1")
            {
               return "Volcano_Fast";
            }
            return "nothing";
         }
         if(Main.DirIt == "Arcade")
         {
            if(loadit == "Arena0")
            {
               return "AngryMusic";
            }
            return "Challenge0" + (int(Math.random() * 3) + 1);
         }
         if(Main.DirIt == "Extra")
         {
            if(loadit == "Level0")
            {
               return "Cave_Moving";
            }
            if(loadit == "Level1")
            {
               return "PlainsMusic";
            }
            if(loadit == "Level2")
            {
               return "ChallengeMusicW1R";
            }
            if(loadit == "Level3")
            {
               return "Village_2";
            }
            return;
         }
         if(Main.StatusName != "nothing")
         {
            return "ChallengeMusicW1R";
         }
         if(loadit.substr(0,5) == "Menus")
         {
            return "CaveMusicW1R";
         }
         if(loadit == "Level1" || loadit == "Level2" || loadit == "Level5" || loadit == "Lockd4")
         {
            return "LevelMusicW1R";
         }
         if(loadit == "Bonus4" || loadit == "Bonus5" || loadit == "Level3" || loadit == "Lockd1" || loadit == "Lockd2" || loadit == "Bonus10" || loadit == "Races1")
         {
            return "ChallengeMusicW1R";
         }
         if(loadit == "Trans4" || loadit == "Level4" || loadit == "Lockd3")
         {
            return "MysteryMusicW1R";
         }
         if(loadit == "Level6" || loadit == "Level7")
         {
            return "BossMusicW1R";
         }
         return "CaveMusicW1R";
      }
      
      public static function updateMusic(vol:*) : *
      {
         BackgroundChannel.soundTransform = new SoundTransform(vol * musicVol);
      }
      
      public static function updateOldMusic(vol:*) : *
      {
         oldBackgroundChannel.soundTransform = new SoundTransform(vol * musicVol);
      }
      
      public static function setVolume(vol:*) : *
      {
         if(vol == 0 && sfxVol > 0)
         {
            muteAll();
            if(musicVol == 0 && rootHUD.HUD.currentFrameLabel == "MiniClip")
            {
               rootHUD.HUD.muteButton.gotoAndStop(2);
            }
         }
         else if(sfxVol == 0 && vol > 0)
         {
            if(rootHUD.HUD.currentFrameLabel == "MiniClip")
            {
               rootHUD.HUD.muteButton.gotoAndStop(1);
            }
            unMuteAll();
         }
         Main.localSettings.sfxVol = vol;
         sfxVol = vol * 1.2;
      }
      
      public static function setMusic(vol:*) : *
      {
         if(musicPlaying == "nothing")
         {
            return false;
         }
         if(vol == 0 && musicVol > 0)
         {
            pauseMusic();
            if(sfxVol == 0 && rootHUD.HUD.currentFrameLabel == "MiniClip")
            {
               rootHUD.HUD.muteButton.gotoAndStop(2);
            }
         }
         else if(musicVol == 0 && vol > 0)
         {
            if(rootHUD.HUD.currentFrameLabel == "MiniClip")
            {
               rootHUD.HUD.muteButton.gotoAndStop(1);
            }
            BackgroundChannel = BackgroundMusic.play(pausedBackgroundPosition);
            BackgroundChannel.addEventListener(Event.SOUND_COMPLETE,resetPosition);
         }
         BackgroundChannel.soundTransform = new SoundTransform(vol);
         Main.localSettings.musicVol = vol;
         musicVol = vol * 0.7;
      }
      
      private static function resetPosition(e:Event) : *
      {
         var classReference:Class = null;
         var old:Boolean = e.currentTarget == oldBackgroundChannel;
         e.currentTarget.removeEventListener(Event.SOUND_COMPLETE,resetPosition);
         if(musicPlayAfter != "loop")
         {
            classReference = getDefinitionByName(musicPlayAfter) as Class;
            BackgroundMusic = new classReference();
            musicPlayAfter = "loop";
         }
         if(old)
         {
            oldBackgroundChannel = BackgroundMusic.play(0,1000);
            oldBackgroundChannel.soundTransform = new SoundTransform(musicVol);
         }
         else
         {
            BackgroundChannel = BackgroundMusic.play(0,1000);
            BackgroundChannel.soundTransform = new SoundTransform(musicVol);
         }
      }
      
      public static function muteButton() : *
      {
         if(musicVol == 0 && sfxVol == 0)
         {
            setMusic(1);
            setVolume(1);
         }
         else
         {
            setMusic(0);
            setVolume(0);
         }
      }
      
      public static function muteAll() : *
      {
         playSound = function(sound:*, ex:*, vol:*, rail:*):*
         {
         };
      }
      
      public static function unMuteAll() : *
      {
         playSound = reallyPlaySound;
      }
      
      public static function pauseMusic() : *
      {
         if(musicVol > 0)
         {
            if(BackgroundMusic != null)
            {
               BackgroundChannel.removeEventListener(Event.SOUND_COMPLETE,resetPosition);
               pausedBackgroundPosition = BackgroundChannel.position;
               BackgroundChannel.stop();
            }
            if(oldBackgroundChannel != null)
            {
               oldBackgroundChannel.removeEventListener(Event.SOUND_COMPLETE,resetPosition);
               oldPausedBackgroundPosition = oldBackgroundChannel.position;
               oldBackgroundChannel.stop();
            }
            if(tempBackgroundChannel != null)
            {
               tempBackgroundChannel.removeEventListener(Event.SOUND_COMPLETE,clearTemp);
               tempPausedBackgroundPosition = tempBackgroundChannel.position;
               tempBackgroundChannel.stop();
            }
         }
      }
      
      public static function resumeMusic() : *
      {
         if(musicVol > 0)
         {
            if(BackgroundMusic != null)
            {
               BackgroundChannel = BackgroundMusic.play(pausedBackgroundPosition);
               BackgroundChannel.addEventListener(Event.SOUND_COMPLETE,resetPosition);
               BackgroundChannel.soundTransform = new SoundTransform(musicVol);
            }
            if(oldBackgroundChannel != null)
            {
               oldBackgroundChannel = oldBackgroundMusic.play(oldPausedBackgroundPosition);
               oldBackgroundChannel.soundTransform = new SoundTransform(musicFadeVolume * musicVol);
            }
            if(tempBackgroundChannel != null)
            {
               tempBackgroundChannel = tempBackgroundMusic.play(tempPausedBackgroundPosition);
               tempBackgroundChannel.addEventListener(Event.SOUND_COMPLETE,clearTemp);
               tempBackgroundChannel.soundTransform = new SoundTransform(musicVol);
            }
         }
      }
      
      private static function loadSoundsExternal() : *
      {
         sound = new Sound();
         if(soundNum == -1)
         {
            sound.load(new URLRequest(Main.whereAt + "Sounds/" + soundsArray[loadN] + ".mp3"));
            allSounds[soundsArray[loadN]] = sound;
         }
         else
         {
            sound.load(new URLRequest(Main.whereAt + "Sounds/" + soundsArray[loadN] + "_" + soundNum + ".mp3"));
            allSounds[soundsArray[loadN] + "_" + soundNum] = sound;
         }
         sound.addEventListener(Event.COMPLETE,soundLoaded);
         sound.addEventListener(IOErrorEvent.IO_ERROR,soundError);
      }
      
      private static function soundLoaded(e:Event) : *
      {
         sound.removeEventListener(Event.COMPLETE,soundLoaded);
         sound.removeEventListener(IOErrorEvent.IO_ERROR,soundError);
         soundsVariance[soundsArray[loadN]] = soundNum + 1;
         if(soundNum == -1)
         {
            ++loadN;
            if(loadN < soundsArray.length)
            {
            }
         }
         else
         {
            ++soundNum;
         }
      }
      
      private static function soundError(e:Event) : *
      {
         sound.addEventListener(Event.COMPLETE,soundLoaded);
         sound.addEventListener(IOErrorEvent.IO_ERROR,soundError);
         if(soundNum == -1)
         {
            soundNum = 0;
         }
         else
         {
            ++loadN;
            if(loadN < soundsArray.length)
            {
               soundNum = -1;
            }
         }
      }
      
      private static function randNum(e:*) : *
      {
         return Math.floor(Math.random() * e);
      }
      
      public static function reallyPlaySound(sound:String, ex:Number, vol:Number = 1, rail:uint = 0) : *
      {
         if(soundsVariance[sound] == 0)
         {
            allSounds[sound].play(0,1,getTransform(ex,vol,rail));
         }
         else
         {
            allSounds[sound + "_" + randNum(soundsVariance[sound])].play(0,1,getTransform(ex,vol,rail));
         }
      }
      
      public static function playSoundSimple(sound:String, vol:Number = 1) : void
      {
         allSounds[sound].play(0,1,new SoundTransform(sfxVol * vol));
      }
      
      public static function playSoundThenLoop(sound:String, source:aPlat, vol:Number = 1) : void
      {
         var channel:SoundChannel = allSounds[sound].play(0,1,new SoundTransform(sfxVol * vol));
         superSource = source;
         channel.addEventListener(Event.SOUND_COMPLETE,playLoopAfter);
      }
      
      private static function playLoopAfter(e:Event) : *
      {
         superSource.startLoop();
      }
      
      public static function playSoundContinuous(sound:*, ex:*, vol:*, rail:*) : *
      {
         var channel:SoundChannel = allSounds[sound].play(0,1000);
         if(channel != null)
         {
            channel.soundTransform = getTransform(ex,vol,rail);
         }
         return channel;
      }
      
      public static function pauseSuperLoop() : void
      {
         if(superLoop != null)
         {
            superLoop.stop();
         }
      }
      
      public static function unPauseSuperLoop() : void
      {
         if(superSource != null)
         {
            superSource.startLoop();
         }
      }
      
      public static function clearSuperLoop() : void
      {
         if(superLoop != null)
         {
            superLoop.stop();
         }
         if(superSource != null)
         {
            superSource = null;
         }
      }
      
      public static function updateSound(channel:SoundChannel, ex:Number, vol:Number, rail:uint) : *
      {
         channel.soundTransform = getTransform(ex,vol,rail);
      }
      
      private static function getTransform(ex:Number, vol:Number, rail:uint) : SoundTransform
      {
         tempPan = (ex - Main.cameraX) / Main.stageXs[rail];
         if(Math.abs(tempPan) > 1)
         {
            vol *= 1 / Math.abs(tempPan);
            tempPan /= Math.abs(tempPan);
         }
         tempTransform.pan = Math.sin(tempPan * 1.57);
         tempTransform.volume = vol * sfxVol;
         return tempTransform;
      }
      
      public static function stopSound(channel:*) : *
      {
         channel.stop();
      }
   }
}

