# Welcome to Framer

# Learn how to prototype: http://framerjs.com/learn
# Drop an image on the device, or import a design from Sketch or Photoshop
initialSize = 80
# print Screen.size


	

PhotosLayer = new BackgroundLayer
	backgroundColor: "none"
	
photoLayer1 = new Layer
	superLayer: PhotosLayer
	image: "images/1.jpg"
	width: Screen.width - 10
	height: Screen.height - 10
	
photoLayer1.center()

photoLayer2 = new Layer
	superLayer: PhotosLayer
	image: "images/3.jpg"
	width: Screen.width - 10
	height: Screen.height - 10
	
photoLayer2.center()
photoLayer2.y = photoLayer1.y - photoLayer1.height - 25

photoLayer3 = new Layer
	superLayer: PhotosLayer
	image: "images/2.jpg"
	width: Screen.width - 10
	height: Screen.height - 10

photoLayer3.center()
photoLayer3.y = photoLayer2.y - photoLayer1.height - 25

#----------------------------------------------------------

DeleteLayer = new Layer
	width: Screen.width
	height: Screen.height
	backgroundColor: ""
	opacity: 0

DeleteLayer.center()
DeleteLayer.visible = false

deleteBlurLayer = new Layer
	superLayer: DeleteLayer
	width: Screen.width
	height: Screen.height
	backgroundColor: "#000"
	opacity: 0.6

DeleteLayer.center()

deleteButton = new Layer
	superLayer: DeleteLayer
	height: 105
	width: 80
	backgroundColor: "none"

deleteIcon = new Layer
	superLayer: deleteButton
	image: "images/trashWatch.png"
	width: 80
	height: 80

deleteText = new Layer
	superLayer: deleteButton
	html: "Delete"
	height: 20
	width: 80
	backgroundColor: "none"
	style:
		"font-style": "Helvetica Neue"
		"font-weight": 100
		"font-size": "16px"
		"text-align": "center"
	y: 85
	
deleteButton.center()


#----------------------------------------------------------

ConfirmLayer = new Layer
	width: Screen.width
	height: Screen.height
	backgroundColor: "none"
	opacity: 0
	visible: false
	
textLayer = new Layer
	superLayer: ConfirmLayer
	html: "Are you sure you want to delete this?"
	width: 312
	y: 40
	backgroundColor: "none"
	style:
		"font-style":"Helvetica Neue"
		"font-weight": "100"
		"padding": "10px 15px 0 25px"
		"text-align": "center"

bgLayer = new Layer
	superLayer: ConfirmLayer
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
	
# optLayer = new Layer
# 	superLayer: ConfirmLayer
# 	width: initialSize, 
# 	height: initialSize, 
# 	backgroundColor: "#fff",
# 	style:
# 		"text-align": "center"
# 		"font-family": "Helvetica",
# 		"font-weight": "100",
# 		"font-size": "25px",
# 		"line-height": initialSize + "px"
# 		"border-radius": "60px",
# 		"color": "#2DD7AA"
# 		
# optLayer.center()

optLayer = new Layer
	superLayer: ConfirmLayer
	width: initialSize, 
	height: initialSize, 
	backgroundColor: "#fff",
	style:
		"border-radius": "60px",
		
optLayer.center()

optLayer.x = 25
bgLayer.x = 25

optLayer.draggable.enabled = true

originY = optLayer.y
constY = (Screen.height/2) + (Screen.height/4)
slingShotLimit = (Screen.height/2) + (Screen.height/5)

optLayer.draggable.horizontal = false
optLayer.draggable.constraints = {y:optLayer.y, height:constY}
optLayer.draggable.overdrag = false
optLayer.draggable.momentum = false
optLayer.draggable.speedY = 0.6


yesTextLayer = new Layer
	superLayer: optLayer
	width: optLayer.width, 
	height: 25, 
	backgroundColor: "",
	html: "Yes",
	style:
		"text-align": "center"
		"font-family": "Helvetica",
		"font-weight": "100",
		"font-size": "25px",
		"color": "#2DD7AA"
		
yesTextLayer.center()

greenArrow = new Layer
	superLayer: optLayer
	width: 15
	height: 15
	y: 60
	image: "images/arrow-01.png"

greenArrow.centerX()

#-----------------NO--------------------------

noBgLayer = new Layer
	superLayer: ConfirmLayer
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
	
# noOptLayer = new Layer 
# 	superLayer: ConfirmLayer
# 	width: initialSize, 
# 	height: initialSize, 
# 	backgroundColor: "#fff",
# 	html: "No",
# 	style:
# 		"text-align": "center"
# 		"font-family": "Helvetica",
# 		"font-weight": "100",
# 		"font-size": "25px",
# 		"line-height": initialSize + "px"
# 		"border-radius": "60px",
# 		"color": "#ec5659"

noOptLayer = new Layer 
	superLayer: ConfirmLayer
	width: initialSize, 
	height: initialSize, 
	backgroundColor: "#fff",
	style:
		"border-radius": "60px",

noOptLayer.center()

noOptLayer.x = Screen.width - 105
noBgLayer.x = Screen.width - 105

noOptLayer.draggable.enabled = true

noOptLayer.draggable.horizontal = false
noOptLayer.draggable.constraints = {y:noOptLayer.y, height:constY}
noOptLayer.draggable.overdrag = false
noOptLayer.draggable.momentum = false
noOptLayer.draggable.speedY = 0.6


noTextLayer = new Layer
	superLayer: noOptLayer
	width: noOptLayer.width, 
	height: 25, 
	backgroundColor: "",
	html: "No",
	style:
		"text-align": "center"
		"font-family": "Helvetica",
		"font-weight": "100",
		"font-size": "25px",
		"color": "#ec5659"
		
noTextLayer.center()

redArrow = new Layer
	superLayer: noOptLayer
	width: 15
	height: 15
	y: 60
	image: "images/arrow-02.png"

redArrow.centerX()


#---------------------------------------------


clockLayer = new Layer
	height: 32
	width: Screen.width
	backgroundColor: ""
	opacity: 0.9
	html: "10:09"
	style: 
		"font-size": "22px"
		"font-style": "Helvetica Neue"
		"text-align": "right"
		"color": "#aaa"
		"padding": "5px 10px"
		
#----------------------------------------------

photoToDelete = {}

fnResetOptions = () ->
	DeleteLayer.visible = false
	deleteButton.center()
	ConfirmLayer.y = 0
	ConfirmLayer.x = 0
	ConfirmLayer.blur = 0
	ConfirmLayer.opacity = 0
	ConfirmLayer.visible = true
	noOptLayer.y = originY
	optLayer.y = originY
	

fnPhotoClicked = (lyr) ->
	DeleteLayer.visible =  true
	PhotosLayer.blur = 10
	animationShowDelete.start()
	photoToDelete = lyr


fnMoving = (lyr, bgLyr) ->
	newSize = Utils.modulate(lyr.y,   [originY, slingShotLimit], [1, (Screen.height*1.3)/initialSize])
	bgLyr.scale = newSize

fnStopAnimation = (lyr) ->
 	if lyr.y <= -100
 		ConfirmLayer.animate
 			properties: 
 				y: Screen.height * 2
 				blur: 50
 		DeleteLayer.visible = false
 
fnUpdatePhotoView = (opt) ->
	PhotosLayer.animate({
		properties:
			blur: 0
		curve: "ease-out"
	})
	if opt
		photoToDelete.animate({
			properties:
				scale: 0
				blur: 15
			curve: "spring(200,15,0)"
			time: 0.5
		})
		Utils.delay 0.5, ->
			for photo in PhotosLayer.subLayers
				photo.animate({
					properties:
						y: photo.y + photoLayer3.height + 25
					curve: "spring(200,15,0)"
					time: 0.5
				})
				photoToDelete.destroy()
			


animationShowDelete = new Animation({
	layer: DeleteLayer,
	properties:
		opacity: 1
	curve: "ease-in",
	time: 0.2
})

animationHideDelete = new Animation({
	layer: DeleteLayer,
	properties:
		opacity: 0
	curve: "ease-out",
	time: 0.2
})

animationHideDeleteButton = new Animation({
	layer: deleteButton,
	properties: 
		y: -200
	curve: "ease-out"
	time: 0.2
})

animationShowConfirm = new Animation({
	layer: ConfirmLayer,
	properties:
		opacity: 1
	curve: "ease-in",
	time: 0.2
})


animationGoAway = new Animation({
	layer: optLayer,
	properties: 
		y: -200
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
		y: -200
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




for photo in PhotosLayer.subLayers
	photo.on Events.Click, ->
		if !DeleteLayer.visible
			fnResetOptions()
			fnPhotoClicked(this)

deleteIcon.on Events.TouchStart, ->
	deleteIcon.animate({
		properties:
			scale: 0.8
		time: 0.3
	})
	
deleteIcon.on Events.MouseOut, ->
	if deleteIcon.scale < 1
		deleteIcon.animate({
			properties:
				scale: 1
			time: 0.3
		})
	
deleteIcon.on Events.TouchEnd, ->
	deleteIcon.scale = 1
	animationHideDeleteButton.start()
	ConfirmLayer.visible = true
	animationShowConfirm.start()
	console.log DeleteLayer
	
	

optLayer.on Events.DragEnd, ->
	if optLayer.y <=  slingShotLimit
		animationReturn.start()
		animationOriginalSize.start()
	else
		animationGoAway.start()
		animationOriginalSize.start()
		animationHideDelete.start()
		fnUpdatePhotoView(true)
		
		
		
noOptLayer.on Events.DragEnd, ->
	if noOptLayer.y <=  slingShotLimit
		noAnimationReturn.start()
		noAnimationOriginalSize.start()
	else
		noAnimationGoAway.start()
		noAnimationOriginalSize.start()
		animationHideDelete.start()
		fnUpdatePhotoView(false)


optLayer.on Events.DragMove, ->
	fnMoving(optLayer, bgLayer)
	noBgLayer.scale = 1


noOptLayer.on Events.DragMove, ->
	fnMoving(noOptLayer, noBgLayer)
	bgLayer.scale = 1

optLayer.on Events.AnimationStop, ->
	fnStopAnimation(optLayer)

noOptLayer.on Events.AnimationStop, ->
	fnStopAnimation(noOptLayer)
	
#-----Making sure the bg layers cover the other buttons when scaling 
	
optLayer.on Events.TouchStart, ->
	bgLayer.placeBefore(noOptLayer)
	optLayer.bringToFront()
	
noOptLayer.on Events.TouchStart, ->
	noBgLayer.placeBefore(optLayer)
	noOptLayer.bringToFront()
