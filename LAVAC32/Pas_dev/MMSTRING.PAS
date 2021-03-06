{************************************************}
{                                                }
{   Unit� MMSTRING                               }
{                                                }
{   Projet LAVAC                                 }
{                                                }
{  (c) 1992-94 C Puissance 3 Informatique        }
{              MORGAN MULTIMEDIA                 }
{                                                }
{  par Guillaume de Bailliencourt                }
{                                                }
{  16/05/1994                                    }
{                                                }
{************************************************}

UNIT MMSTRING;

interface

uses Windows, Strings
		 {$IFDEF _DEBUG}
		 ,MMDEBUG
		 {$ENDIF};

const
ERR_CREATEFILE 		= 48; {Erreur de cr�ation de fichier.}
ERR_OPENFILE 			= 49; {Erreur d''ouverture de fichier.}
ERR_CREATECHUNK 	= 50; {Erreur de cr�ation du chunk.}
ERR_MEMALLOC 			= 51; {Erreur d''allocation m�moire.}
ERR_PREPARHDR 		= 52; {Erreur de pr�paration du block pour le p�riph�rique.}
ERR_NEXTBLOCK 		= 53; {Erreur � l''enregistrement d''un block audio.}
ERR_WAVPERIPH 		= 54; {Erreur sur p�riph�rique audio.}
ERR_MCI 					= 55; {Erreur MCI}
ERR_LESSONNAME 		= 56; {Le nom de la le�on est incorrect, modifiez le et recommencez.}
ERR_LESSONEXIST 	= 57; {Cette le�on existe d�j�, \nvoulez vous :\n       la supprimer ? : [OUI]
												 \n       rajouter des sequences �
												 \n       l''ancienne ? : [NON]}
ERR_EXT 					= 58; {Ces fichiers ne sont li�s � aucune application.}
ERR_LOCALSPACE 		= 59; {Il est Impossible d''utiliser la vid�o en local, \nl'espace disque local est insuffisant.\n
												 \nManquant : %lu octets}
ERR_DOSNUM 				= 60; {Erreur Dos : %d}
ERR_IONUM 				= 61; {Erreur I/O : %d}
STR_NONAME 				= 62; {Sans nom}
STR_STOP 					= 63; {&Stop}
STR_REC 					= 64; {Enregistre}
STR_START 				= 65; {&D�marre}
STR_PAUSE 				= 66; {Pause}
STR_RESTART 			= 67; {Enreg reprise}
STR_ENDREC 				= 68; {Enreg %d fin}
STR_STARTREC 			= 69; {Enreg %d d�but}
STR_BLANKREC 			= 70; {Enreg %d blanc}
STR_PROCESSREC 		= 71; {Enreg %d en cours}
STR_BLANK 				= 72; {Blanc : %ds}
STR_INSERTDISK 		= 73; {Ins�rez une disquette format�e et vierge...}
STR_INSNEXTDISK 	= 74; {Ins�rez le disque suivant de la sauvegarde...}
STR_INSANSDISK 		= 75; {Ins�rez la disquette ou se trouvent les r�ponses...}
STR_INSLASTDISK 	= 76; {Ins�rez la disquette suivante ou Annulez si la restauration est termin�e...}
STR_TEACHER 			= 77; {Professeur}
STR_STUDENT 			= 78; {Etudiant}
STR_LESSON 				= 79; {Le�on}
STR_TEACHSTUD 		= 80; {Prof/Etud}
STR_EXE 					= 81; {Executable}
STR_BMP 					= 82; {Fichiers Image}
STR_AVI 					= 83; {Fichiers Vid�o}
STR_TXT 					= 84; {Fichiers Texte}
STR_WAV 					= 85; {Fichiers Son}
STR_QCM 					= 86; {Fichier QCM}
STR_LINKBMP 			= 87; {Image : Li�e}
STR_LINKAVI 			= 88; {Vid�o : Li�e}
STR_LINKTXT 			= 89; {Texte : Li�e}
STR_LINKWAV 			= 90; {Son : Li�e}
STR_LINKQCM 			= 91; {QCM : Li�e}
STR_UNLINKBMP 		= 92; {Image : Non li�e}
STR_UNLINKAVI 		= 93; {Vid�o : Non li�e}
STR_UNLINKTXT 		= 94; {Texte : Non li�e}
STR_UNLINKWAV 		= 95; {Son : Non li�e}
STR_UNLINKQCM 		= 96; {QCM : Non li�e}
STR_INITPOS 			= 97; {Position Initiale}
STR_STRECHED 			= 98; {Taille Adapt�e}
STR_QCMANS 				= 99; {R�ponses QCM}
STR_QCMEDIT 			= 100; {Modifier}
STR_QCMHIDE 			= 101; {Cacher la fen�tre QCM}
ERR_LOCALAVI 			= 102; {Impossible d''utiliser la vid�o en Local}
STR_STOPTEACH 		= 103; {Stop Prof}
STR_STOPSTUD 			= 104; {Stop Etud}
STR_STOPTEACHSTUD = 105; {Stop P/E}
STR_STOPREC 			= 106; {Stop Enreg}
STR_NONE 					= 107; {&Rien}
STR_ALL 					= 108; {&Tout}
STR_RESTORE 			= 109; {Restauration R�ponses}
STR_ENDRESTORE 		= 110; {Restauration termin�e.}
STR_MSG 					= 111; {Message}
STR_MSGSEL 				= 112; {Le professeur vous envoie une Le�on... Soyez prets � r�pondre...}
STR_MSGBMP 				= 113; {Le professeur vous envoie une image...}
STR_MSGTXT 				= 114; {Le professeur vous envoie un texte...}
STR_MSGWAV 				= 115; {Le professeur vous envoie un message sonore...}
STR_NEXT 					= 116; {Suite}
ERR_DIADIR 				= 117; {Ecoute ou Enregistrement sonore en cours, stoppez la pour dialoguer en direct.}
STR_DIADIR 				= 118; {Dialogue direct}
STR_STUDCON 			= 119; {Poste �tudiant}
STR_SENDSEL 			= 120; {Envoi aux �tudiants s�lectionn�s de la le�on No }

ERR_SRCDISK 			= 121; {Impossible d'acc�der � l'unit� source, op�ration interrompue.}
ERR_DSTDISK 			= 122; {Impossible d'acc�der � l'unit� cible, op�ration interrompue.}
ERR_ERR 		 			= 123; {Erreur}
ERR_SPCDISK 			= 124; {L'espace total requis sur l'unit� cible est insuffisant, op�ration interrompue.}
STR_REMOVABLE			= 125; { (Amovible)}
STR_FIXED					= 126; { (Fixe)}
STR_KO						= 127; {%lu Ko}
STR_NOTKO					= 128; {? x %lu Ko}
STR_KOTOTAL				= 129; {%lu Ko total}
STR_NOTKOTOTAL		= 130; {? Ko total}
STR_KOFREE				= 131; {%lu Ko libre}
ERR_SRCLESSON			= 132; {Le fichier le�on source n'existe pas, op�ration interrompue.}
STR_CREATELESSON	= 133; {Cr�ation du fichier le�on, s�quence n� %d...}
STR_COPYLESSON		= 134; {Copie du fichier le�on...}
STR_COPYFILE			= 135; {Copie du fichier\n}
STR_CURFILE				= 136; {\nFichier en cours : }
STR_COMPRESSLESSON= 137; {Compression des fichiers de la le�on...}
STR_COMPRESSFILE	= 138; {Compression du fichier }
STR_DELTEMP				= 139; {Destruction des fichiers temporaires...}
STR_WAITCOPY			= 140; {Copie en cours...}
STR_WAITRESTORE		= 141; {Restauration en cours...}
STR_WAITBACKUP		= 142; {Archivage en cours...}
STR_DELLESSON			= 143; {Voulez vous vraiment supprimer la le�on : \n}
STR_DEL						= 144; {Supprimer}
STR_LST						= 145; {Le�ons LAVAC}


STR_TITRE         = 200; {QCM...}
ERR_GLOBALALLOC   = 201; {QCM...}
STR_QUITTE        = 202; {QCM...}
STR_OPEN          = 203; {QCM...}
ERR_STREAMERROR   = 204; {QCM...}
STR_TEXTLOAD      = 205; {QCM...}
STR_LOADLINE      = 206; {QCM...}
STR_SAVELINE      = 207; {QCM...}
STR_FIN           = 208; {QCM...}
STR_INCORRECT     = 210; {QCM...}
STR_APPEL         = 211; {QCM...}
STR_TOLINK        = 212; {QCM...}
STR_TOUNLINK      = 213; {QCM...}
STR_QUITTER       = 214; {QCM...}

STR_CMDFIRST      = 1000; {Commandes Lavac}

STR_ERRORFIRST    = 2000;

STR_MSGFIRST	    = 3000;

function mmLoadString(hInst : THANDLE; nID : integer) : PChar;

implementation
function mmLoadString(hInst : THANDLE; nID : integer) : PChar;

const alpszDup : Array[0..3] of PChar = (nil, nil, nil, nil);
			nDup 		 : integer = 0;
var szLoadString : Array[0..255] of char;

begin
	mmLoadString := '#Err!'+#0;
	if LoadString(hInst, nID, szLoadString, SizeOf(szLoadString)) > 0 then begin
		if alpszDup[nDup] <> nil then StrDispose(alpszDup[nDup]);
		alpszDup[nDup] := StrNew(szLoadString);
		if alpszDup[nDup] <> nil then begin
			mmLoadString := alpszDup[nDup];
			Inc(nDup);
			if nDup > 3 then nDup := 0;
		end;
	end;
end;

end.
