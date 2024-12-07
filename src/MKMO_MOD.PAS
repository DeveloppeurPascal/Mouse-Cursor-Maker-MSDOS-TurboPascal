unit mkmo_mod;
{
Auteur: Patrick Premartin
Date: 21/11/1991.
      26/11/1991.
      27/11/1991. (1.0)
Langage: Turbo Pascal 6.0

But: Modification des cadres de Mouse_Maker.
}
interface
procedure set_point (x, y : byte);
procedure clear_mouse;
procedure new_mouse;

implementation
uses
    u_couleur,
    u_mou,
    mkmo_aff,
    mkmo_var;

procedure set_point (x, y : byte);
begin
     case cadre of
          0 : begin
                   form [x, y] := not form [x, y];
                   if (form [x, y])
                   then
                       mou^.form [y] := (mou^.form [y] or (1 shl (16-x)))
                   else
                       mou^.form [y] := (mou^.form [y] xor (1 shl (16-x)));
                   {endif}
                   aff_cadre_0;
          end;
          1 : begin
                   mask [x, y] := not mask [x, y];
                   if (mask [x, y])
                   then
                       mou^.mask [y] := (mou^.mask [y] or (1 shl (16-x)))
                   else
                       mou^.mask [y] := (mou^.mask [y] xor (1 shl (16-x)));
                   {endif}
                   aff_cadre_1;
          end;
     end;
end; { Set_Point }

procedure clear_mouse;
var
   i, j : integer;
begin
     for i := 1 to 16 do
         begin
              for j := 1 to 16 do
                  begin
                       form [i, j] := false;
                       mask [i, j] := false;
                  end;
              {endfor}
              mou^.form [i] := 0;
              mou^.mask [i] := 0;
         end;
     {endfor}
     mou^.act_x := 0;
     mou^.act_y := 0;
end; { Clear_Mouse }

procedure new_mouse;
begin
     clear_mouse;
     aff_cadre_0;
     aff_cadre_1;
     xm := 0;
     ym := 0;
     touche := #0;
end; { New_Mouse }

end. { Fin de l'unit‚ 'Mkmo_Mod'. }
