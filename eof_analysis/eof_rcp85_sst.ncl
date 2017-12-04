; ==============================================================
; =============================================================
; This script uses functions eofunc_n_Wrap and eofunc_ts_n_Wrap
;  which were added in NCL V6.4.0.
; =============================================================

begin
  neof   = 3
;*******************************************
;  Read data
;*******************************************
  diri = "./RCP85_projection/SST/"
  fili = "b.e11.BRCP85C5CNBDRD.f09_g16.ensmean.pop.h.sst.200601-208012_regrid.nc"

  f    = addfile (diri+fili, "r")
  sst    = f->SST            ; (time,lat,lon) ==> (29,60,180)
  ;x = dim_rmvmean_n_Wrap(sst,0)
  x = dtrend_leftdim (sst(0:74,:,:),False)
  printVarSummary(x) 
  figname = "eof_sst_rcp85" 
;*******************************************
;  EOF 
;*******************************************
  optEof = True
  eof    = eofunc_n_Wrap( x, neof, optEof, 0)
  eof_ts = eofunc_ts_n_Wrap( x, eof, False, 0)

  ;printVarSummary(eof)
  ;printVarSummary(eof_ts)
;*******************************************
;  plots
;*******************************************
  wks = gsn_open_wks("png",figname)         ; send graphics to PNG file

  plot = new(2,graphic)                ; create graphic array
                                          ; only needed if paneling
  res                      = True         
  res@gsnDraw              = False        ; don't draw yet
  res@gsnFrame             = False        ; don't advance frame yet
  res@gsnAddCyclic         = False        ; data not cyclic
  res@cnFillPalette        = "BlueYellowRed"   ; choose colormap
  res@cnFillPalette        = "ncl_default"   ; choose colormap
 
  res@mpCenterLonF         = 180.         ; default is 0 [GM]
  res@mpMinLatF            = min(x&lat)
  res@mpMaxLatF            = max(x&lat)
  res@mpMinLonF            = min(x&lon)
  res@mpMaxLonF            = max(x&lon)
  res@mpFillDrawOrder      = "PostDraw"
  res@cnLevelSelectionMode = "ManualLevels"
  res@cnLevelSpacingF = 0.001
  res@cnMinLevelValF = -0.02 
  res@cnMaxLevelValF = 0.02

  res@cnFillOn             = True         ; turn on color fill
  res@cnLinesOn            = False         ; True is default
  res@lbLabelBarOn         = True        ; turn off individual lb's
  res@lbPerimOn             = False              ; no box around it
  res@lbBoxLinesOn          = False
  
  ;symMinMaxPlt(eof, 16, False, res); contributed.ncl

; panel plot only resources
  resP                     = True         ; modify the panel plot
  resP@gsnMaximize         = True         ; large format
  resP@gsnPanelLabelBar    = True         ; add common colorbar
  
  eof1 = -1*eof
  copy_VarMeta(eof,eof1)
  res@gsnLeftString  = "EOF "+(1)
  res@gsnRightString = sprintf("%5.1f", eof@pcvar(0)) +"%"
  plot(0) = gsn_csm_contour_map_ce(wks,eof1(1,:,:),res)
;
;*******************************************
; time series (principal component) plot
;*******************************************
  eof_ts@long_name = "Amplitude"

  rts           = True
  rts@gsnDraw   = False       ; don't draw yet
  rts@gsnFrame  = False       ; don't advance frame yet
  rts@trXMinF  = 2010                  ; min value on x-axis
  rts@trXMaxF  = 2080
  rts@trYMinF  = -20                     ; min value on y-axis
  rts@trYMaxF  = 21
 

; these four resources allow the user to stretch the plot size, and
; decide exactly where on the page to draw it.

  rts@vpHeightF = 0.3        ; Changes the aspect ratio
  rts@vpWidthF  = 0.8
  rts@vpXF      = 0.10        ; change start locations
  rts@vpYF      = 0.75        ; the plot

  rts@gsnYRefLine           = 0.              ; reference line   
  rts@gsnAboveYRefLineColor = "red"           ; above ref line fill red
  rts@gsnBelowYRefLineColor = "blue"          ; below ref line fill blue
  rts@gsnYRefLineColor = "transparent"
  rts@tmYLLabelFontHeightF = 0.017
  rts@gsnLeftStringFontHeightF = 0.017

; panel plot only resources
  rtsP                     = True             ; modify the panel plot
  rtsP@gsnMaximize         = True             ; large format
  rts@tmXBLabelFontHeightF = 0.017
  rts@tmYLLabelFontHeightF = 0.017
  rts@tmXBFormat = "f"
  
  eof_ts@long_name =""   
  rts@gsnLeftString  = "Amplitude"
  time = cd_calendar(x&time,4) 
  plot(1) = gsn_csm_xy (wks,time,eof_ts(1,:),rts)
  gsn_panel(wks,plot,(/2,1/),rtsP)        ; draw all 'neof' as one plot
  system("convert -trim "+figname + ".png "+figname+".png")
end
