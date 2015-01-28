#Prototype to simulate the Spotify's new Touch Preview Discovery interaction
#Julián Camacho | @jugerardo
#27/01/2015

backLayer = new BackgroundLayer({backgroundColor: "black"})

middleLayer = new BackgroundLayer({image: "images/c.jpg",backgroundColor: "black",superLayer: backLayer, blur: 20, brightness: 50})



#First Selection screen of the app
screen1 = new Layer({image: "images/c.jpg",superLayer: backLayer, width: backLayer.width, height: backLayer.height})



#Grid Screen of the app
screen2 = new BackgroundLayer({backgroundColor: "none", superLayer: backLayer})

selectAnimationGenerator = (newX, newY) ->
	newX = (backLayer.midX  - newX) * 1.8
	newY = (backLayer.midY  - newY) * 1.8
	new Animation({
		layer: screen1,
		properties: {x: newX, y: newY, scale: 1.8, blur: 20, brightness: 50},		time: .2,
		curve: "ease-in-out",
	})

#Animation to restore Initial Screen
goToNormalAnimation = new Animation({
	layer: screen1,
	properties: {x: 0, y: 0, scale: 1, blur: 0, brightness: 100},	time: .2,
	curve: "spring(400,28,0)"
})

#Funtion to control steps when selecting a list
selectList = (layerSelected) ->
	layerSelected.states.switch "second"
	Utils.delay 0.5, ->
		showHideSongs(true)
		screen1.placeBehind(screen2)
		middleLayer.placeBehind(screen1)
		selectAnimationGenerator(layerSelected.midX, layerSelected.midY).start()
		contLayer["pressed"] = true
		layerSelected.states.switchInstant "default"

#Selectable list No1
clickElement = new Layer
	superLayer: screen1
	height: 440
	width: 330
	x: 28
	y: 278
	backgroundColor: "#222"
	opacity: 0

clickElement.states.add
	second: {opacity: .6}

clickElement.states.animationOptions =
	curve: "ease-in-out"
	time: 0.2
	
#Selectable list No2
clickElement2 = new Layer
	superLayer: screen1
	height: 440
	width: 330
	x: 372
	y: 278
	backgroundColor: "#222"
	opacity: 0

clickElement2.states.add
	second: {opacity: .6}

clickElement2.states.animationOptions =
	curve: "ease-in-out"
	time: 0.2

#Function to restore the prototype on TouchEnd
hideDiscoverMode = ->
	showHideSongs(false)
	Utils.delay 0.3, ->
		screen1.bringToFront()
		goToNormalAnimation.start()
		contLayer["pressed"] = false

clickElement.on Events.TouchStart, ->
	selectList clickElement
	
clickElement2.on Events.TouchStart, ->
	selectList clickElement2

#Songs Info for the Grid
songs = [
		name: "Taxi Cab"
		artist: "Vampire Weekend"
		image: "album1.jpg"
	,
		name: "Norgaard"
		artist: "The Vaccines"
		image: "album2.jpg"
	,
		name: "Weirdo"
		artist: "The Vaccines"
		image: "album3.jpg"
	,
		name: "Video Games"
		artist: "Lana Del Rey"
		image: "album4.jpg"
	,
		name: "Terrible Love"
		artist: "Birdy"
		image: "album5.jpg"
	,
		name: "How Long"
		artist: "The View"
		image: "album6.jpg"
	,
		name: "Lust For Life"
		artist: "Iggy Pop"
		image: "album7.jpg"
	,
		name: "Hiding Tonight"
		artist: "Alex Turner"
		image: "album8.jpg"
	,
		name: "Heroin"
		artist: "The Velvet Underground"
		image: "album9.jpg"
	,
		name: "London Calling",
		artist: "The Clash"
		image: "album10.jpg"
	,
		name: "Don't Be Shy"
		artist: "The Libertines"
		image: "album11.jpg"
	,
		name: "Tírate"
		artist: "Café Tacvba"
		image: "album12.jpg"
]

#Albums grid properties
rows = 4
cols = 3
gutter = 11

#Albums Grid Container Layer
contLayer = new Layer
	superLayer: screen2
	width: backLayer.width - gutter * 2
	height: backLayer.width
	backgroundColor: "none"
	
contLayer.center()

#Layers for song and artist text
songTitleContainer = new Layer
	superLayer: screen2
	width: backLayer.width
	height: 60
	y: contLayer.y - 70
	backgroundColor: "none"
	
songTitleContainer.html = ""
songTitleContainer.style = 
		"color": "#AAA"
		"fontSize": "1.1em"
		"text-align": "center"
		"font-family": "Helvetica"
		"font-weight": "500"
	
listTitleContainer = new Layer
	superLayer: screen2
	width: screen2.width
	y: songTitleContainer.y - 100
	backgroundColor: "none"
		
listTitleContainer.html = "Cool Songs"
listTitleContainer.style = 
		"color": "#EEEEEE"
		"fontSize": "1.2em"
		"text-align": "center"
		"padding-top": "60px"
		"font-family": "Helvetica"
		"font-weight": "500"


albumWidth  = (contLayer.width - gutter * 4)/cols
albumHeight = albumWidth #(contLayer.height - gutter * 4)/rows
	
container = []
rowCont = []

contLayer.height = albumWidth * rows + gutter * rows + gutter

imgCont = 0

ani1 = {curve: "ease-in-out", 	time: 0.2}
 	
ani2 = {time: 0.2, 	curve: "spring(300,18,0)"}

for rowIndex in [0..rows-1]
	rowCont = []
	for colIndex in [0..cols-1]
		imgCont++
		cellLayer = new Layer
			superLayer: contLayer
			width:  albumWidth
			height: albumHeight
			x: colIndex * (albumWidth + gutter) + gutter
			y: rowIndex * (albumHeight + gutter) + gutter
			image: "images/#{songs[imgCont-1].image}" 
			brightness: 50
			
		cellLayer.imageCont = imgCont - 1
		
		Utils.labelLayer cellLayer, "#{rowIndex}:#{colIndex}"
		
		cellLayer.states.add
			first: {scale:0},
			second: {scale:1.1, brightness:100, shadowX: 0, shadowY: 1, shadowBlur: 7, shadowColor: "rgba(0,0,0,0.9)"}
			
		cellLayer.states.on Events.StateWillSwitch, (oldState, newState) ->
		  	if (newState is 'default' and oldState is 'second') 
		    	this.layer.states.animationOptions = ani1;
		  	else 
		    	this.layer.states.animationOptions = ani2;
			
		# Set the default animation options
# 		cellLayer.states.animationOptions =
# 			#curve: "spring(500,12,0)"
# 			curve:"ease-in-out"
# 			time: 0.2
		
		#Function to execute when selecting an album
		selectAlbum = (album) ->
			songTitleContainer.html = "#{songs[album.imageCont].name} • #{songs[album.imageCont].artist}"
			album.states.switch "second" 
			album.bringToFront()
			
		cellLayer.on Events.TouchStart, ->
			selectAlbum(this)
		
		cellLayer.on Events.MouseOver, ->
			if contLayer.pressed
				selectAlbum(this)
			
		cellLayer.on Events.TouchEnd, Events.MouseOut, ->
			this.states.switch "default"
			songTitleContainer.html = ""
		
		cellLayer.states.switchInstant "first"	
		rowCont.push cellLayer
		
	container.push rowCont


contLayer.on Events.TouchEnd, ->
	hideDiscoverMode()
	
backLayer.on Events.TouchEnd, ->
	hideDiscoverMode()


#Adds delay and defines state to change when showing the grid
showSongAnimationGenerator = (currentLayer, timeNumber, mult, changeState) ->
	timeToWait = (1 / (rows * cols)) * (timeNumber + mult)
	Utils.delay timeToWait, ->
		if changeState
			currentLayer.states.switch "default"
		else
			currentLayer.states.switch "first"

#Assigns the animation when the grid appears
showHideSongs = (changeState)->
	colCurrent = 0
	rowCurrent = 0
	while colCurrent < cols and rowCurrent < rows
		for rowIndex in [rowCurrent..rows-1]
			showSongAnimationGenerator(container[rowIndex][colCurrent], rowIndex, rowCurrent, changeState)
		
		for colIndex in [colCurrent..cols-1]
			showSongAnimationGenerator(container[rowCurrent][colIndex], colIndex, colCurrent, changeState)
		
		colCurrent++
		rowCurrent++
		

  	  

			