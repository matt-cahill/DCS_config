_  = function(p) return p; end;
name = _('A-10C Mini Cockpit - 4K');
Description = 'Setup for A-10C Mini Cockpit MFCD and RWR Exports.'
Viewports =
{
     Center =
     {
          x = 0;
          y = 0;
          width = 3840;
          height = 2160;
          viewDx = 0;
          viewDy = 0;
          aspect = 1.7777777777777777777777777778;
     }
}

LEFT_MFCD =
{
    x = 12;
    y = 2484;
    width = 440;
    height = 440;
}

RIGHT_MFCD =
{
    x = 912;
    y = 2484;
    width = 440;
    height = 440;
}

ED_A10C_RWR =
{
    x = 0;
    y = 2160;
    width = 260;
    height = 260;
}

--CDU_EXPORT

UIMainView = Viewports.Center
