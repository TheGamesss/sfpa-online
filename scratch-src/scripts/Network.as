package
{
   import flash.display.MovieClip;
   import flash.events.*;
   import flash.net.*;
   
   public class Network extends MovieClip
   {
      
      private var connection:NetConnection;
      
      private var group:NetGroup;
      
      private var counter:uint = 0;
      
      private var player:uint = 0;
      
      private var master:Boolean;
      
      public function Network()
      {
         super();
         this.connection = new NetConnection();
         this.connection.connect("rtmfp:");
         this.connection.addEventListener(NetStatusEvent.NET_STATUS,this.netStatus);
      }
      
      private function EnterFrame(e:Event) : void
      {
         ++this.counter;
      }
      
      private function netStatus(event:NetStatusEvent) : void
      {
         switch(event.info.code)
         {
            case "NetConnection.Connect.Success":
               this.joinGroup();
               break;
            case "NetGroup.Neighbor.Connect":
               trace("Bruh joined " + event.info.peerID);
               Main.addPuppet(event.info.peerID);
               break;
            case "NetGroup.SendTo.Notify":
               this.receive(event.info.message);
         }
      }
      
      private function joinGroup() : void
      {
         var groupspec:GroupSpecifier = new GroupSpecifier("TestLocal");
         groupspec.routingEnabled = true;
         groupspec.serverChannelEnabled = true;
         groupspec.multicastEnabled = true;
         groupspec.ipMulticastMemberUpdatesEnabled = true;
         groupspec.addIPMulticastAddress("224.2.0.0:1024");
         this.group = new NetGroup(this.connection,groupspec.groupspecWithAuthorizations());
         this.player = this.group.estimatedMemberCount;
         trace("-- player " + this.player);
         if(this.player == 1)
         {
            this.master = true;
         }
         this.group.addEventListener(NetStatusEvent.NET_STATUS,this.netStatus);
         Main.netConfig(this.player);
      }
      
      public function sendToNetwork(m:Array) : void
      {
         this.group.sendToAllNeighbors(m);
      }
      
      public function receive(m:Array) : void
      {
         Char.fromNetwork(m);
      }
      
      public function sendClick(e:MouseEvent) : void
      {
         send(e.stageX,e.stageY + 150);
      }
   }
}

