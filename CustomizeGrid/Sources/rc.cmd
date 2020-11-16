@echo ***********************************************
@echo      COMPILANDO CURSORES de CustomizeGrid
@echo ***********************************************
del CGCur.res
brcc32 CGCur.Rc > Errores.txt

@echo ***********************************************
@echo      COMPILANDO RECURSOS de CustomizeGrid
@echo ***********************************************
del CGRes.res
brcc32 CGRes.rc >> Errores.txt

type Errores.txt 
pause
