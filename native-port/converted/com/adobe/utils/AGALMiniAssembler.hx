package com.adobe.utils;

import flash.display3D.*;
import flash.utils.*;

class AGALMiniAssembler
{
    public var error(get, never) : String;
    public var agalcode(get, never) : ByteArray;

    
    private static var REGEXP_OUTER_SPACES : as3hx.Compat.Regex = new as3hx.Compat.Regex('^\\s+|\\s+$', "g");
    
    private static var initialized : Bool = false;
    
    private static var OPMAP : Dictionary = new Dictionary();
    
    private static var REGMAP : Dictionary = new Dictionary();
    
    private static var SAMPLEMAP : Dictionary = new Dictionary();
    
    private static inline var MAX_NESTING : Int = 4;
    
    private static inline var MAX_OPCODES : Int = 2048;
    
    private static inline var FRAGMENT : String = "fragment";
    
    private static inline var VERTEX : String = "vertex";
    
    private static inline var SAMPLER_TYPE_SHIFT : Int = 8;
    
    private static inline var SAMPLER_DIM_SHIFT : Int = 12;
    
    private static inline var SAMPLER_SPECIAL_SHIFT : Int = 16;
    
    private static inline var SAMPLER_REPEAT_SHIFT : Int = 20;
    
    private static inline var SAMPLER_MIPMAP_SHIFT : Int = 24;
    
    private static inline var SAMPLER_FILTER_SHIFT : Int = 28;
    
    private static inline var REG_WRITE : Int = 1;
    
    private static inline var REG_READ : Int = 2;
    
    private static inline var REG_FRAG : Int = 32;
    
    private static inline var REG_VERT : Int = 64;
    
    private static inline var OP_SCALAR : Int = 1;
    
    private static inline var OP_SPECIAL_TEX : Int = 8;
    
    private static inline var OP_SPECIAL_MATRIX : Int = 16;
    
    private static inline var OP_FRAG_ONLY : Int = 32;
    
    private static inline var OP_VERT_ONLY : Int = 64;
    
    private static inline var OP_NO_DEST : Int = 128;
    
    private static inline var OP_VERSION2 : Int = 256;
    
    private static inline var OP_INCNEST : Int = 512;
    
    private static inline var OP_DECNEST : Int = 1024;
    
    private static inline var MOV : String = "mov";
    
    private static inline var ADD : String = "add";
    
    private static inline var SUB : String = "sub";
    
    private static inline var MUL : String = "mul";
    
    private static inline var DIV : String = "div";
    
    private static inline var RCP : String = "rcp";
    
    private static inline var MIN : String = "min";
    
    private static inline var MAX : String = "max";
    
    private static inline var FRC : String = "frc";
    
    private static inline var SQT : String = "sqt";
    
    private static inline var RSQ : String = "rsq";
    
    private static inline var POW : String = "pow";
    
    private static inline var LOG : String = "log";
    
    private static inline var EXP : String = "exp";
    
    private static inline var NRM : String = "nrm";
    
    private static inline var SIN : String = "sin";
    
    private static inline var COS : String = "cos";
    
    private static inline var CRS : String = "crs";
    
    private static inline var DP3 : String = "dp3";
    
    private static inline var DP4 : String = "dp4";
    
    private static inline var ABS : String = "abs";
    
    private static inline var NEG : String = "neg";
    
    private static inline var SAT : String = "sat";
    
    private static inline var M33 : String = "m33";
    
    private static inline var M44 : String = "m44";
    
    private static inline var M34 : String = "m34";
    
    private static inline var DDX : String = "ddx";
    
    private static inline var DDY : String = "ddy";
    
    private static inline var IFE : String = "ife";
    
    private static inline var INE : String = "ine";
    
    private static inline var IFG : String = "ifg";
    
    private static inline var IFL : String = "ifl";
    
    private static inline var ELS : String = "els";
    
    private static inline var EIF : String = "eif";
    
    private static inline var TED : String = "ted";
    
    private static inline var KIL : String = "kil";
    
    private static inline var TEX : String = "tex";
    
    private static inline var SGE : String = "sge";
    
    private static inline var SLT : String = "slt";
    
    private static inline var SGN : String = "sgn";
    
    private static inline var SEQ : String = "seq";
    
    private static inline var SNE : String = "sne";
    
    private static inline var VA : String = "va";
    
    private static inline var VC : String = "vc";
    
    private static inline var VT : String = "vt";
    
    private static inline var VO : String = "vo";
    
    private static inline var VI : String = "vi";
    
    private static inline var FC : String = "fc";
    
    private static inline var FT : String = "ft";
    
    private static inline var FS : String = "fs";
    
    private static inline var FO : String = "fo";
    
    private static inline var FD : String = "fd";
    
    private static inline var D2 : String = "2d";
    
    private static inline var D3 : String = "3d";
    
    private static inline var CUBE : String = "cube";
    
    private static inline var MIPNEAREST : String = "mipnearest";
    
    private static inline var MIPLINEAR : String = "miplinear";
    
    private static inline var MIPNONE : String = "mipnone";
    
    private static inline var NOMIP : String = "nomip";
    
    private static inline var NEAREST : String = "nearest";
    
    private static inline var LINEAR : String = "linear";
    
    private static inline var ANISOTROPIC2X : String = "anisotropic2x";
    
    private static inline var ANISOTROPIC4X : String = "anisotropic4x";
    
    private static inline var ANISOTROPIC8X : String = "anisotropic8x";
    
    private static inline var ANISOTROPIC16X : String = "anisotropic16x";
    
    private static inline var CENTROID : String = "centroid";
    
    private static inline var SINGLE : String = "single";
    
    private static inline var IGNORESAMPLER : String = "ignoresampler";
    
    private static inline var REPEAT : String = "repeat";
    
    private static inline var WRAP : String = "wrap";
    
    private static inline var CLAMP : String = "clamp";
    
    private static inline var REPEAT_U_CLAMP_V : String = "repeat_u_clamp_v";
    
    private static inline var CLAMP_U_REPEAT_V : String = "clamp_u_repeat_v";
    
    private static inline var RGBA : String = "rgba";
    
    private static inline var DXT1 : String = "dxt1";
    
    private static inline var DXT5 : String = "dxt5";
    
    private static inline var VIDEO : String = "video";
    
    private var _agalcode : ByteArray = null;
    
    private var _error : String = "";
    
    private var debugEnabled : Bool = false;
    
    public var verbose : Bool = false;
    
    public function new(debugging : Bool = false)
    {
        super();
        this.debugEnabled = debugging;
        if (!initialized)
        {
            init();
        }
    }
    
    private static function init() : Void
    {
        initialized = true;
        Reflect.setField(OPMAP, MOV, new OpCode(MOV, 2, 0, 0));
        Reflect.setField(OPMAP, ADD, new OpCode(ADD, 3, 1, 0));
        Reflect.setField(OPMAP, SUB, new OpCode(SUB, 3, 2, 0));
        Reflect.setField(OPMAP, MUL, new OpCode(MUL, 3, 3, 0));
        Reflect.setField(OPMAP, DIV, new OpCode(DIV, 3, 4, 0));
        Reflect.setField(OPMAP, RCP, new OpCode(RCP, 2, 5, 0));
        Reflect.setField(OPMAP, MIN, new OpCode(MIN, 3, 6, 0));
        Reflect.setField(OPMAP, MAX, new OpCode(MAX, 3, 7, 0));
        Reflect.setField(OPMAP, FRC, new OpCode(FRC, 2, 8, 0));
        Reflect.setField(OPMAP, SQT, new OpCode(SQT, 2, 9, 0));
        Reflect.setField(OPMAP, RSQ, new OpCode(RSQ, 2, 10, 0));
        Reflect.setField(OPMAP, POW, new OpCode(POW, 3, 11, 0));
        Reflect.setField(OPMAP, LOG, new OpCode(LOG, 2, 12, 0));
        Reflect.setField(OPMAP, EXP, new OpCode(EXP, 2, 13, 0));
        Reflect.setField(OPMAP, NRM, new OpCode(NRM, 2, 14, 0));
        Reflect.setField(OPMAP, SIN, new OpCode(SIN, 2, 15, 0));
        Reflect.setField(OPMAP, COS, new OpCode(COS, 2, 16, 0));
        Reflect.setField(OPMAP, CRS, new OpCode(CRS, 3, 17, 0));
        Reflect.setField(OPMAP, DP3, new OpCode(DP3, 3, 18, 0));
        Reflect.setField(OPMAP, DP4, new OpCode(DP4, 3, 19, 0));
        Reflect.setField(OPMAP, ABS, new OpCode(ABS, 2, 20, 0));
        Reflect.setField(OPMAP, NEG, new OpCode(NEG, 2, 21, 0));
        Reflect.setField(OPMAP, SAT, new OpCode(SAT, 2, 22, 0));
        Reflect.setField(OPMAP, M33, new OpCode(M33, 3, 23, OP_SPECIAL_MATRIX));
        Reflect.setField(OPMAP, M44, new OpCode(M44, 3, 24, OP_SPECIAL_MATRIX));
        Reflect.setField(OPMAP, M34, new OpCode(M34, 3, 25, OP_SPECIAL_MATRIX));
        Reflect.setField(OPMAP, DDX, new OpCode(DDX, 2, 26, OP_VERSION2 | OP_FRAG_ONLY));
        Reflect.setField(OPMAP, DDY, new OpCode(DDY, 2, 27, OP_VERSION2 | OP_FRAG_ONLY));
        Reflect.setField(OPMAP, IFE, new OpCode(IFE, 2, 28, OP_NO_DEST | OP_VERSION2 | OP_INCNEST | OP_SCALAR));
        Reflect.setField(OPMAP, INE, new OpCode(INE, 2, 29, OP_NO_DEST | OP_VERSION2 | OP_INCNEST | OP_SCALAR));
        Reflect.setField(OPMAP, IFG, new OpCode(IFG, 2, 30, OP_NO_DEST | OP_VERSION2 | OP_INCNEST | OP_SCALAR));
        Reflect.setField(OPMAP, IFL, new OpCode(IFL, 2, 31, OP_NO_DEST | OP_VERSION2 | OP_INCNEST | OP_SCALAR));
        Reflect.setField(OPMAP, ELS, new OpCode(ELS, 0, 32, OP_NO_DEST | OP_VERSION2 | OP_INCNEST | OP_DECNEST | OP_SCALAR));
        Reflect.setField(OPMAP, EIF, new OpCode(EIF, 0, 33, OP_NO_DEST | OP_VERSION2 | OP_DECNEST | OP_SCALAR));
        Reflect.setField(OPMAP, KIL, new OpCode(KIL, 1, 39, OP_NO_DEST | OP_FRAG_ONLY));
        Reflect.setField(OPMAP, TEX, new OpCode(TEX, 3, 40, OP_FRAG_ONLY | OP_SPECIAL_TEX));
        Reflect.setField(OPMAP, SGE, new OpCode(SGE, 3, 41, 0));
        Reflect.setField(OPMAP, SLT, new OpCode(SLT, 3, 42, 0));
        Reflect.setField(OPMAP, SGN, new OpCode(SGN, 2, 43, 0));
        Reflect.setField(OPMAP, SEQ, new OpCode(SEQ, 3, 44, 0));
        Reflect.setField(OPMAP, SNE, new OpCode(SNE, 3, 45, 0));
        Reflect.setField(SAMPLEMAP, RGBA, new Sampler(RGBA, SAMPLER_TYPE_SHIFT, 0));
        Reflect.setField(SAMPLEMAP, DXT1, new Sampler(DXT1, SAMPLER_TYPE_SHIFT, 1));
        Reflect.setField(SAMPLEMAP, DXT5, new Sampler(DXT5, SAMPLER_TYPE_SHIFT, 2));
        Reflect.setField(SAMPLEMAP, VIDEO, new Sampler(VIDEO, SAMPLER_TYPE_SHIFT, 3));
        Reflect.setField(SAMPLEMAP, D2, new Sampler(D2, SAMPLER_DIM_SHIFT, 0));
        Reflect.setField(SAMPLEMAP, D3, new Sampler(D3, SAMPLER_DIM_SHIFT, 2));
        Reflect.setField(SAMPLEMAP, CUBE, new Sampler(CUBE, SAMPLER_DIM_SHIFT, 1));
        Reflect.setField(SAMPLEMAP, MIPNEAREST, new Sampler(MIPNEAREST, SAMPLER_MIPMAP_SHIFT, 1));
        Reflect.setField(SAMPLEMAP, MIPLINEAR, new Sampler(MIPLINEAR, SAMPLER_MIPMAP_SHIFT, 2));
        Reflect.setField(SAMPLEMAP, MIPNONE, new Sampler(MIPNONE, SAMPLER_MIPMAP_SHIFT, 0));
        Reflect.setField(SAMPLEMAP, NOMIP, new Sampler(NOMIP, SAMPLER_MIPMAP_SHIFT, 0));
        Reflect.setField(SAMPLEMAP, NEAREST, new Sampler(NEAREST, SAMPLER_FILTER_SHIFT, 0));
        Reflect.setField(SAMPLEMAP, LINEAR, new Sampler(LINEAR, SAMPLER_FILTER_SHIFT, 1));
        Reflect.setField(SAMPLEMAP, ANISOTROPIC2X, new Sampler(ANISOTROPIC2X, SAMPLER_FILTER_SHIFT, 2));
        Reflect.setField(SAMPLEMAP, ANISOTROPIC4X, new Sampler(ANISOTROPIC4X, SAMPLER_FILTER_SHIFT, 3));
        Reflect.setField(SAMPLEMAP, ANISOTROPIC8X, new Sampler(ANISOTROPIC8X, SAMPLER_FILTER_SHIFT, 4));
        Reflect.setField(SAMPLEMAP, ANISOTROPIC16X, new Sampler(ANISOTROPIC16X, SAMPLER_FILTER_SHIFT, 5));
        Reflect.setField(SAMPLEMAP, CENTROID, new Sampler(CENTROID, SAMPLER_SPECIAL_SHIFT, 1 << 0));
        Reflect.setField(SAMPLEMAP, SINGLE, new Sampler(SINGLE, SAMPLER_SPECIAL_SHIFT, 1 << 1));
        Reflect.setField(SAMPLEMAP, IGNORESAMPLER, new Sampler(IGNORESAMPLER, SAMPLER_SPECIAL_SHIFT, 1 << 2));
        Reflect.setField(SAMPLEMAP, REPEAT, new Sampler(REPEAT, SAMPLER_REPEAT_SHIFT, 1));
        Reflect.setField(SAMPLEMAP, WRAP, new Sampler(WRAP, SAMPLER_REPEAT_SHIFT, 1));
        Reflect.setField(SAMPLEMAP, CLAMP, new Sampler(CLAMP, SAMPLER_REPEAT_SHIFT, 0));
        Reflect.setField(SAMPLEMAP, CLAMP_U_REPEAT_V, new Sampler(CLAMP_U_REPEAT_V, SAMPLER_REPEAT_SHIFT, 2));
        Reflect.setField(SAMPLEMAP, REPEAT_U_CLAMP_V, new Sampler(REPEAT_U_CLAMP_V, SAMPLER_REPEAT_SHIFT, 3));
    }
    
    private function get_error() : String
    {
        return this._error;
    }
    
    private function get_agalcode() : ByteArray
    {
        return this._agalcode;
    }
    
    public function assemble2(ctx3d : Context3D, version : Int, vertexsrc : String, fragmentsrc : String) : Program3D
    {
        var agalvertex : ByteArray = this.assemble(VERTEX, vertexsrc, version);
        var agalfragment : ByteArray = this.assemble(FRAGMENT, fragmentsrc, version);
        var prog : Program3D = ctx3d.createProgram();
        prog.upload(agalvertex, agalfragment);
        return prog;
    }
    
    public function assemble(mode : String, source : String, version : Int = 1, ignorelimits : Bool = false) : ByteArray
    {
        var i : Int = 0;
        var line : String = null;
        var startcomment : Int = 0;
        var optsi : Int = 0;
        var opts : Array<Dynamic> = null;
        var opCode : Array<Dynamic> = null;
        var opFound : OpCode = null;
        var regs : Array<Dynamic> = null;
        var badreg : Bool = false;
        var pad : Int = 0;
        var regLength : Int = 0;
        var j : Int = 0;
        var isRelative : Bool = false;
        var relreg : Array<Dynamic> = null;
        var res : Array<Dynamic> = null;
        var regFound : Register = null;
        var idxmatch : Array<Dynamic> = null;
        var regidx : Int = 0;
        var regmask : Int = 0;
        var maskmatch : Array<Dynamic> = null;
        var isDest : Bool = false;
        var isSampler : Bool = false;
        var reltype : Int = 0;
        var relsel : Int = 0;
        var reloffset : Int = 0;
        var cv : Int = 0;
        var maskLength : Int = 0;
        var k : Int = 0;
        var relname : Array<Dynamic> = null;
        var regFoundRel : Register = null;
        var selmatch : Array<Dynamic> = null;
        var relofs : Array<Dynamic> = null;
        var samplerbits : Int = 0;
        var optsLength : Int = 0;
        var bias : Float = Math.NaN;
        var optfound : Sampler = null;
        var dbgLine : String = null;
        var agalLength : Int = 0;
        var index : Int = 0;
        var byteStr : String = null;
        var start : Int = as3hx.Compat.parseInt(Math.round(haxe.Timer.stamp() * 1000));
        this._agalcode = new ByteArray();
        this._error = "";
        var isFrag : Bool = false;
        if (mode == FRAGMENT)
        {
            isFrag = true;
        }
        else if (mode != VERTEX)
        {
            this._error = "ERROR: mode needs to be \"" + FRAGMENT + "\" or \"" + VERTEX + "\" but is \"" + mode + "\".";
        }
        this.agalcode.endian = Endian.LITTLE_ENDIAN;
        this.agalcode.writeByte(160);
        this.agalcode.writeUnsignedInt(version);
        this.agalcode.writeByte(161);
        this.agalcode.writeByte((isFrag) ? 1 : 0);
        this.initregmap(version, ignorelimits);
        var lines : Array<Dynamic> = new as3hx.Compat.Regex('[\\f\\n\\r\\v]+', "g").replace(source, "\n").split("\n");
        var nest : Int = 0;
        var nops : Int = 0;
        var lng : Int = as3hx.Compat.parseInt(lines.length);
        i = 0;
        while (i < lng && this._error == "")
        {
            line = new String(lines[i]);
            line = REGEXP_OUTER_SPACES.replace(line, "");
            startcomment = line.search("//");
            if (startcomment != -1)
            {
                line = line.substring(0, startcomment);
            }
            optsi = line.search(new as3hx.Compat.Regex('<.*>', "g"));
            if (optsi != -1)
            {
                opts = line.substring(optsi).match(new as3hx.Compat.Regex('([\\w\\.\\-\\+]+)', "gi"));
                line = line.substring(0, optsi);
            }
            opCode = line.match(new as3hx.Compat.Regex('^\\w{3}', "ig"));
            if (opCode == null)
            {
                if (line.length >= 3)
                {
                    trace("warning: bad line " + i + ": " + lines[i]);
                }
            }
            else
            {
                opFound = Reflect.field(OPMAP, Std.string(opCode[0]));
                if (this.debugEnabled)
                {
                    trace(opFound);
                }
                if (opFound == null)
                {
                    if (line.length >= 3)
                    {
                        trace("warning: bad line " + i + ": " + lines[i]);
                    }
                }
                else
                {
                    line = line.substring(line.search(opFound.name) + opFound.name.length);
                    if (cast(opFound.flags & OP_VERSION2, Bool) && version < 2)
                    {
                        this._error = "error: opcode requires version 2.";
                        break;
                    }
                    if (cast(opFound.flags & OP_VERT_ONLY, Bool) && isFrag)
                    {
                        this._error = "error: opcode is only allowed in vertex programs.";
                        break;
                    }
                    if (cast(opFound.flags & OP_FRAG_ONLY, Bool) && !isFrag)
                    {
                        this._error = "error: opcode is only allowed in fragment programs.";
                        break;
                    }
                    if (this.verbose)
                    {
                        trace("emit opcode=" + opFound);
                    }
                    this.agalcode.writeUnsignedInt(opFound.emitCode);
                    if (++nops > MAX_OPCODES)
                    {
                        this._error = "error: too many opcodes. maximum is " + MAX_OPCODES + ".";
                        break;
                    }
                    regs = line.match(new as3hx.Compat.Regex('vc\\[([vof][acostdip]?)(\\d*)?(\\.[xyzw](\\+\\d{1,3})?)?\\](\\.[xyzw]{1,4})?|([vof][acostdip]?)(\\d*)?(\\.[xyzw]{1,4})?', "gi"));
                    if (regs == null || regs.length != opFound.numRegister)
                    {
                        this._error = "error: wrong number of operands. found " + regs.length + " but expected " + opFound.numRegister + ".";
                        break;
                    }
                    badreg = false;
                    pad = as3hx.Compat.parseInt(64 + 64 + 32);
                    regLength = regs.length;
                    for (j in 0...regLength)
                    {
                        isRelative = false;
                        relreg = regs[j].match(new as3hx.Compat.Regex('\\[.*\\]', "ig"));
                        if (cast(relreg, Bool) && relreg.length > 0)
                        {
                            regs[j] = regs[j].replace(relreg[0], "0");
                            if (this.verbose)
                            {
                                trace("IS REL");
                            }
                            isRelative = true;
                        }
                        res = regs[j].match(new as3hx.Compat.Regex('^\\b[A-Za-z]{1,2}', "ig"));
                        if (res == null)
                        {
                            this._error = "error: could not parse operand " + j + " (" + regs[j] + ").";
                            badreg = true;
                            break;
                        }
                        regFound = Reflect.field(REGMAP, Std.string(res[0]));
                        if (this.debugEnabled)
                        {
                            trace(regFound);
                        }
                        if (regFound == null)
                        {
                            this._error = "error: could not find register name for operand " + j + " (" + regs[j] + ").";
                            badreg = true;
                            break;
                        }
                        if (isFrag)
                        {
                            if ((regFound.flags & REG_FRAG) == 0)
                            {
                                this._error = "error: register operand " + j + " (" + regs[j] + ") only allowed in vertex programs.";
                                badreg = true;
                                break;
                            }
                            if (isRelative)
                            {
                                this._error = "error: register operand " + j + " (" + regs[j] + ") relative adressing not allowed in fragment programs.";
                                badreg = true;
                                break;
                            }
                        }
                        else if ((regFound.flags & REG_VERT) == 0)
                        {
                            this._error = "error: register operand " + j + " (" + regs[j] + ") only allowed in fragment programs.";
                            badreg = true;
                            break;
                        }
                        regs[j] = regs[j].slice(regs[j].search(regFound.name) + regFound.name.length);
                        idxmatch = (isRelative) ? relreg[0].match(new as3hx.Compat.Regex('\\d+', "")) : regs[j].match(new as3hx.Compat.Regex('\\d+', ""));
                        regidx = 0;
                        if (idxmatch != null)
                        {
                            regidx = as3hx.Compat.parseInt(idxmatch[0]);
                        }
                        if (regFound.range < regidx)
                        {
                            this._error = "error: register operand " + j + " (" + regs[j] + ") index exceeds limit of " + (regFound.range + 1) + ".";
                            badreg = true;
                            break;
                        }
                        regmask = 0;
                        maskmatch = regs[j].match(new as3hx.Compat.Regex('(\\.[xyzw]{1,4})', ""));
                        isDest = j == 0 && !(opFound.flags & OP_NO_DEST);
                        isSampler = j == 2 && cast(opFound.flags & OP_SPECIAL_TEX, Bool);
                        reltype = 0;
                        relsel = 0;
                        reloffset = 0;
                        if (isDest && isRelative)
                        {
                            this._error = "error: relative can not be destination";
                            badreg = true;
                            break;
                        }
                        if (maskmatch != null)
                        {
                            regmask = 0;
                            maskLength = as3hx.Compat.parseInt(maskmatch[0].length);
                            for (k in 1...maskLength)
                            {
                                cv = as3hx.Compat.parseInt(maskmatch[0].charCodeAt(k) - "x".charCodeAt(0));
                                if (cv > 2)
                                {
                                    cv = 3;
                                }
                                if (isDest)
                                {
                                    regmask = regmask | as3hx.Compat.parseInt(1 << cv);
                                }
                                else
                                {
                                    regmask = regmask | as3hx.Compat.parseInt(cv << (k - 1 << 1));
                                }
                            }
                            if (!isDest)
                            {
                                while (k <= 4)
                                {
                                    regmask = regmask | as3hx.Compat.parseInt(cv << (k - 1 << 1));
                                    k++;
                                }
                            }
                        }
                        else
                        {
                            regmask = (isDest) ? 15 : 228;
                        }
                        if (isRelative)
                        {
                            relname = relreg[0].match(new as3hx.Compat.Regex('[A-Za-z]{1,2}', "ig"));
                            regFoundRel = Reflect.field(REGMAP, Std.string(relname[0]));
                            if (regFoundRel == null)
                            {
                                this._error = "error: bad index register";
                                badreg = true;
                                break;
                            }
                            reltype = regFoundRel.emitCode;
                            selmatch = relreg[0].match(new as3hx.Compat.Regex('(\\.[xyzw]{1,1})', ""));
                            if (selmatch.length == 0)
                            {
                                this._error = "error: bad index register select";
                                badreg = true;
                                break;
                            }
                            relsel = as3hx.Compat.parseInt(selmatch[0].charCodeAt(1) - "x".charCodeAt(0));
                            if (relsel > 2)
                            {
                                relsel = 3;
                            }
                            relofs = relreg[0].match(new as3hx.Compat.Regex('\\+\\d{1,3}', "ig"));
                            if (relofs.length > 0)
                            {
                                reloffset = as3hx.Compat.parseInt(relofs[0]);
                            }
                            if (reloffset < 0 || reloffset > 255)
                            {
                                this._error = "error: index offset " + reloffset + " out of bounds. [0..255]";
                                badreg = true;
                                break;
                            }
                            if (this.verbose)
                            {
                                trace("RELATIVE: type=" + reltype + "==" + relname[0] + " sel=" + relsel + "==" + selmatch[0] + " idx=" + regidx + " offset=" + reloffset);
                            }
                        }
                        if (this.verbose)
                        {
                            trace("  emit argcode=" + regFound + "[" + regidx + "][" + regmask + "]");
                        }
                        if (isDest)
                        {
                            this.agalcode.writeShort(regidx);
                            this.agalcode.writeByte(regmask);
                            this.agalcode.writeByte(regFound.emitCode);
                            pad -= 32;
                        }
                        else if (isSampler)
                        {
                            if (this.verbose)
                            {
                                trace("  emit sampler");
                            }
                            samplerbits = 5;
                            optsLength = (opts == null) ? 0 : opts.length;
                            bias = 0;
                            for (k in 0...optsLength)
                            {
                                if (this.verbose)
                                {
                                    trace("    opt: " + opts[k]);
                                }
                                optfound = Reflect.field(SAMPLEMAP, Std.string(opts[k]));
                                if (optfound == null)
                                {
                                    bias = as3hx.Compat.parseFloat(opts[k]);
                                    if (this.verbose)
                                    {
                                        trace("    bias: " + bias);
                                    }
                                }
                                else
                                {
                                    if (optfound.flag != SAMPLER_SPECIAL_SHIFT)
                                    {
                                        samplerbits = samplerbits & as3hx.Compat.parseInt(~(15 << optfound.flag));
                                    }
                                    samplerbits = samplerbits | as3hx.Compat.parseInt(as3hx.Compat.parseInt(optfound.mask) << as3hx.Compat.parseInt(optfound.flag));
                                }
                            }
                            this.agalcode.writeShort(regidx);
                            this.agalcode.writeByte(as3hx.Compat.parseInt(bias * 8));
                            this.agalcode.writeByte(0);
                            this.agalcode.writeUnsignedInt(samplerbits);
                            if (this.verbose)
                            {
                                trace("    bits: " + (samplerbits - 5));
                            }
                            pad -= 64;
                        }
                        else
                        {
                            if (j == 0)
                            {
                                this.agalcode.writeUnsignedInt(0);
                                pad -= 32;
                            }
                            this.agalcode.writeShort(regidx);
                            this.agalcode.writeByte(reloffset);
                            this.agalcode.writeByte(regmask);
                            this.agalcode.writeByte(regFound.emitCode);
                            this.agalcode.writeByte(reltype);
                            this.agalcode.writeShort((isRelative) ? relsel | 1 << 15 : 0);
                            pad -= 64;
                        }
                    }
                    j = 0;
                    while (j < pad)
                    {
                        this.agalcode.writeByte(0);
                        j += 8;
                    }
                    if (badreg)
                    {
                        break;
                    }
                }
            }
            i++;
        }
        if (this._error != "")
        {
            this._error += "\n  at line " + i + " " + lines[i];
            this.agalcode.length = 0;
            trace(this._error);
        }
        if (this.debugEnabled)
        {
            dbgLine = "generated bytecode:";
            agalLength = this.agalcode.length;
            for (index in 0...agalLength)
            {
                if (!(index % 16))
                {
                    dbgLine += "\n";
                }
                if (!(index % 4))
                {
                    dbgLine += " ";
                }
                byteStr = Std.string(this.agalcode[index]);
                if (byteStr.length < 2)
                {
                    byteStr = "0" + byteStr;
                }
                dbgLine += byteStr;
            }
            trace(dbgLine);
        }
        if (this.verbose)
        {
            trace("AGALMiniAssembler.assemble time: " + (Math.round(haxe.Timer.stamp() * 1000) - start) / 1000 + "s");
        }
        return this.agalcode;
    }
    
    private function initregmap(version : Int, ignorelimits : Bool) : Void
    {
        Reflect.setField(REGMAP, VA, new Register(VA, "vertex attribute", 0, (ignorelimits) ? 1024 : ((version == 1 || version == 2) ? 7 : 15), REG_VERT | REG_READ));
        Reflect.setField(REGMAP, VC, new Register(VC, "vertex constant", 1, (ignorelimits) ? 1024 : ((version == 1) ? 127 : 249), REG_VERT | REG_READ));
        Reflect.setField(REGMAP, VT, new Register(VT, "vertex temporary", 2, (ignorelimits) ? 1024 : ((version == 1) ? 7 : 25), REG_VERT | REG_WRITE | REG_READ));
        Reflect.setField(REGMAP, VO, new Register(VO, "vertex output", 3, (ignorelimits) ? 1024 : 0, REG_VERT | REG_WRITE));
        Reflect.setField(REGMAP, VI, new Register(VI, "varying", 4, (ignorelimits) ? 1024 : ((version == 1) ? 7 : 9), REG_VERT | REG_FRAG | REG_READ | REG_WRITE));
        Reflect.setField(REGMAP, FC, new Register(FC, "fragment constant", 1, (ignorelimits) ? 1024 : ((version == 1) ? 27 : ((version == 2) ? 63 : 199)), REG_FRAG | REG_READ));
        Reflect.setField(REGMAP, FT, new Register(FT, "fragment temporary", 2, (ignorelimits) ? 1024 : ((version == 1) ? 7 : 25), REG_FRAG | REG_WRITE | REG_READ));
        Reflect.setField(REGMAP, FS, new Register(FS, "texture sampler", 5, (ignorelimits) ? 1024 : 7, REG_FRAG | REG_READ));
        Reflect.setField(REGMAP, FO, new Register(FO, "fragment output", 3, (ignorelimits) ? 1024 : ((version == 1) ? 0 : 3), REG_FRAG | REG_WRITE));
        Reflect.setField(REGMAP, FD, new Register(FD, "fragment depth output", 6, (ignorelimits) ? 1024 : ((version == 1) ? -1 : 0), REG_FRAG | REG_WRITE));
        Reflect.setField(REGMAP, "op", Reflect.field(REGMAP, VO));
        Reflect.setField(REGMAP, "i", Reflect.field(REGMAP, VI));
        Reflect.setField(REGMAP, "v", Reflect.field(REGMAP, VI));
        Reflect.setField(REGMAP, "oc", Reflect.field(REGMAP, FO));
        Reflect.setField(REGMAP, "od", Reflect.field(REGMAP, FD));
        Reflect.setField(REGMAP, "fi", Reflect.field(REGMAP, VI));
    }
}


class OpCode
{
    public var emitCode(get, never) : Int;
    public var flags(get, never) : Int;
    public var name(get, never) : String;
    public var numRegister(get, never) : Int;

    
    private var _emitCode : Int;
    
    private var _flags : Int;
    
    private var _name : String;
    
    private var _numRegister : Int;
    
    public function new(name : String, numRegister : Int, emitCode : Int, flags : Int)
    {
        super();
        this._name = name;
        this._numRegister = numRegister;
        this._emitCode = emitCode;
        this._flags = flags;
    }
    
    private function get_emitCode() : Int
    {
        return this._emitCode;
    }
    
    private function get_flags() : Int
    {
        return this._flags;
    }
    
    private function get_name() : String
    {
        return this._name;
    }
    
    private function get_numRegister() : Int
    {
        return this._numRegister;
    }
    
    public function toString() : String
    {
        return "[OpCode name=\"" + this._name + "\", numRegister=" + this._numRegister + ", emitCode=" + this._emitCode + ", flags=" + this._flags + "]";
    }
}

class Register
{
    public var emitCode(get, never) : Int;
    public var longName(get, never) : String;
    public var name(get, never) : String;
    public var flags(get, never) : Int;
    public var range(get, never) : Int;

    
    private var _emitCode : Int;
    
    private var _name : String;
    
    private var _longName : String;
    
    private var _flags : Int;
    
    private var _range : Int;
    
    public function new(name : String, longName : String, emitCode : Int, range : Int, flags : Int)
    {
        super();
        this._name = name;
        this._longName = longName;
        this._emitCode = emitCode;
        this._range = range;
        this._flags = flags;
    }
    
    private function get_emitCode() : Int
    {
        return this._emitCode;
    }
    
    private function get_longName() : String
    {
        return this._longName;
    }
    
    private function get_name() : String
    {
        return this._name;
    }
    
    private function get_flags() : Int
    {
        return this._flags;
    }
    
    private function get_range() : Int
    {
        return this._range;
    }
    
    public function toString() : String
    {
        return "[Register name=\"" + this._name + "\", longName=\"" + this._longName + "\", emitCode=" + this._emitCode + ", range=" + this._range + ", flags=" + this._flags + "]";
    }
}

class Sampler
{
    public var flag(get, never) : Int;
    public var mask(get, never) : Int;
    public var name(get, never) : String;

    
    private var _flag : Int;
    
    private var _mask : Int;
    
    private var _name : String;
    
    public function new(name : String, flag : Int, mask : Int)
    {
        super();
        this._name = name;
        this._flag = flag;
        this._mask = mask;
    }
    
    private function get_flag() : Int
    {
        return this._flag;
    }
    
    private function get_mask() : Int
    {
        return this._mask;
    }
    
    private function get_name() : String
    {
        return this._name;
    }
    
    public function toString() : String
    {
        return "[Sampler name=\"" + this._name + "\", flag=\"" + this._flag + "\", mask=" + this.mask + "]";
    }
}
