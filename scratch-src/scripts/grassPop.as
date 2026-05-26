package
{
   [Embed(source="/_assets/assets.swf", symbol="symbol4221")]
   public class grassPop extends staticInteractObjects
   {
      
      private var canPop:Boolean = true;
      
      public function grassPop(p:*)
      {
         super("grassPop",p.x,p.y,1,1,p.onRail,"nothing",-1);
         rotation = p.rotation;
         isTall = 25;
         isWide = 25;
         ID = p.ID;
         ItIs = "grassPop";
         Backgrounds.backgroundsArray[onRail].addChild(this);
         hitChar = function(ex:*, ey:*, eRL:*, eUD:*, char:*):*
         {
            distRL = x - ex;
            distUD = y - ey;
            if(char.Status == "DownSlide" || char.Status == "Roll")
            {
               if(Math.abs(distRL) < char.isWide + isWide && Math.abs(distUD) < char.isTall + isTall)
               {
                  dontCheat[Main.LevelLoaded][ID] = true;
                  angle = rotation * Math.PI / 180;
                  new looseSquiggle(x + Math.sin(angle) * 5,y + -Math.cos(angle) * 5,Math.sin(angle) * 20,-Math.cos(angle) * 20,onRail,-eRL * 10);
                  new popEffect(x,y,Math.random() * 360,1,char.onRail,char);
                  Sounds.playSound("Popper",x,1,onRail);
                  canPop = false;
                  killInteract.push(this);
                  hitChar = function(ex:*, ey:*, eRL:*, eUD:*, char:*):*
                  {
                  };
               }
            }
         };
         hitBaddie = function(ex:*, ey:*, eRL:*, eUD:*, baddie:*):*
         {
         };
      }
   }
}

