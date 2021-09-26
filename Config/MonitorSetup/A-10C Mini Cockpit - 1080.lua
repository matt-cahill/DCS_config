_  = function(p) return p; end;
name = _('A-10C Mini Cockpit - 1080');
Description = 'Setup for A-10C Mini Cockpit MFCD and RWR Exports.'
Viewports =
{
     Center =
     {
          x = 0;
          y = 0;
          width = 1920;
          height = 1080;
          viewDx = 0;
          viewDy = 0;
          aspect = 1.7777777777777777777777777778;
     }
}

LEFT_MFCD =
{
    x = 12;
    y = 1404;
    width = 440;
    height = 440;
}

RIGHT_MFCD =
{
    x = 912;
    y = 1404;
    width = 440;
    height = 440;
}

RWR_SCREEN =
{
    x = 0;
    y = 1080;
    width = 260;
    height = 260;
}

--CDU_EXPORT

UIMainView = Viewports.Center
