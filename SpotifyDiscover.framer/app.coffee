backLayer = new BackgroundLayer({backgroundColor: "black"})

#First Selection screen of the app
screen1 = new Layer({image: "images/a.jpg",superLayer: backLayer, width: backLayer.width, height: backLayer.height})

#Grid Screen of the app
screen2 = new BackgroundLayer({backgroundColor: "none", superLayer: backLayer})

selectAnimationGenerator = (newX, newY) ->
	newX = (backLayer.midX  - newX) * 1.8
	newY = (backLayer.midY  - newY) * 1.8
	new Animation({
		layer: screen1,
		properties: {x: newX, y: newY, scale: 1.8, blur: 50, brightness: 80},		time: .2,
		curve: "ease-in-out",
	})

goToNormalAnimation = new Animation({
	layer: screen1,
	properties: {x: 0, y: 0, scale: 1, blur: 0, brightness: 100},	time: .2,
	curve: "spring(400,28,0)"
})

selectList = (layerSelected) ->
	layerSelected.states.switch "second"
	Utils.delay 0.5, ->
		screen1.placeBehind(screen2)
# 		screen1.blur = 100
		selectAnimationGenerator(layerSelected.midX, layerSelected.midY).start()
		contLayer["pressed"] = true
		layerSelected.states.switchInstant "default"

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

# Set the default animation options
clickElement.states.animationOptions =
	curve: "ease-in-out"
	time: 0.2
	

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

# Set the default animation options
clickElement2.states.animationOptions =
	curve: "ease-in-out"
	time: 0.2

hideDiscoverMode = ->
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
			second: {scale:1.1, brightness:100, shadowX: 0, shadowY: 1, shadowBlur: 7, shadowColor: "rgba(0,0,0,0.9)"}
			
		# Set the default animation options
		cellLayer.states.animationOptions =
			#curve: "spring(500,12,0)"
			curve:"ease-in-out"
			time: 0.2
		
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
			
		rowCont.push cellLayer
		
	container.push rowCont


contLayer.on Events.TouchEnd, ->
	hideDiscoverMode()
	
backLayer.on Events.TouchEnd, ->
	hideDiscoverMode()

	

