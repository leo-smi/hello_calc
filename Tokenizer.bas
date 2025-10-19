B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=13.4
@EndOfDesignText@
' Tokenizer.bas - Módulo separado para tokenização de expressões matemáticas

Sub Process_Globals
End Sub

' Função principal: Tokeniza uma expressão matemática
Sub Tokenize(expr As String) As List
	Dim tokens As List
	tokens.Initialize
	Dim i As Int = 0
    
	Do While i < expr.Length
		Dim c As String = expr.CharAt(i)
        
		' Verifica se é um sinal unário (+ ou −)
		If (c = "-" Or c = "+") Then
			Dim isUnary As Boolean = False
            
			If i = 0 Then
				isUnary = True
			Else
				Dim prevChar As String = expr.CharAt(i - 1)
				If "+-*/(".IndexOf(prevChar) >= 0 Then isUnary = True
			End If
            
			If isUnary Then
				tokens.Add("(")
				If c = "-" Then tokens.Add("-1") Else tokens.Add("1")
				tokens.Add("*")
                
				i = i + 1
				Dim startNum As Int = i
				Do While i < expr.Length
					c = expr.CharAt(i)
					If (c >= "0" And c <= "9") Or c = "." Then
						i = i + 1
					Else
						Exit
					End If
				Loop
                
				If i > startNum Then
					tokens.Add(expr.SubString2(startNum, i))
				Else
					tokens.Add("0")
				End If
                
				tokens.Add(")")
				Continue
			End If
		End If
        
		If "+-*/()".IndexOf(c) >= 0 Then
			tokens.Add(c)
			i = i + 1
		Else
			Dim start As Int = i
			Do While i < expr.Length
				c = expr.CharAt(i)
				If "+-*/()".IndexOf(c) >= 0 Then Exit
				i = i + 1
			Loop
			tokens.Add(expr.SubString2(start, i))
		End If
	Loop
    
	Return tokens
End Sub

' Função auxiliar: Verifica se uma string é numérica
Sub IsNumericString(s As String) As Boolean
	If s.Length = 0 Then Return False
	s = s.Trim
	Return IsNumber(s)
End Sub

' Função auxiliar: Retorna a precedência de operadores
Sub Precedence(op As String) As Int
	If op = "*" Or op = "/" Then Return 2
	Return 1
End Sub