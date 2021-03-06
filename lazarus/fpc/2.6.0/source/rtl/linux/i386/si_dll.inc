{
    This file is part of the Free Pascal run time library.
    Copyright (c) 2005 by Michael Van Canneyt, Peter Vreman,
    & Daniel Mantione, members of the Free Pascal development team.

    See the file COPYING.FPC, included in this distribution,
    for details about the copyright.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

 **********************************************************************}
{$asmmode att}
{$goto on}
{
 Linux ELF startup code for Free Pascal


 Stack layout at program start:

         nil
         envn
         ....
         ....           ENVIRONMENT VARIABLES
         env1
         env0
         nil
         argn
         ....
         ....           COMMAND LINE OPTIONS
         arg1
         arg0
         argc <--- esp
}

procedure PASCALMAIN; external name 'PASCALMAIN';

function get1eipasebx : pointer; compilerproc; nostackframe; assembler; 
asm  
  movl (%esp),%ebx  
  ret  
end;

{******************************************************************************
                        Shared library start/halt
 ******************************************************************************}

procedure _FPC_shared_lib_start(argc : dword;argv,envp : pointer); cdecl; public name 'FPC_SHARED_LIB_START'; public name '_start';
begin

  operatingsystem_parameter_argc:=argc;    { Copy the argument count      }
  operatingsystem_parameter_argv:=argv;    { Copy the argument pointer    }
  operatingsystem_parameter_envp:=envp;    { Copy the environment pointer }

  IsLibrary:=true;

  asm
    { Save initial stackpointer }
    {$ifdef FPC_PIC}
        call  get1eipasebx
        addl  $_GLOBAL_OFFSET_TABLE_,%ebx
        movl  initialstkptr@GOT(%ebx),%ecx
	movl  %esp,(%ecx)
    {$else FPC_PIC}
	movl    %esp,initialstkptr
    {$endif FPC_PIC}
  end;

  PASCALMAIN;
end;

{ this routine is only called when the halt() routine of the RTL embedded in
  the shared library is called }
procedure _FPC_shared_lib_haltproc; assembler; nostackframe; public name 'FPC_SHARED_LIB_EXIT'; public name '_haltproc';
asm
.Lhaltproc:
 {$ifdef FPC_PIC}
  call    get1eipasebx
  addl    $_GLOBAL_OFFSET_TABLE_,%ebx
  movl    ExitCode@GOT(%ebx),%ebx
 {$if sizeof(ExitCode)=2}
  movzwl  (%ebx),%ebx
 {$else}
  mov     (%ebx),%ebx
 {$endif}
{$else FPC_PIC}
 {$if sizeof(ExitCode)=2}
  movzwl  ExitCode,%ebx
 {$else}
  mov     ExitCode,%ebx
 {$endif}
{$endif FPC_PIC}
  xorl    %eax,%eax
  incl    %eax                    { eax=1, exit call }
  int     $0x80
  jmp     .Lhaltproc
end;
