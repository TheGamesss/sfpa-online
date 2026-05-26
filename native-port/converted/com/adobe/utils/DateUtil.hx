package com.adobe.utils;

import flash.errors.Error;
import mx.formatters.DateBase;

class DateUtil
{
    
    public function new()
    {
        super();
    }
    
    public static function getShortMonthName(d : Date) : String
    {
        return DateBase.monthNamesShort[d.getMonth()];
    }
    
    public static function getShortMonthIndex(m : String) : Int
    {
        return DateBase.monthNamesShort.indexOf(m);
    }
    
    public static function getFullMonthName(d : Date) : String
    {
        return DateBase.monthNamesLong[d.getMonth()];
    }
    
    public static function getFullMonthIndex(m : String) : Int
    {
        return DateBase.monthNamesLong.indexOf(m);
    }
    
    public static function getShortDayName(d : Date) : String
    {
        return DateBase.dayNamesShort[d.getDay()];
    }
    
    public static function getShortDayIndex(d : String) : Int
    {
        return DateBase.dayNamesShort.indexOf(d);
    }
    
    public static function getFullDayName(d : Date) : String
    {
        return DateBase.dayNamesLong[d.getDay()];
    }
    
    public static function getFullDayIndex(d : String) : Int
    {
        return DateBase.dayNamesLong.indexOf(d);
    }
    
    public static function getShortYear(d : Date) : String
    {
        var dStr : String = Std.string(d.getFullYear());
        if (dStr.length < 3)
        {
            return dStr;
        }
        return dStr.substr(dStr.length - 2);
    }
    
    public static function compareDates(d1 : Date, d2 : Date) : Int
    {
        var d1ms : Float = d1.getTime();
        var d2ms : Float = d2.getTime();
        if (d1ms > d2ms)
        {
            return -1;
        }
        if (d1ms < d2ms)
        {
            return 1;
        }
        return 0;
    }
    
    public static function getShortHour(d : Date) : Int
    {
        var h : Int = d.hours;
        if (h == 0 || h == 12)
        {
            return 12;
        }
        if (h > 12)
        {
            return as3hx.Compat.parseInt(h - 12);
        }
        return h;
    }
    
    public static function getAMPM(d : Date) : String
    {
        return (d.hours > 11) ? "PM" : "AM";
    }
    
    public static function parseRFC822(str : String) : Date
    {
        var finalDate : Date = null;
        var dateParts : Array<Dynamic> = null;
        var day : String = null;
        var date : Float = Math.NaN;
        var month : Float = Math.NaN;
        var year : Float = Math.NaN;
        var timeParts : Array<Dynamic> = null;
        var hour : Float = Math.NaN;
        var minute : Float = Math.NaN;
        var second : Float = Math.NaN;
        var milliseconds : Float = Math.NaN;
        var timezone : String = null;
        var offset : Float = Math.NaN;
        var multiplier : Float = Math.NaN;
        var oHours : Float = Math.NaN;
        var oMinutes : Float = Math.NaN;
        var eStr : String = null;
        try
        {
            dateParts = str.split(" ");
            day = null;
            if (dateParts[0].search(new as3hx.Compat.Regex('\\d', "")) == -1)
            {
                day = dateParts.shift().replace(new as3hx.Compat.Regex('\\W', ""), "");
            }
            date = as3hx.Compat.parseFloat(dateParts.shift());
            month = as3hx.Compat.parseFloat(DateUtil.getShortMonthIndex(dateParts.shift()));
            year = as3hx.Compat.parseFloat(dateParts.shift());
            timeParts = dateParts.shift().split(":");
            hour = as3hx.Compat.parseInt(timeParts.shift());
            minute = as3hx.Compat.parseInt(timeParts.shift());
            second = (timeParts.length > 0) ? as3hx.Compat.parseInt(timeParts.shift()) : 0;
            milliseconds = Date.UTC(year, month, date, hour, minute, second, 0);
            timezone = dateParts.shift();
            offset = 0;
            if (timezone.search(new as3hx.Compat.Regex('\\d', "")) == -1)
            {
                switch (timezone)
                {
                    case "UT":
                        offset = 0;
                    case "UTC":
                        offset = 0;
                    case "GMT":
                        offset = 0;
                    case "EST":
                        offset = -5 * 3600000;
                    case "EDT":
                        offset = -4 * 3600000;
                    case "CST":
                        offset = -6 * 3600000;
                    case "CDT":
                        offset = -5 * 3600000;
                    case "MST":
                        offset = -7 * 3600000;
                    case "MDT":
                        offset = -6 * 3600000;
                    case "PST":
                        offset = -8 * 3600000;
                    case "PDT":
                        offset = -7 * 3600000;
                    case "Z":
                        offset = 0;
                    case "A":
                        offset = -1 * 3600000;
                    case "M":
                        offset = -12 * 3600000;
                    case "N":
                        offset = 1 * 3600000;
                    case "Y":
                        offset = 12 * 3600000;
                    default:
                        offset = 0;
                }
            }
            else
            {
                multiplier = 1;
                oHours = 0;
                oMinutes = 0;
                if (timezone.length != 4)
                {
                    if (timezone.charAt(0) == "-")
                    {
                        multiplier = -1;
                    }
                    timezone = timezone.substr(1, 4);
                }
                oHours = as3hx.Compat.parseFloat(timezone.substr(0, 2));
                oMinutes = as3hx.Compat.parseFloat(timezone.substr(2, 2));
                offset = (oHours * 3600000 + oMinutes * 60000) * multiplier;
            }
            finalDate = new Date(milliseconds - offset);
            if (Std.string(finalDate) == "Invalid Date")
            {
                throw new Error("This date does not conform to RFC822.");
            }
        }
        catch (e : Error)
        {
            eStr = "Unable to parse the string [" + str + "] into a date. ";
            eStr += "The internal error was: " + Std.string(e);
            throw new Error(eStr);
        }
        return finalDate;
    }
    
    public static function toRFC822(d : Date) : String
    {
        var date : Float = d.getUTCDate();
        var hours : Float = d.getUTCHours();
        var minutes : Float = d.getUTCMinutes();
        var seconds : Float = d.getUTCSeconds();
        var sb : String = new String();
        sb += DateBase.dayNamesShort[d.getUTCDay()];
        sb += ", ";
        if (date < 10)
        {
            sb += "0";
        }
        sb += date;
        sb += " ";
        sb += DateBase.monthNamesShort[d.getUTCMonth()];
        sb += " ";
        sb += d.getUTCFullYear();
        sb += " ";
        if (hours < 10)
        {
            sb += "0";
        }
        sb += hours;
        sb += ":";
        if (minutes < 10)
        {
            sb += "0";
        }
        sb += minutes;
        sb += ":";
        if (seconds < 10)
        {
            sb += "0";
        }
        sb += seconds;
        return sb + " GMT";
    }
    
    public static function parseW3CDTF(str : String) : Date
    {
        var finalDate : Date = null;
        var dateStr : String = null;
        var timeStr : String = null;
        var dateArr : Array<Dynamic> = null;
        var year : Float = Math.NaN;
        var month : Float = Math.NaN;
        var date : Float = Math.NaN;
        var multiplier : Float = Math.NaN;
        var offsetHours : Float = Math.NaN;
        var offsetMinutes : Float = Math.NaN;
        var offsetStr : String = null;
        var timeArr : Array<Dynamic> = null;
        var hour : Float = Math.NaN;
        var minutes : Float = Math.NaN;
        var secondsArr : Array<Dynamic> = null;
        var seconds : Float = Math.NaN;
        var milliseconds : Float = Math.NaN;
        var utc : Float = Math.NaN;
        var offset : Float = Math.NaN;
        var eStr : String = null;
        try
        {
            dateStr = str.substring(0, str.indexOf("T"));
            timeStr = str.substring(str.indexOf("T") + 1, str.length);
            dateArr = dateStr.split("-");
            year = as3hx.Compat.parseFloat(dateArr.shift());
            month = as3hx.Compat.parseFloat(dateArr.shift());
            date = as3hx.Compat.parseFloat(dateArr.shift());
            if (timeStr.indexOf("Z") != -1)
            {
                multiplier = 1;
                offsetHours = 0;
                offsetMinutes = 0;
                timeStr = StringTools.replace(timeStr, "Z", "");
            }
            else if (timeStr.indexOf("+") != -1)
            {
                multiplier = 1;
                offsetStr = timeStr.substring(timeStr.indexOf("+") + 1, timeStr.length);
                offsetHours = as3hx.Compat.parseFloat(offsetStr.substring(0, offsetStr.indexOf(":")));
                offsetMinutes = as3hx.Compat.parseFloat(offsetStr.substring(offsetStr.indexOf(":") + 1, offsetStr.length));
                timeStr = timeStr.substring(0, timeStr.indexOf("+"));
            }
            else
            {
                multiplier = -1;
                offsetStr = timeStr.substring(timeStr.indexOf("-") + 1, timeStr.length);
                offsetHours = as3hx.Compat.parseFloat(offsetStr.substring(0, offsetStr.indexOf(":")));
                offsetMinutes = as3hx.Compat.parseFloat(offsetStr.substring(offsetStr.indexOf(":") + 1, offsetStr.length));
                timeStr = timeStr.substring(0, timeStr.indexOf("-"));
            }
            timeArr = timeStr.split(":");
            hour = as3hx.Compat.parseFloat(timeArr.shift());
            minutes = as3hx.Compat.parseFloat(timeArr.shift());
            secondsArr = (timeArr.length > 0) ? Std.string(timeArr.shift()).split(".") : null;
            seconds = (secondsArr != null && secondsArr.length > 0) ? as3hx.Compat.parseFloat(secondsArr.shift()) : 0;
            milliseconds = (secondsArr != null && secondsArr.length > 0) ? as3hx.Compat.parseFloat(secondsArr.shift()) : 0;
            utc = Date.UTC(year, month - 1, date, hour, minutes, seconds, milliseconds);
            offset = (offsetHours * 3600000 + offsetMinutes * 60000) * multiplier;
            finalDate = new Date(utc - offset);
            if (Std.string(finalDate) == "Invalid Date")
            {
                throw new Error("This date does not conform to W3CDTF.");
            }
        }
        catch (e : Error)
        {
            eStr = "Unable to parse the string [" + str + "] into a date. ";
            eStr += "The internal error was: " + Std.string(e);
            throw new Error(eStr);
        }
        return finalDate;
    }
    
    public static function toW3CDTF(d : Date, includeMilliseconds : Bool = false) : String
    {
        var date : Float = d.getUTCDate();
        var month : Float = d.getUTCMonth();
        var hours : Float = d.getUTCHours();
        var minutes : Float = d.getUTCMinutes();
        var seconds : Float = d.getUTCSeconds();
        var milliseconds : Float = d.getUTCMilliseconds();
        var sb : String = new String();
        sb += d.getUTCFullYear();
        sb += "-";
        if (month + 1 < 10)
        {
            sb += "0";
        }
        sb += month + 1;
        sb += "-";
        if (date < 10)
        {
            sb += "0";
        }
        sb += date;
        sb += "T";
        if (hours < 10)
        {
            sb += "0";
        }
        sb += hours;
        sb += ":";
        if (minutes < 10)
        {
            sb += "0";
        }
        sb += minutes;
        sb += ":";
        if (seconds < 10)
        {
            sb += "0";
        }
        sb += seconds;
        if (includeMilliseconds && milliseconds > 0)
        {
            sb += ".";
            sb += milliseconds;
        }
        return sb + "-00:00";
    }
}


