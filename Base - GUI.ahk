#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance, force


; Funções 

clickSleep(x,y,tempo){
  Click %x% %y%
  Sleep, 500
  Sleep, %tempo%
}

storeClipboard(){
 Send, ^c
 Sleep, 100
 return clipboard
}

abreProcesso(){
 Sleep, 100
 clickSleep(110,210,1000)
 Sleep, 1000
}

pasteVariable(variable){
clipboard := variable
  Sleep, 500
    Send, ^v
  Sleep 250
}

pasteDate(dataProcesso){
 Send, {Tab}
  Sleep, 100
 clipboard := dataProcesso
  Sleep, 300
 Send, +{Home}
  Sleep 300
 Send, ^v
  Sleep 100
 Send, {Enter}
  Sleep 100
}

selecionaSecao(PosAcompanhamentoY, PosMarcadorY){
  ; Acompanhamento
  Sleep, 1000
  clickSleep(500,300,500) ; Dropdown Acompanhamento
  clickSleep(430, PosAcompanhamentoY, 500) ; Seleciona seção correta no Acompanhamento
  clickSleep(1220,245,500) ; Salvar acompanhamento
  
  ; Marcador
  Sleep, 1000
  clickSleep(1120,215,500) ;Abre o menu adequado
  clickSleep(500,295,500) ; Dropdown
  clickSleep(500, PosMarcadorY, 500) ; Seleciona a seção correta no Marcador
  clickSleep(500,345,500) ; Seleciona a caixa de texto
  Send, [Notion] -
}

catalogaProcesso(secao){
 Gui, Hide
 Sleep, 500
 
 abreProcesso()
 Sleep, 1000
 
 ; Clica no Alterar Processo e Captura Conteúdo
 Sleep, 500
 clickSleep(480,220,2000)
 Click, 440 300 3
 Sleep, 500
 
 Send, {Tab 3}
 conteudo := storeClipboard()
 Sleep, 500
  
 
 ; Volta ao index
 abreProcesso()
 
 ; Anotações
 Sleep, 500
 clickSleep(950,215,1500) ;Menu
 Sleep, 1000
 Send, [Em andamento]
 Sleep, 500
 clickSleep(395,385,500) ;Prioridade
 Sleep, 500
 clickSleep(1290,250,500) ;Salvar anotação
 
 ; Base Acompanhamento 
 clickSleep(515,220,1000) ;Abre Menu
 Sleep, 1000
 clickSleep(490,350,1000) ;Caixa de Texto
 pasteVariable(conteudo)
 
  if (secao = "SAAD")
 {
     selecionaSecao(390, 545)
 }
 else if (secao = "SOP")
 {
     selecionaSecao(360, 445)
 }
 else if (secao = "Almox")
 {
     selecionaSecao(330, 370)
 }
 else if (secao = "Comando")
 {
     selecionaSecao(345, 470)
 }
 
}

F8:: 
{
 ; Abre informações do processo
 clickSleep(130,215,1500)
 clickSleep(480,220, 1500)
 
 ; Clica e capturando Número do Processo
 Click, 440 300 3
  Sleep, 400
 nProcesso := storeClipboard()
  Sleep 200
 
 ; Capturando Data
 Send, {Tab}
  Sleep, 200
 dataProcesso := storeClipboard()
  Sleep, 100
 
 ; Capturando Conteúdo
 Send, {Tab 2}
 conteudo := storeClipboard()
  Sleep, 200
 
 ; Notion
 Run https://www.notion.so/e6da81ef6af24b1981019957ec7ff6c0?v=34656084e96d4efdb4c702d688327205
 Sleep, 15000
 
 ; Criar nova entrada
 clickSleep(1300,270,1000)
 
 ; Colando o Processo
 pasteVariable(nProcesso)
 
 ; Colando o Teor
 Send, {Tab}
 Sleep, 200
 pasteVariable(conteudo)
 
 ; Colando a Data
 pasteDate(dataProcesso)
 clickSleep(800,500,250)
 
 ;Indo pra sessão 
 clickSleep(550,480,100)
return
}