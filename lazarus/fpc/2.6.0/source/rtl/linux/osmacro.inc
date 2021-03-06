{
    Copyright (c) 2000-2002 by Marco van de Voort

    The "linux" posixy macro's that are used both in the Baseunx unit as the
    system unit. Not aliased via public names because I want these to be
    inlined as much as possible in the future.

    This program is free software; you can redistribute it and/or modify it
    under the terms of the GNU General Public License as published by the
    Free Software Foundation; either version 2 of the License, or (at your
    option) any later version.

    This program is distributed in the hope that it will be useful, but
    WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
    General Public License for more details.

    You should have received a copy of the GNU General Public License along
    with this program; if not, write to the Free Software Foundation, Inc.,
    675 Mass Ave, Cambridge, MA 02139, USA.

 ****************************************************************************
}

function FpS_ISDIR(m : TMode): boolean;

begin
  FpS_ISDIR:=((m and S_IFMT) = S_IFDIR);
end;

function FpS_ISCHR(m : TMode): boolean;
begin
  FpS_ISCHR:=((m and S_IFMT) = S_IFCHR);
end;

function FpS_ISBLK(m : TMode): boolean;
begin
 FpS_ISBLK:=((m and S_IFMT) = S_IFBLK);
end;

function FpS_ISREG(m : TMode): boolean;
begin
 FpS_ISREG:=((m and S_IFMT) = S_IFREG);
end;

function FpS_ISFIFO(m : TMode): boolean;
begin
 FpS_ISFIFO:=((m and S_IFMT) = S_IFIFO);
end;

Function FPS_ISLNK(m:TMode):boolean;

begin
 FPS_ISLNK:=((m and S_IFMT) = S_IFLNK);
end;

Function FPS_ISSOCK(m:TMode):boolean;

begin
 FPS_ISSOCK:=((m and S_IFMT) = S_IFSOCK);
end;

function wifexited(status : cint): boolean;
begin
 wifexited:=(status AND $7f) =0;
end;

function wexitstatus(status : cint): cint;
begin
 wexitstatus:=(status and $FF00) shr 8;
end;

function wstopsig(status : cint): cint;
begin
 wstopsig:=(status and $FF00) shr 8;
end;

const wstopped=127;

function wifsignaled(status : cint): boolean;
begin
 wifsignaled:=((status and $FF)<>wstopped) and ((status and 127)<>0);
end;

function wtermsig(status : cint):cint;

begin
 wtermsig:=cint(status and 127);
end;


{$ifdef FPC_USE_LIBC}
function __fxstat(__ver,filedes : cint; var __stat: tstat): cint; cdecl; external clib name '__fxstat'+suffix64bit;
function __xstat(__ver : cint;FileName: PChar; var __stat: tstat): cint; cdecl; external clib name '__xstat'+suffix64bit;
function __lxstat(__ver : cint; FileName: PChar; var __stat: tstat): cint; cdecl; external clib name '__lxstat'+suffix64bit;
{
function __fxstat64(__ver : cint; FileDes: Integer; var __stat: tstat): cint; cdecl; external clib name '__fxstat64';
function __xstat64(__ver : cint; FileName: PChar; var __stat: tstat): cint; cdecl; external clib name '__xstat64';
function __lxstat64(__ver : cint; FileName: PChar; var __stat: tstat): cint; cdecl; external clib name '__lxstat64';
function __xmknod(__ver : cint; Pathname: PChar; Mode: mode_t; var Device: dev_t): cint; cdecl; external clib name '__xmknod';
}
{$define FPC_HAS_BASEUNIX_STAT}
function  FpFstat(fd : cint; var sb : stat): cint;inline;
  begin
    __fxstat(_STAT_VER,fd,sb);
  end;


function  fpLstat(path:pchar;Info:pstat):cint;inline;
  begin
    __lxstat(_STAT_VER,path,Info^);
  end;


function  FpStat(path: pchar; var buf : stat): cint;inline;
  begin
    __xstat(_STAT_VER,path,buf);
  end;

{$ifndef fs32bit}
function  FpOpen    (path: pchar; flags : cint; mode: TMode):cint; inline;
  begin
    FpOpen:=__fpopen(path, flags or O_LARGEFILE, mode);
  end;
{$endif}

{$endif FPC_USE_LIBC}
