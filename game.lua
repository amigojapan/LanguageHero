
local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------




-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen

end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen
        local json = require( "json" )

-- Function to shuffle a table (Fisher-Yates algorithm)
local function shuffleTable(t)
    local rand = math.random
    for i = #t, 2, -1 do
        local j = rand(1, i)
        t[i], t[j] = t[j], t[i]
    end
end

-- Function to get a total number of random words in a specific language, excluding one category
local function getRandomWordsFromJsonInLanguageExcluding(language, jsonData, excludeCategory, totalWordCount)
    local allWords = {}
    
    -- Collect words from all categories except the excluded one
    for _, categoryData in ipairs(jsonData) do
        if categoryData.category ~= excludeCategory then
            for _, word in ipairs(categoryData.words) do
                -- Insert only the word in the specified language
                table.insert(allWords, word[language])
            end
        end
    end

    -- Now that we have all the words, randomly select from them
    local selectedWords = {}
    local wordsToSelect = math.min(totalWordCount, #allWords)

    for i = 1, wordsToSelect do
        local randomIndex = math.random(1, #allWords)
        table.insert(selectedWords, allWords[randomIndex])

        -- Optionally remove the selected word to avoid duplicates
        table.remove(allWords, randomIndex)
    end

    return selectedWords
end

-- Function to get the first n Japanese words from a specific category
local function getWords(language,table1,categoryName, wordCount)
    local Words = {}
    
    for _, category in ipairs(table1) do
        if category.category == categoryName then
            for i, word in ipairs(category.words) do
                if language == "English" then
                    table.insert(Words, word.English)
                elseif language == "Japanese" then
                    table.insert(Words, word.Japanese)
                elseif language == "Romaji" then
                    table.insert(Words, word.Romaji)
                elseif language == "Spanish" then
                    table.insert(Words, word.Spanish)
                end
                --Words.correct=true
            end
        end
    end

    shuffleTable(Words)

    local WordsCounted = {}
    
    for i = 1, wordCount do
        table.insert(WordsCounted, Words[i])
    end
    
    return WordsCounted
end

-- Function to get random Japanese words from non-verb categories
local function getRandomWords(language,table1,excludeCategory, wordCount)
    local allWords = {}
    
    -- Collect words from all categories except the excluded one (e.g., "verb")
    for _, category in ipairs(table1) do
        if category.category ~= excludeCategory then
            for _, word in ipairs(category.words) do
                if language == "English" then
                    table.insert(allWords, word.English)
                elseif language == "Japanese" then
                    table.insert(allWords, word.Japanese)
                elseif language == "Japanese" then
                    table.insert(allWords, word.Spanish)
                end
                --allWords.correct=false
            end
        end
    end
    
    -- Get the first 'wordCount' random words
    local randomWords = {}
    for i = 1, wordCount do
        table.insert(randomWords, allWords[i])
    end
    
    return randomWords
end

 -- Print contents of `tbl`, with indentation.
-- `indent` sets the initial level of indentation.
function tprint (tbl, indent)
    if not indent then indent = 0 end
    for k, v in pairs(tbl) do
      formatting = string.rep("  ", indent) .. k .. ": "
      if type(v) == "table" then
        print(formatting)
        tprint(v, indent+1)
      elseif type(v) == 'boolean' then
        print(formatting .. tostring(v))      
      else
        print(formatting .. v)
      end
    end
  end
  
local function concatenateTables(t1, t2)
    local result = {}

    -- Add all elements from the first table
    for i = 1, #t1 do
        table.insert(result, t1[i])
    end

    -- Add all elements from the second table
    for i = 1, #t2 do
        table.insert(result, t2[i])
    end

    return result
end

-- Path for the file to read
local path = system.pathForFile("words1.json", system.ResourceDirectory) -- Get the path to the file
--local path = "words1.json"--system.pathForFile( filename, loc )
 
-- Open the file handle
local file, errorString = io.open( path, "r" )
pointCount=0
function functTapListener(event)
    --event.target.isVisible=false
    --flip between languages
    if studyMode then
        --flip languages
        if event.target.clicked==true then
            print("event.target.text:"..event.target.text)
            print("event.target.nativeLanguage:"..event.target.nativeLanguage)
            print("event.target.foreingAnswer:"..event.target.foreingAnswer)
            if event.target.text==event.target.nativeLanguage then
                event.target.text=event.target.foreingAnswer
            else
                event.target.text=event.target.nativeLanguage
            end
            return
        end
    end
    event.target.clicked=true
    
    local wordFound=false
    local answer=event.target.text
    
    event.target.foreingAnswer=event.target.text
    print("event.target.foreingAnswer when set:"..event.target.foreingAnswer)
    
    local word="empty"
    for key, word in ipairs(words) do
        if answer == word then
            wordFound=true
            break
        end
    end
    if wordFound then
        if studyMode then
            local targetword
            for i, word in ipairs(wordsFullStudyLangauge) do
                if word==event.target.text then
                    targetword=wordsFullTargetLangauge[i]
                    break
                end
            end
            event.target.text=targetword
            event.target.nativeLanguage=event.target.text
            print("event.target.nativeLanguage when set:"..event.target.nativeLanguage)    
            event.target:setFillColor(0,1,0)
            event.target.correctAnswer=true
        else
            event.target.text="✔"
        end
        event.target.right=true
        pointCount=pointCount+1
        if pointCount == 8 then
            hideEverything()
            composer.gotoScene( "chooseCategories" )
        end
    elseif event.target.text=="✔" then
        event.target.correctAnswer=true
        return
    else
        local targetword
        for i, word in ipairs(wordsFullStudyLangauge) do
            if word==event.target.text then
                targetword=wordsFullTargetLangauge[i]
                break
            end
        end
        event.target.text=targetword
        event.target.nativeLanguage=event.target.text
        print("event.target.nativeLanguage when set:"..event.target.nativeLanguage)    
        event.target:setFillColor(1,0,0)
        event.target.right=false
        event.target.correctAnswer=false
    end
end
words={}
wordsFullStudyLangauge={}
wordsFullTargetLangauge={}
local function getAllWordsInLanguage(parsedData, language)
    local wordsInLanguage = {}

    -- Iterate through each category in the parsed data
    for _, categoryData in ipairs(parsedData) do
        -- Iterate through each word in the category
        for _, wordData in ipairs(categoryData.words) do
            -- Extract the word in the specified language
            table.insert(wordsInLanguage, wordData[language])
        end
    end

    return wordsInLanguage
end
local timerEverySecond=nil
function everySecondTimer()
    if timerEverySecond then
        timeRemaining=timeRemaining-1
        lblTimeRemaining.text="Time remaining:"..timeRemaining.."" 
        if timeRemaining<=0 then
            hideEverything()
            timer.cancel(timerEverySecond)
            composer.gotoScene( "chooseCategories" )
        end
    end
end
gameMode=composer.getVariable( "gameMode" )
if gameMode== "Study" then
    studyMode=true
else
    studyMode=false    
end

if studyMode == false then
    timeRemaining=40
    lblTimeRemaining = display.newText("Time remaining:"..timeRemaining.."", 500, 20, "fonts/ume-tgc5.ttf", 40 )
    lblTimeRemaining:setFillColor( 0, 1, 0 )
    timerEverySecond=timer.performWithDelay( 1000, everySecondTimer, 0 )
end

background = display.newGroup()
wordTable={}
function hideEverything()
    background.isVisible=false
    for key, value in ipairs(wordTable) do
        value.isVisible=false
    end
    if lblTimeRemaining then
        lblTimeRemaining.isVisible=false 
    end
end
if not file then
    -- Error occurred; output the cause
    print( "File error: " .. errorString )
else
    -- Read data from file
    local contents = file:read( "*a" )
    -- Decode JSON data into Lua table
    local data = json.decode( contents )
    -- Close the file handle
    io.close( file )
    -- Dump table
    print("dumping json:")
    --print(t[1][1])

    category = composer.getVariable( "category" )
    print("category:"..category)
    studyLanguage = composer.getVariable( "studyLanguage" )
    print("studyLanguage:"..studyLanguage)
    targetLanguage = composer.getVariable( "language" )
    print("targetLanguage:"..targetLanguage)
    words = getWords(studyLanguage,data,category, 8)
    --words = getWords("Romaji",data,"animal", 8)
    wordsFullStudyLangauge=getAllWordsInLanguage(data,studyLanguage)
    wordsFullTargetLangauge=getAllWordsInLanguage(data,targetLanguage)

    --local randomWords = getRandomWords("English",data,"verb", 20)
 
    local randomWords = getRandomWordsFromJsonInLanguageExcluding(studyLanguage, data, category, 20)
    -- Print the words
    print("target words")
    for i, word in ipairs(words) do
        print(i .. ": " .. word)
    end

    print("random words exluding category")
    for i, word in ipairs(randomWords) do
        print(i .. ": " .. word)
    end
    print("end\nrandom words:\n")
    concatenatedTable = concatenateTables(words, randomWords)

    shuffleTable(concatenatedTable)

    for i, word in ipairs(concatenatedTable) do
        print(i .. ": " .. word)
    end
    rowHeight=100
    rowWidth=270
    --draw tiled backgouod

    local cells = {}
    for x = 0.4, 	4 do
        for y = 1, 7 do
            local myRectangle = display.newRect(background, x*rowWidth, y*rowHeight+5, rowWidth, rowHeight )
            myRectangle.strokeWidth = 10
            myRectangle:setFillColor( 0, 0 , 1 )
            myRectangle:setStrokeColor( 0, 1, 0 )
            table.insert(cells,myRectangle)
        end
    end

    local words = display.newGroup()        
    for i = 1, #cells do
        local w = concatenatedTable[i]
        if w then 
            --print(w)
            if string.len(w) > 9 or system.getInfo( "environment" ) == "browser" then
                word = display.newText(words, w, cells[i].x, cells[i].y+5, "fonts/ume-tgc5.ttf", 40 )    
            else
                word = display.newText(words, w, cells[i].x, cells[i].y+5, "fonts/ume-tgc5.ttf", 60 )
		    end
            word:setFillColor( 1, 1, 0 )
		    word:addEventListener( "tap", functTapListener )
            table.insert(wordTable,word)
        end
    end
end
	end
end


-- hide()
function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is on screen (but is about to go off screen)

	elseif ( phase == "did" ) then
		-- Code here runs immediately after the scene goes entirely off screen

	end
end


-- destroy()
function scene:destroy( event )

	local sceneGroup = self.view
	-- Code here runs prior to the removal of scene's view

end


-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------

return scene

--DunceCotus> amigojapan, you could also enlarge the click 
--  hitbox to be the whole box
--amigojapan> DunceCotus: I guess in the time I have left I will try adding the extra categories that chatgpt suggested, that I told you the other day
--  2:41 PM <amigojapan> hmm I doubt I can finish that in 1 hour tho,
--  maybe it is better left for tomorrow
--DunceCotus: I managed to squeeze out examples for all hte 
--  categories that ChatGPT gave. tomorrow I will integrate it 
--  into the games dictionary, and I will need to make a way of 
--  browsing thru many categories

--make the character move in hte paczel game
--(kind of done, well, I replaced foods with world dishes)figuure out a way for things that belong to more than one category like fruits or foods to coexist
--(I did not include language names)(kind of done, I asked GPT to give me school subjects that dont include language names(but wont this clash when people actually look for language names? mayeb I shoould not include language names at all))I think(I am sure) languages will clash wish school subjects like spanish