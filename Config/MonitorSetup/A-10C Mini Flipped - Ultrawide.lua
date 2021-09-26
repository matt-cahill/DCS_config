_  = function(p) return p; end;
name = _('A-10C Mini Flipped - Ultrawide');
Description = 'Setup for A-10C Mini Cockpit MFCD and RWR Exports.'
Viewports =
{
     Center =
     {
          x = 0;
          y = 0;
          width = 5120;
          height = 1440;
          viewDx = 0;
          viewDy = 0;
          aspect  = 5120/1440;
     }
}

LEFT_MFCD =
{
    x = 5150;
    y = 330;
    width = 620;
    height = 620;
}

RIGHT_MFCD =
{
    x = 6388;
    y = 330;
    width = 620;
    height = 620;
}

RWR_SCREEN =
{
    x = 5120;
    y = 0;
    width = 365;
    height = 365;
}

--CDU_EXPORT

-- F-16
F16_RWR =
{
    x = 5208;
    y = 0;
    width = 365;
    height = 365;
}

F16_DED =
{
x = 6628;
y = 20;
width = 390;
height = 134;
}

EHSI =
{
x = 5976;
y = 840;
width = 208;
height = 208;
}


UIMainView = Viewports.Center
