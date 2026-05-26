package com.amanitadesign.steam;


class UploadLeaderboardScoreResult
{
    
    public var success : Bool;
    
    public var leaderboardHandle : String;
    
    public var score : Int;
    
    public var scoreChanged : Bool;
    
    public var newGlobalRank : Int;
    
    public var previousGlobalRank : Int;
    
    public function new()
    {
        super();
    }
}


