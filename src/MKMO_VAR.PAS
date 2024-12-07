unit mkmo_var;
{
Auteur: Patrick Premartin
Date: 21/11/1991.
      26/11/1991.
      27/11/1991. (1.0)
Langage: Turbo Pascal 6.0.

But: Variables de Mouse_Maker.
}
interface
uses
    u_mou;

const
     num_vers : string [3] = '1.0';
     dat_vers : string [10] = '27/11/1991';
     c0_dx = 2; c0_dy = 8; c0_lx = 16; c0_ly = 16;
     c1_dx = 24; c1_dy = 8; c1_lx = 16; c1_ly = 16;

type
    t_fm = array [1..16, 1..16] of boolean;

var
   mou : p_mou;
   cadre : byte;
   form : t_fm;
   mask : t_fm;
   touche : char;
   xm, ym : integer;
   x0, y0, x1, y1 : integer;

implementation
procedure mkmo_var_init;
var
   i, j : integer;
begin
     for i := 1 to 16 do
         for j := 1 to 16 do
             begin
                  form [i, j] := false;
                  mask [i, j] := false;
             end;
         {endfor}
     {endfor}
     mou := nil;
     cadre := 0;
     touche := #0;
     xm := 0;
     ym := 0;
     x0 := c0_dx;
     y0 := c0_dy;
     x1 := c1_dx;
     y1 := c1_dy;
end; { Mkmo_Var_Init }

var
   old_exitproc : pointer;

{$f+}
procedure mkmo_var_exit;
begin
     exitproc := old_exitproc;
end; { Mkmo_Var_Exit }

begin
     mkmo_var_init;
     old_exitproc := exitproc;
     exitproc := @mkmo_var_exit;
end. { Fin de l'unit‚ 'Mkmo_Var'. }
