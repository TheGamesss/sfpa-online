package com.amanitadesign.steam;


class UserConstants
{
    
    public static inline var BEGINAUTH_OK : Int = 0;
    
    public static inline var BEGINAUTH_InvalidTicket : Int = 1;
    
    public static inline var BEGINAUTH_DuplicateRequest : Int = 2;
    
    public static inline var BEGINAUTH_InvalidVersion : Int = 3;
    
    public static inline var BEGINAUTH_GameMismatch : Int = 4;
    
    public static inline var BEGINAUTH_ExpiredTicket : Int = 5;
    
    public static inline var LICENSE_HasLicense : Int = 0;
    
    public static inline var LICENSE_DoesNotHaveLicense : Int = 1;
    
    public static inline var LICENSE_NoAuth : Int = 2;
    
    public static inline var SESSION_OK : Int = 0;
    
    public static inline var SESSION_UserNotConnectedToSteam : Int = 1;
    
    public static inline var SESSION_NoLicenseOrExpired : Int = 2;
    
    public static inline var SESSION_VACBanned : Int = 3;
    
    public static inline var SESSION_LoggedInElseWhere : Int = 4;
    
    public static inline var SESSION_VACCheckTimedOut : Int = 5;
    
    public static inline var SESSION_AuthTicketCanceled : Int = 6;
    
    public static inline var SESSION_AuthTicketInvalidAlreadyUsed : Int = 7;
    
    public static inline var SESSION_AuthTicketInvalid : Int = 8;
    
    public static inline var AUTHTICKET_Invalid : Int = 0;
    
    public function new()
    {
        super();
    }
}


