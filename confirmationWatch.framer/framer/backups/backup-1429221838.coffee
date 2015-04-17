# Welcome to Framer

# Learn how to prototype: http://framerjs.com/learn
# Drop an image on the device, or import a design from Sketch or Photoshop
initialSize = 80
print Screen.size

textLayer = new Layer
	html: "Are you sure you want to delete this?"
	width: 312
	backgroundColor: "none"
	style:
		"font-style":"Helvetica Neue"
		"font-weight": "100"
		"margin-top": "10px"
		"padding": "10px 15px"

bgLayer = new Layer
	width: initialSize,
	height: initialSize,
	backgroundColor: "#2DD7AA",
	style:
		"text-align": "center"
		"font-family": "Helvetica",
		"font-weight": "100",
		"font-size": "25px",
		"padding-top": "15px",
		"border-radius": (Screen.height+100) + "px"
bgLayer.center()
bgLayer.originX = 0.5
bgLayer.originY = 0.5
	
optLayer = new Layer 
	width: initialSize, 
	height: initialSize, 
	backgroundColor: "#fff",
	html: "Yes",
	style:
		"text-align": "center"
		"font-family": "Helvetica",
		"font-weight": "100",
		"font-size": "25px",
		"line-height": initialSize + "px"
		"border-radius": "60px",
		"color": "#2DD7AA"
		
optLayer.center()

optLayer.x = 15
bgLayer.x = 15

optLayer.draggable.enabled = true

originY = optLayer.y
constY = (Screen.height/2) + (Screen.height/4)  #+ (optLayer.height*1.2)
slingShotLimit = (Screen.height/2) + (Screen.height/5)

optLayer.draggable.horizontal = false
optLayer.draggable.constraints = {y:optLayer.y, height:constY}
optLayer.draggable.overdrag = false
optLayer.draggable.momentum = false
optLayer.draggable.speedY = 0.6

#-----------------NO--------------------------

noBgLayer = new Layer
	width: initialSize,
	height: initialSize,
	backgroundColor: "#ec5659",
	style:
		"text-align": "center"
		"font-family": "Helvetica",
		"font-weight": "100",
		"font-size": "25px",
		"padding-top": "15px",
		"border-radius": (Screen.height+100) + "px"
noBgLayer.center()
noBgLayer.originX = 0.5
noBgLayer.originY = 0.5
	
noOptLayer = new Layer 
	width: initialSize, 
	height: initialSize, 
	backgroundColor: "#fff",
	html: "No",
	style:
		"text-align": "center"
		"font-family": "Helvetica",
		"font-weight": "100",
		"font-size": "25px",
		"line-height": initialSize + "px"
		"border-radius": "60px",
		"color": "#ec5659"
		
noOptLayer.center()

noOptLayer.x = Screen.width - 95
noBgLayer.x = Screen.width - 95

noOptLayer.draggable.enabled = true

noOptLayer.draggable.horizontal = false
noOptLayer.draggable.constraints = {y:noOptLayer.y, height:constY}
noOptLayer.draggable.overdrag = false
noOptLayer.draggable.momentum = false
noOptLayer.draggable.speedY = 0.6



#---------------------------------------------

fnMoving = (lyr, bgLyr) ->
	newSize = Utils.modulate(lyr.y,   [originY, slingShotLimit], [1, (Screen.height*1.3)/initialSize])
	bgLyr.scale = newSize
	print lyr.y

fnStopAnimation = (lyr) ->
# 	if lyr.y == -100
# 		lyr.y = originY




animationGoAway = new Animation({
	layer: optLayer,
	properties: 
		y: -100
	curve: "ease-in-out"
	time: 0.3
})

animationReturn = new Animation({
	layer: optLayer,
	properties:
		y: originY
	curve: "spring(600,30,0)",
	time: 0.3
})

animationOriginalSize = new Animation({
	layer: bgLayer,
	properties:
		scale: 1
	curve: "ease-in",
	time: 0.3
})


noAnimationGoAway = new Animation({
	layer: noOptLayer,
	properties: 
		y: -100
	curve: "ease-in-out"
	time: 0.3
})

noAnimationReturn = new Animation({
	layer: noOptLayer,
	properties:
		y: originY
	curve: "spring(600,30,0)",
	time: 0.3
})

noAnimationOriginalSize = new Animation({
	layer: noBgLayer,
	properties:
		scale: 1
	curve: "ease-in",
	time: 0.3
})

optLayer.on Events.DragEnd, ->
	if optLayer.y <=  slingShotLimit
		animationReturn.start()
		animationOriginalSize.start()
	else
		animationGoAway.start()
		animationOriginalSize.start()
		
		
noOptLayer.on Events.DragEnd, ->
	if noOptLayer.y <=  slingShotLimit
		noAnimationReturn.start()
		noAnimationOriginalSize.start()
	else
		noAnimationGoAway.start()
		noAnimationOriginalSize.start()


optLayer.on Events.DragMove, ->
	fnMoving(optLayer, bgLayer)
	noBgLayer.scale = 1
# 	newSize = Utils.modulate(optLayer.y,   [originY, slingShotLimit], [1, (Screen.height*1.3)/initialSize])
# 	bgLayer.scale = newSize
# 	print optLayer.y

noOptLayer.on Events.DragMove, ->
	fnMoving(noOptLayer, noBgLayer)
	bgLayer.scale = 1
	
	
			

optLayer.on Events.AnimationStop, ->
	fnStopAnimation(optLayer)
# 	if optLayer.y == -100
# 		optLayer.y = originY

noOptLayer.on Events.AnimationStop, ->
	fnStopAnimation(noOptLayer)
