(
	global changeVertexColorsRollout
	try ( destroyDialog changeVertexColorsRollout ) catch()	
	rollout changeVertexColorsRollout "changer Vertex Colors" width:448 height:64
	(
		button 'btApplyWhiteVertexColor' "CHANGER LES VERTEX COLORS EN BLANC" pos:[8,32] width:432 height:24 align:#left
		label 'lbSelectedObject' "Label" pos:[8,8] width:432 height:16 align:#left

		local selectedNodes = undefined
		
		function changeVertexColors = (
			if (selectedNodes == undefined or selectedNodes.count <= 0) do (
				format "Aucun vertex color changé, sélection vide...\n"
				return undefined
			)
			
			format "Changement des vertex colors de % objet(s)\n" selection.count
			newVertColor = point3 (255) (255) (255)
			
			-- map channels => 0 : color / -1 : illum / -2 : alpha
			for obj in (selection as array) do
			(
				try (
					if iskindof obj Editable_poly or iskindof obj PolyMeshObject then (
						-- polyop.setVertColor <Poly poly> <int mapChannel> <vertlist> <Color color>
						polyop.setVertColor obj 0 (obj.verts as Bitarray) newVertColor
						polyOp.setVertColor obj -1 (obj.verts as Bitarray) newVertColor
						polyOp.setVertColor obj -2 (obj.verts as Bitarray) newVertColor
					)
					else if iskindof obj Editable_mesh do (
						-- meshop.setVertColor <Mesh mesh> <int mapChannel> <vertlist> <Color color>
						meshop.setVertColor obj 0 (obj.verts as Bitarray) newVertColor
						meshop.setVertColor obj -1 (obj.verts as Bitarray) newVertColor
						meshop.setVertColor obj -2 (obj.verts as Bitarray) newVertColor
					)
				) catch (
					print ("Erreur sur l'objet suivant : " + obj.name)
					print (getCurrentException())
				)
			)
		)
		
		function selectionChanged = (
			selectedNodes = selection as array
			if selectedNodes == undefined then (
				lbSelectedObject.caption = "Objet(s) sélectionné(s) : Aucun"
				return undefined
			)
			lbSelectedObject.caption = "Objet(s) sélectionné(s) : " + selectedNodes.count as string
		)
		function regCallbacks = (
			callbacks.addScript #selectionSetChanged "try(changeVertexColorsRollout.selectionChanged()) catch(messageBox (getCurrentException()))" id:#changeVertexColorsRollout
		)
		function unregCallbacks = (
			callbacks.removeScripts id:#changeVertexColorsRollout
		)
		on changeVertexColorsRollout open do (
			unregCallbacks()
			regCallbacks()
			selectionChanged()
		)
		on changeVertexColorsRollout close do
			unregCallbacks()
		on btApplyWhiteVertexColor pressed do
			changeVertexColors()
	)
	createDialog changeVertexColorsRollout
)
