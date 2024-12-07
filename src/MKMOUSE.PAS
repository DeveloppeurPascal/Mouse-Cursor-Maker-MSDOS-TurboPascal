program Mouse_Maker;
{
Auteur: Patrick Premartin
Date: 21/11/1991.
      26/11/1991.
      27/11/1991. (1.0)
Langage: Turbo Pascal 6.0

But: Programme de fabrication de fichiers .MOU contenant des formes de souris
     graphiques.
}
uses
    mkmo_aff,
    mkmo_mou,
    mkmo_mod,
    mkmo_prm,
    mkmo_var,
    crt,
    olf_software,
    u_clic,
    u_code_clavier,
    u_couleur,
    u_curseur,
    u_m_util,
    u_mouse,
    u_mou;

var
   fin : boolean;
   i, j,
   xc, yc : integer;
   old_cadre : byte;

procedure mode_texte;
begin { Mode_Texte }
      directvideo := true;
      asm
         push ax
         mov ah, 0
         mov al, 3
         int 10h
         pop ax
      end;
end; { Mode_Texte }

procedure mode_graphique;
begin { Mode_Graphique }
      directvideo := false;
      asm
         push ax
         mov ah, 0
         mov al, 0dh
         int 10h
         pop ax
      end;
end; { Mode_Graphique }

procedure test_var (var xc, yc : integer);
begin
     if xc < 1 then xc := 1;
     if xc > 16 then xc := 16;
     if yc < 1 then yc := 1;
     if yc > 16 then yc := 16;
end; { Test_Var }

begin
     init_olf_message (mess_shareware);
     init_licence ('MKMOU');
     init_olf_software ('Mouse Maker '+num_vers, '(c) Premartin Patrick '+dat_vers);
     traite_param;
     fin := false;
     hide_mouse;
     mode_graphique;
     aff_decor;
     new_mouse;
     repeat
           old_cadre := cadre;
           case cadre of
                0 : begin
                         clic_init (c0_dx, c0_dy, c0_lx, c0_ly);
                         xc := x0;
                         yc := y0;
                end;
                1 : begin
                         clic_init (c1_dx, c1_dy, c1_lx, c1_ly);
                         xc := x1;
                         yc := y1;
                end;
           end;
           clic_clavier (xc, yc, touche);
           clic_mouse (xc, yc, xm, ym);
           if ((xm >= c0_dx) and (xm <c0_dx+c0_lx) and (ym >= c0_dy) and (ym < c0_dy+c0_ly) and (cadre <> 0))
           then
               cadre := 0
           else
               if ((xm >= c1_dx) and (xm <c1_dx+c1_lx) and (ym >= c1_dy) and (ym < c1_dy+c1_ly) and (cadre <> 1))
               then
                   cadre := 1
               else
                   if ((touche = ' ') or ((ym > 7) and ((xm >= c0_dx) and (xm < c0_dx+c0_lx)) or
                                         ((xm >= c1_dx) and (xm < c1_dx+c1_lx))))
                   then
                       begin
                            test_var (xc, yc);
                            hide_mouse;
                            set_point (xc, yc);
                            show_mouse;
                       end;
                   {endif}
               {endif}
           {endif}
           if ((xm > 14) and (xm < 29))
           then
               case ym of
                    1 : touche := touche_f1;
                    2 : touche := touche_f2;
                    3 : touche := touche_f3;
                    4 : touche := touche_f4;
                    5 : touche := touche_f5;
               end
           else
               if (xm > 28)
               then
                   case ym of
                        1 : touche := touche_f6;
                        2 : touche := touche_f7;
                        3 : touche := touche_f8;
                        4 : touche := touche_f9;
                        5 : touche := touche_f10;
                   end;
               {endif}
           {endif}
           if (touche <> carac_nul)
           then
               case touche of
                    touche_f1 : if confirm ('Erase this mouse ?')
                                then
                                    begin
                                         hide_mouse;
                                         new_mouse;
                                         show_mouse;
                                    end;
                                {endif}
                    touche_f2 : save_mou;
                    touche_f3 : load_mou;
                    touche_f4 : begin
                                     while (mousek <> 0) do;
                                     while (mousek = 0) do;
                                     mouse_x_y_txt (i, j);
                                     while (mousek <> 0) do;
                                     if ((j > 7) and (j < 24) and (i >= c0_dx) and (i < c0_dx+c0_lx))
                                     then
                                         begin
                                              mou^.act_x := i - c0_dx;
                                              mou^.act_y := j - c0_dy;
                                         end
                                     else
                                         if ((j > 7) and (j < 24) and (i >= c1_dx) and (i < c1_dx+c1_lx))
                                         then
                                             begin
                                                  mou^.act_x := i - c1_dx;
                                                  mou^.act_y := j - c1_dy;
                                             end;
                                         {endif}
                                     {endif}
                                     aff_cadre_0;
                                     aff_cadre_1;
                    end;
                    touche_f5 : begin
                                     show_mouse;
                                     i := mou_select (1);
                                     alert ('', al_nothing);
                                     i := mou_select (0);
                    end;
                    touche_f6 : case cadre of
                                     0 : if confirm ('Fill the form ?')
                                         then
                                             begin
                                                  for i := 1 to 16 do
                                                      begin
                                                           for j := 1 to 16 do
                                                               form [i, j] := true;
                                                           {endfor}
                                                           mou^.form [i] := $ffff;
                                                      end;
                                                  {endfor}
                                                  aff_cadre_0;
                                             end;
                                         {endif}
                                     1 : if confirm ('Fill the mask ?')
                                         then
                                             begin
                                                  for i := 1 to 16 do
                                                      begin
                                                           for j := 1 to 16 do
                                                               mask [i, j] := true;
                                                           {endfor}
                                                           mou^.mask [i] := $ffff;
                                                      end;
                                                  {endfor}
                                                  aff_cadre_1;
                                             end;
                                         {endif}
                    end;
                    touche_f7 : case cadre of
                                     0 : if confirm ('Copy form to mask ?')
                                         then
                                             begin
                                                  for i := 1 to 16 do
                                                      begin
                                                           for j := 1 to 16 do
                                                               mask [i, j] := form [i, j];
                                                           {endfor}
                                                           mou^.mask [i] := mou^.form [i];
                                                      end;
                                                  {endfor}
                                                  aff_cadre_1;
                                             end;
                                         {endif}
                                     1 : if confirm ('Copy mask to form ?')
                                         then
                                             begin
                                                  for i := 1 to 16 do
                                                      begin
                                                           for j := 1 to 16 do
                                                               form [i, j] := mask [i, j];
                                                           {endfor}
                                                           mou^.form [i] := mou^.mask [i];
                                                      end;
                                                  {endfor}
                                                  aff_cadre_0;
                                             end;
                                         {endif}
                    end;
                    touche_f8 : case cadre of
                                     0 : if confirm ('Invert the Form ?')
                                         then
                                             begin
                                                  for i := 1 to 16 do
                                                      begin
                                                           for j := 1 to 16 do
                                                               form [i, j] := not form [i, j];
                                                           {endfor}
                                                           mou^.form [i] := $ffff-mou^.form [i];
                                                      end;
                                                  {endfor}
                                                  aff_cadre_0;
                                             end;
                                         {endif}
                                     1 : if confirm ('Invert the Mask ?')
                                         then
                                             begin
                                                  for i := 1 to 16 do
                                                      begin
                                                           for j := 1 to 16 do
                                                               mask [i, j] := not mask [i, j];
                                                           {endfor}
                                                           mou^.mask [i] := $ffff-mou^.mask [i];
                                                      end;
                                                  {endfor}
                                                  aff_cadre_1;
                                             end;
                                         {endif}
                    end;
                    touche_f9 : case cadre of
                                     0 : if confirm ('Clear the form ?')
                                         then
                                             begin
                                                  for i := 1 to 16 do
                                                      begin
                                                           for j := 1 to 16 do
                                                               form [i, j] := false;
                                                           {endfor}
                                                           mou^.form [i] := 0;
                                                      end;
                                                  {endfor}
                                                  aff_cadre_0;
                                             end;
                                         {endif}
                                     1 : if confirm ('Clear the mask ?')
                                         then
                                             begin
                                                  for i := 1 to 16 do
                                                      begin
                                                           for j := 1 to 16 do
                                                               mask [i, j] := false;
                                                           {endfor}
                                                           mou^.mask [i] := 0;
                                                      end;
                                                  {endfor}
                                                  aff_cadre_1;
                                             end;
                                         {endif}
                    end;
                    touche_escape,
                    touche_f10 : fin := confirm ('Quit this program ?');
                    touche_tab : begin
                                      cadre := 1-cadre;
                                      hide_mouse;
                                      xc := 1;
                                      yc := 1;
                                      case cadre of
                                           0 : aff_cadre_0;
                                           1 : aff_cadre_1;
                                      end;
                                      show_mouse;
                    end;
               end;
           {endif}
           case old_cadre of
                0 : begin
                         x0 := xc;
                         y0 := yc;
                end;
                1 : begin
                         x1 := xc;
                         y1 := yc;
                end;
           end;
     until fin;
     mode_texte;
     clrscr;
     textcolor (gris_clair);
     textbackground (noir);
     writeln ('Thanks for using Mouse Maker...');
end. { Mouse_Maker }
