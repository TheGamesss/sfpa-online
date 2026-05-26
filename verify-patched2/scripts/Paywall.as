package
{
   [Embed(source="/_assets/assets.swf", symbol="symbol338")]
   public class Paywall extends staticInteractObjects
   {
      
      private var moveUD:Number = 0;
      
      public function Paywall(p:*)
      {
         super("Paywall",p.x,p.y,1,1,0,"nothing",0);
         interactive = false;
         if(Main.hasKey())
         {
            hitChar = function(ex:*, ey:*, eRL:*, eUD:*, char:*):*
            {
               interactive = true;
            };
            InteractEnterFrame = function():*
            {
               if(interactive)
               {
                  moveUD = (anchorY - 150 - y) * 0.2;
               }
               else if(y + moveUD < anchorY)
               {
                  moveUD += 2;
               }
               else
               {
                  if(moveUD > 0)
                  {
                     Main.shakeRL = moveUD * 0.5;
                  }
                  moveUD = 0;
                  y = anchorY;
               }
               if(moveUD != 0)
               {
                  y += moveUD;
                  myPayWall.y = y;
               }
               interactive = false;
            };
         }
         else
         {
            hitChar = function(ex:*, ey:*, eRL:*, eUD:*, char:*):*
            {
               new bigSpeechBubble(8,11,function():*
               {
               });
               hitChar = function(ex:*, ey:*, eRL:*, eUD:*, char:*):*
               {
               };
            };
         }
         hitBaddie = function(ex:*, ey:*, eRL:*, eUD:*, baddie:*):*
         {
         };
         myPayWall = new payWallWall();
         myPayWall.x = x;
         myPayWall.y = y;
         Main.AllEverything.walls0.addChild(myPayWall);
         Backgrounds.backgroundsArray[0].addChild(this);
         isWide = 150;
         isTall = 500;
         InteractEnterFrameArray.push(this);
         if(Main.hasKey())
         {
            gotoAndStop(2);
         }
         else
         {
            gotoAndStop(1);
         }
      }
   }
}

