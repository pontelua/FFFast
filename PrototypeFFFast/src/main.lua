local function main()
	print "main start"
    local winSize = CCDirector:sharedDirector():getWinSize()
    local tableClothRect	= {width = 130, height = 130}
    local tableObjects	= {
    	{
    		image = "glass.png"
    		, shake	= {1,2,3,4}
    		, brake	= {1,2,3,4}
    		, shakeFrame	= nil
    		, brakeFrame	= nil
    	}
    }  
    
    local spriteTables	= {
    	{x = 169, y = 322, clothKey = 3}
    	,{x = 286, y = 322, clothKey = 2}
    	,{x = 403, y = 322, clothKey = 7}
    	,{x = 520, y = 322, clothKey = 2}
    	,{x = 637, y = 322, clothKey = 0}
    	
    	,{x = 110, y = 209, clothKey = 4}
    	,{x = 220, y = 209, clothKey = 9}
    	,{x = 330, y = 209, clothKey = 8}
    	,{x = 440, y = 209, clothKey = 4}
    	,{x = 550, y = 209, clothKey = 3}
    	,{x = 660, y = 209, clothKey = 6}
    	
    	,{x = 169, y = 96, clothKey = 5}
    	,{x = 286, y = 96, clothKey = 8}
    	,{x = 403, y = 96, clothKey = 4}
    	,{x = 520, y = 96, clothKey = 5}
    	,{x = 637, y = 96, clothKey = 6}
    }

    local spriteTableCloths	= {}
    local spriteObjectOverTables	= {}
    local currentRemainTableClothCount	= 0
    
    local distanceBetweenClothAndObject	= 20
    
    local timeTableClothTouched	= nil
    
    local function createObjectOverTable(key)
    	print "Start createObjectOverTable"
	    local frameWidth	= tableClothRect.width
	    local frameHeight	= tableClothRect.height
		local textureObject	= CCTextureCache:sharedTextureCache():addImage("../Resources/Images/" .. tableObjects[key].image)
--		local textureObject	= CCTextureCache:sharedTextureCache():addImage("../Resources/Images/glass.png")
		local rect = CCRectMake(0, 0, frameWidth, frameHeight)
		local frame0 = CCSpriteFrame:createWithTexture(textureObject, rect)

        local spriteObjectOverTalbe = CCSprite:createWithSpriteFrame(frame0)
        spriteObjectOverTalbe.isPaused = false
    	return spriteObjectOverTalbe
    end
        
    local function createTableCloth(key)
    	print "Start createTableCloth"
	    local frameWidth	= 130
	    local frameHeight	= 130
	    local tableClothKey	= spriteTables[key].clothKey
    	
    -- create table cloths
        local textureDog = CCTextureCache:sharedTextureCache():addImage("../Resources/Images/table_cloth.png")
        local rect = CCRectMake(tableClothKey*frameWidth, 0, frameWidth, frameHeight)
        local frame0 = CCSpriteFrame:createWithTexture(textureDog, rect)

        local spriteTableCloth = CCSprite:createWithSpriteFrame(frame0)
        spriteTableCloth.isPaused = false
    	return spriteTableCloth
    end
    
    
    
    local function createLayerBG()
		print "start createLayerBG"
        local layerBG = CCLayer:create()
		local bg_pt = CCPoint(winSize.width / 2, winSize.height / 2)

        -- add in background
        local bg = CCSprite:create("../Resources/Images/bg.png")
        bg:setPosition(bg_pt.x, bg_pt.y)
		layerBG:addChild(bg)
		for index, value in ipairs(spriteTables) do
		-- creating tables
	        local spriteTable = CCSprite:create("../Resources/Images/table.png")
	        spriteTable.isPaused = false
	        spriteTable:setPosition(value.x, value.y)
			layerBG:addChild(spriteTable)
			currentRemainTableClothCount	= currentRemainTableClothCount + 1
		-- create table-cloths
--	        local spriteTableCloth	= createTableCloth(index)
--	        spriteTableCloth:setPosition(value[1], value[2])
--			layerBG:addChild(spriteTableCloth)
			spriteTableCloths[index]	= createTableCloth(index);
	        spriteTableCloths[index]:setPosition(value.x, value.y)
			layerBG:addChild(spriteTableCloths[index])
			
		-- creating object-over-tables
	        spriteObjectOverTables[index]	= {sprite = createObjectOverTable(1)}
	        spriteObjectOverTables[index].sprite:setPosition(value.x, value.y)	        
			layerBG:addChild(spriteObjectOverTables[index].sprite)
		end
		
		local function boomObjectOverTable(key)
	    	layerBG:removeChild(spriteObjectOverTables[key].sprite, true)
--	    	layerBG:removeChild(tableObjects[key].sprite, true)
--	    
--	    	local animFrames = CCArray:create()
--	    	local rect = CCRectMake(0, 0, tableClothRect.width, tableClothRect.height)
--	        local frame0 = CCSpriteFrame:createWithTexture(spriteObjectOverTable, rect)
--	        rect = CCRectMake(frameWidth, tableClothRect.width, frameWidth, frameHeight)
--	        local frame1 = CCSpriteFrame:createWithTexture(spriteObjectOverTable, rect)
	        
	        print "Boom Object Over Table"
	    end
		
		local function shakeTableObject(key)
--			local tableObjectImage	= 
	        local textureObject = CCTextureCache:sharedTextureCache():addImage(spriteObjectOverTables[key].image)
	        local rect = CCRectMake(0, 0, frameWidth, frameHeight)
	        local frame0 = CCSpriteFrame:createWithTexture(textureObject, rect)

			local animFrames = CCArray:create()

			animFrames:addObject(frame0)

			print "End Shake Table Object"
		end
		
		local touchBeginPoint = nil
    
	    local function onTouchBegan(x, y)
	        touchBeginPoint = {x = x, y = y}
	        timeTableClothTouched	= os.time()
	        print ("onTouchBegan")
	--    	print ("onTouchBegan : " .. touchBeginPoint[1] .. " / ")
	--        spriteDog.isPaused = true
	        -- CCTOUCHBEGAN event must return true
	        return true
	    end
	
	    local function onTouchMoved(x, y)
	        -- cclog("onTouchMoved: %0.2f, %0.2f", x, y)
	        if touchBeginPoint then
	--            local cx, cy = layerFarm:getPosition()
	--            layerFarm:setPosition(cx + x - touchBeginPoint.x,
	--                                  cy + y - touchBeginPoint.y)
	            touchBeginPoint = {x = x, y = y}
	        end
	    end
	
	    local function onTouchEnded(x, y)
	    	print "onTouchEnded"
	    	local timeCurrent	= os.time()
	    	local halfWidth	= tableClothRect.width / 2
	    	local halfHeight	= tableClothRect.height / 2
	    	
			for index, value in ipairs(spriteTables) do
	    		if value.x-halfWidth < x and value.x+halfWidth > x
	    		and value.y-halfHeight < y and value.y+halfHeight > y
	    		then
		    		if timeCurrent - timeTableClothTouched < 1	-- 1��� ������ ������ ���
		    		then
-- ��������� ������������ ��������� ������
						layerBG:removeChild(spriteTableCloths[index], true)
						currentRemainTableClothCount	= currentRemainTableClothCount - 1
--						shakeTableObject(index)
		    			print "Good"
		    		else
-- ������ ������ ������������ ��������� ������
						boomObjectOverTable(index)
		    			print "Bad"
		    		end
	    		end
	    	end
	    	
		    touchBeginPoint = nil
		    timeTableClothTouched	= nil
	--        cclog("onTouchEnded: %0.2f, %0.2f", x, y)
	--        touchBeginPoint = nil
	--        spriteDog.isPaused = false
	    end
		
		
		-- create event handler
        local function onTouch(eventType, x, y)
            if eventType == CCTOUCHBEGAN then
                return onTouchBegan(x, y)
            elseif eventType == CCTOUCHMOVED then
                return onTouchMoved(x, y)
            else
                return onTouchEnded(x, y)
            end
        end


		layerBG:registerScriptTouchHandler(onTouch)
    	layerBG:setTouchEnabled(true)
		
		print "end createLayerBG"
		return layerBG
    end
    

        
    -- run
    print "Start"
        
    local sceneGame = CCScene:create()
    sceneGame:addChild(createLayerBG())
	
    CCDirector:sharedDirector():runWithScene(sceneGame)
    
end
main()
