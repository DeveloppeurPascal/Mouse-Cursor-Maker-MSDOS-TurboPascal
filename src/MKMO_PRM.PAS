unit mkmo_prm;
{
Auteur: Patrick Premartin
Date: 21/11/1991.
      26/11/1991. (1.0)
Langage: Turbo Pascal 6.0

But: Gestion des paramŠtres de Mouse_Maker.
}
interface
procedure traite_param;

implementation
uses
    mkmo_mou,
    u_m_util,
    u_parametre;

procedure traite_param;
var
   i : integer;
begin
     if (param_del ('/H'))
     then
         begin
              writeln ('Syntax:');
              writeln ('       mkmouse [/h] [/ffile_name]');
              writeln;
              writeln ('/h for this short help screen.');
              writeln ('/f to load (or create) File_Name.MOU');
              alert ('Please press a key...', al_nothing);
         end;
     {endif}
     for i := 1 to paramcount do
         if ((copy (paramstr (i), 1, 2) = '/f') or (copy (paramstr (i), 1, 2) = '/F'))
         then
             begin
                  mou_fich_name := copy (paramstr (i), 3, length (paramstr (i)));
                  load_mou;
             end;
         {endif}
     {endfor}
end; { Traite_Param }

end. { Fin de l'unit‚ 'Mkmo_Prm'. }
