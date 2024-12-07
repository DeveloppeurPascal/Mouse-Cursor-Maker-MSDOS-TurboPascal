unit mkmo_mou;
{
Auteur: Patrick Premartin
Date: 21/11/1991.
      26/11/1991.
      27/11/1991. (1.0)
Langage: Turbo Pascal 6.0

But: Sauvegardes et chargements des souris de Mouse_Maker.
}
interface
var
   mou_fich_name : string;

procedure load_mou;
procedure save_mou;

implementation
uses
    dos,
    mkmo_aff,
    mkmo_mod,
    mkmo_var,
    u_mou,
    u_m_util;

procedure init_mou;
var
   res : byte;
begin
     new (mou);
     if (mou = nil)
     then
         begin
              writeln ('Out of memory...');
              halt (1);
         end;
     {endif}
     mou^.act_x := 0;
     mou^.act_y := 0;
     res := mou_register (mou, 1);
end; { Init_Mou }

procedure load_mou;
var
   dir : dirstr;
   ext : extstr;
   name : namestr;
   res : byte;
   i, j : integer;
begin
     mou_fich_name := get_fich_name (mou_fich_name, 'MOU');
     fsplit (mou_fich_name, dir, name, ext);
     if confirm ('Load '+name+ext+' ?')
     then
         begin
              if (mou <> nil)
              then
                  res := mou_erase (1);
              {endif}
              mou := mou_load (mou_fich_name);
              if (mou = nil)
              then
                  begin
                       alert ('Loading error !', al_error);
                       init_mou;
                  end
              else
                  res := mou_register (mou, 1);
              {endif}
              for i := 1 to 16 do
                  for j := 1 to 16 do
                      begin
                           form [i, j] := (mou^.form [j] and (1 shl (16-i)) > 0);
                           mask [i, j] := (mou^.mask [j] and (1 shl (16-i)) > 0);
                      end;
                  {endfor}
              {endfor}
              cadre := 0;
              aff_cadre_0;
              aff_cadre_1;
         end;
     {endif}
end; { Load_Mou }

procedure save_mou;
var
   dir : dirstr;
   ext : extstr;
   name : namestr;
begin
     mou_fich_name := get_fich_name (mou_fich_name, 'MOU');
     fsplit (mou_fich_name, dir, name, ext);
     if confirm ('Save '+name+ext+' ?')
     then
         if (mou_save (mou_fich_name, 1) <> 0)
         then
             alert ('Saving error !', al_error);
         {endif}
     {endif}
end; { Save_Mou }

begin
     init_mou;
     mou_fich_name := 'MKMOUSE.MOU';
end. { Fin de l'unit‚ 'Mkmo_Mou'. }
