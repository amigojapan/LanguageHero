--internationalization and localization implementation by amigojapan
--dictionary for english, kept in seperate file you can include it by require("localizations.lua")
i18n={}
i18n["English"]={
	["Choose Game Mode"]="Choose Game Mode",
	["Play"]="Play",
	["Study"]="Study",
	["Language"]="English",
	["Start"]="Start!",
	["Nokori"]="",
	["Punkan"]=" Minutes Left",
	["verb"]="verbs",
	["animal"]="animals",
	["vehicle"]="vehicles",
	["philosopher"]="philosophers",
	["capital"]="capitals ",
	["country"]="countries",
	["world dishes"]="World dishes",
	["adjective"]="adjectives",
	["Choose Category"]="Choose Category",
	["Made Cheeseburgers"]="Made Cheeseburgers： ",
	["Odered Cheeseburgers"]="Made Cheeseburgers：",
	["Made Frenchfries"]="Made Frenchfries： ",
	["Odered Frenchfries"]="Odered Frenchfries：",
	["Cleanlyness"]=" Cleanlyness：",
	["Total Points"]="Total Points：",
	["Difficulty"]="Difficulty",
	["Easy"]="Easy",
	["Medium"]="Medium",
	["Hard"]="Hard",
	["emotions"]="Emotions",
	["weather"]="Weather",
	["body parts"]="Body parts",
	["fruits"]="Fruits",
	["furniture"]="Furniture",
	["professions"]="Professions",
	["family members"]="Family members",
	["school subjects"]="School subjects",
	["colors"]="Colors"
}
i18n["Japanese"]={
	["Choose Game Mode"]="ゲームモード選択",
	["Play"]="遊ぶ",
	["Study"]="勉強",
	["Language"]="日本語",
	["Start"]="スタート!",
	["Nokori"]="残り",
	["Punkan"]="分間",
	["verb"]="動詞",
	["animal"]="動物",
	["vehicle"]="乗り物",
	["philosopher"]="哲学者",
	["capital"]="首都",
	["country"]="国",
	["world dishes"]="料理",
	["adjective"]="形容詞",
	["Choose Category"]="カテゴリーを選択",
	["Made Cheeseburgers"]="作ったチーズバーガー： ",
	["Odered Cheeseburgers"]="チーズバーガーオーダー：",
	["Made Frenchfries"]="作ったポテトフライ： ",
	["Odered Frenchfries"]="ポテトフライオーダー：",
	["Cleanlyness"]=" 清潔感：",
	["Total Points"]="トータルポイント：",
	["Difficulty"]="難易度（なんいど）",
	["Easy"]="かんたん",
	["Medium"]="ふつう",
	["Hard"]="むずかしい",
	["emotions"]="感情表現",
	["weather"]="天候",
	["body parts"]="体",
	["fruits"]="フルーツ",
	["furniture"]="家具",
	["professions"]="職業",
	["family members"]="家族",
	["school subjects"]="学校の科目",
	["colors"]="色"
}
i18n["Spanish"]={
	["Choose Game Mode"]="Escojer modo del Juego",
	["Play"]="Jugar",
	["Study"]="Estudiar",
	["Language"]="Español",
	["Start"]="Comenzar!",
	["Nokori"]="Quedan ",
	["Punkan"]=" minutos",
	["verb"]="Verbos",
	["animal"]="Animales",
	["vehicle"]="Modos de transporte",
	["philosopher"]="Filosofos",
	["capital"]="Capitales",
	["country"]="Paises",
	["world dishes"]="Platillos internacionales",
	["adjective"]="Adjetivos",
	["Choose Category"]="Escojer Categoria",
	["Made Cheeseburgers"]="Hamburquesas-queso hechas： ",
	["Odered Cheeseburgers"]="Hamburguesas-queso ordenadas：",
	["Made Frenchfries"]="Patatas fritas hechas： ",
	["Odered Frenchfries"]="Patatas fritas ordenadas：",
	["Cleanlyness"]=" Limpieza：",
	["Total Points"]="Puntos en total：",
	["Difficulty"]="Dificultad",
	["Easy"]="Facil",
	["Medium"]="Medio",
	["Hard"]="Dificil",
	["emotions"]="Emociones",
	["weather"]="Clima",
	["body parts"]="Partes del cuerpo",
	["fruits"]="Frutas",
	["furniture"]="Muebles",
	["professions"]="Profeciones",
	["family members"]="Miembros de la familia",
	["school subjects"]="Materias escolares",
	["colors"]="Colores"
}
function i18n_setlang(lang)
	--print(i18n[lang]["Enter command:"])
	return i18n[lang]
end

--translate=i18n_setlang("English")
--print(translate["Hello World"])
--print(translate["Goodbye World"])
--translate=i18n_setlang("Spanish")
--print(translate["Hello World"])
--print(translate["Goodbye World"])
--translate=i18n_setlang("Japanese")
--print(translate["Hello World"])
--print(translate["Goodbye World"])　