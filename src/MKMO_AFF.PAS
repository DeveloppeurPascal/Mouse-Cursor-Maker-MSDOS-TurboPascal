unit mkmo_aff;
{
Auteur: Patrick Premartin
Date: 21/11/1991.
      26/11/1991. (1.0)
Langage: Turbo Pascal 6.0

But: Affichages de Mouse_Maker.
}
interface
procedure aff_decor;
procedure aff_cadre_0;
procedure aff_cadre_1;

implementation
uses
    crt,
    u_couleur,
    u_mou,
    mkmo_var;

procedure encadre (x, y, larg, haut, color : byte);
var
   ota, ox, oy, i : byte;
begin
     if ((x > 1) and (y > 1) and (x+larg < 41) and (y+haut < 25))
     then
         begin
              ota := textattr;
              ox := wherex;
              oy := wherey;
              textcolor (color);
              textbackground (noir);
              for i := pred (x) to x+larg do
                  begin
                       gotoxy (i, pred (y));
                       write (#178);
                       gotoxy (i, y+haut);
                       write (#178);
                  end;
              {endfor}
              for i := pred (y) to y+haut do
                  begin
                       gotoxy (pred (x), i);
                       write (#178);
                       gotoxy (x+larg, i);
                       write (#178);
                  end;
              {endfor}
              gotoxy (ox, oy);
              textattr := ota;
         end;
     {endif}
end; { Encadre }

procedure writexy (x, y : integer; ch : string);
begin
     gotoxy (x, y);
     write (ch);
end; { Writexy }


procedure aff_decor;
begin
     textcolor (blanc);
     textbackground (noir);
     encadre (2, 2, 11, 2, gris_clair);
     encadre (2, 5, 11, 1, gris_clair);
     writexy (2, 2, 'Mouse Maker');
     writexy (6, 3, num_vers);
     writexy (2, 5, #155' PREPAT 91');
     writexy (15, 1, 'F1 New Mouse  F6  Fill');
     writexy (15, 2, 'F2 Save Mouse F7  Copy');
     writexy (15, 3, 'F3 Load Mouse F8  Invert');
     writexy (15, 4, 'F4 Action Pt  F9  Clear');
     writexy (15, 5, 'F5 Test Mouse F10 Quit');
     writexy (19, 8, 'Form');
     writexy (19, 9, #17#188);
     writexy (19, 11, 'Mask');
     writexy (21, 12, #200#16);
     aff_cadre_0;
     aff_cadre_1;
end; { Aff_Decor }

procedure aff_cadre_0;
var
   ox, oy, i, j : byte;
begin
     ox := wherex;
     oy := wherey;
     case cadre of
          0 : begin
                   encadre (c0_dx, c0_dy, c0_lx, c0_ly, blanc);
                   encadre (c1_dx, c1_dy, c1_lx, c1_ly, gris_clair);
          end;
          1 : begin
                   encadre (c0_dx, c0_dy, c0_lx, c0_ly, gris_clair);
                   encadre (c1_dx, c1_dy, c1_lx, c1_ly, blanc);
          end;
     end;
     for i := 1 to 16 do
         for j := 1 to 16 do
             if (form [i, j])
             then
                 writexy (pred (c0_dx+i), pred (c0_dy+j), #219)
             else
                 writexy (pred (c0_dx+i), pred (c0_dy+j), #250);
             {endif}
         {endfor}
     {endfor}
     if (mou <> nil)
     then
         if (form [succ (mou^.act_x), succ (mou^.act_y)])
         then
             writexy (c0_dx+mou^.act_x, c0_dy+mou^.act_y, #178)
         else
             writexy (c0_dx+mou^.act_x, c0_dy+mou^.act_y, #254);
         {endif}
     {endif}
     gotoxy (ox, oy);
end; { Aff_Cadre_0 }

procedure aff_cadre_1;
var
   ox, oy, i, j : byte;
begin
     ox := wherex;
     oy := wherey;
     case cadre of
          0 : begin
                   encadre (c0_dx, c0_dy, c0_lx, c0_ly, blanc);
                   encadre (c1_dx, c1_dy, c1_lx, c1_ly, gris_clair);
          end;
          1 : begin
                   encadre (c0_dx, c0_dy, c0_lx, c0_ly, gris_clair);
                   encadre (c1_dx, c1_dy, c1_lx, c1_ly, blanc);
          end;
     end;
     for i := 1 to 16 do
         for j := 1 to 16 do
             if (mask [i, j])
             then
                 writexy (pred (c1_dx+i), pred (c1_dy+j), #219)
             else
                 writexy (pred (c1_dx+i), pred (c1_dy+j), #250);
             {endif}
         {endfor}
     {endfor}
     if (mou <> nil)
     then
         if (mask [succ (mou^.act_x), succ (mou^.act_y)])
         then
             writexy (c1_dx+mou^.act_x, c1_dy+mou^.act_y, #178)
         else
             writexy (c1_dx+mou^.act_x, c1_dy+mou^.act_y, #254);
         {endif}
     {endif}
     gotoxy (ox, oy);
end; { Aff_Cadre_1 }

end. { Fin de l'unit‚ 'Mkmo_Aff'. }
