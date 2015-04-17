# Welcome to Framer

# Learn how to prototype: http://framerjs.com/learn
# Drop an image on the device, or import a design from Sketch or Photoshop
initialSize = 80
print Screen.size
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

optLayer.draggable.enabled = true


originY = optLayer.y
constY = (Screen.height/2) + (Screen.height/4)  #+ (optLayer.height*1.2)
slingShotLimit = (Screen.height/2) + (Screen.height/5)
# optLayer.draggable.directionLockThreshold = {x:0, y:0}
# 
# optLayer.draggable.directionLock = true

optLayer.draggable.horizontal = false
optLayer.draggable.constraints = {y:optLayer.y, height:constY}
optLayer.draggable.overdrag = false
optLayer.draggable.momentum = false
optLayer.draggable.speedY = 0.6


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

optLayer.on Events.DragEnd, ->
	if optLayer.y <=  slingShotLimit
# 		optLayer.animate
# 			properties:
# 				y: originY
# 			curve: "spring(600,30,0)"
		animationReturn.start()
		animationOriginalSize.start()
	else
		animationGoAway.start()


optLayer.on Events.DragMove, ->
	if optLayer.y <=  slingShotLimit
		print "pass"
	newSize = Utils.modulate(optLayer.y,   [originY, slingShotLimit], [1, (Screen.height*1.3)/initialSize])
	bgLayer.scale = newSize
	print optLayer.y
# 	bgLayer.width = newSize
	
	
			

optLayer.on Events.AnimationStop, ->
	if optLayer.y == -100
		optLayer.y = originY

# On a click, go to the next state
optLayer.on Events.Click, ->
	optLayer.states.next()