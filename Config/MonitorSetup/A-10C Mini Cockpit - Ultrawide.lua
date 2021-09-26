_  = function(p) return p; end;
name = _('A-10C Mini Cockpit - Ultrawide');
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
    y = 450;
    width = 620;
    height = 620;
}

RIGHT_MFCD =
{
    x = 6388;
    y = 450;
    width = 620;
    height = 620;
}

-- F-16
F_16C_DED = { x = 6760, y = 2, width = 280, height = 90 }
F_16C_EHSI = { x = 5979, y = 841, width = 207, height = 207 }
F_16C_RWR = { x = 5120, y = 2, width = 225, height = 225 }

UIMainView = Viewports.Center
GU_MAIN_VIEWPORT = Viewports.Center
