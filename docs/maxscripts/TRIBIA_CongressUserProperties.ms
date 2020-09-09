(
	macroScript congressObjectPropertiesRollout
	category:"TRIBIA"
	toolTip:"Congress Object Properties"
	buttontext:"CongressProp"
	(
		global congressObjectPropertiesRollout
		try ( destroyDialog congressObjectPropertiesRollout ) catch()	
		rollout congressObjectPropertiesRollout "Congress Object Properties / babylonjs_tag" width:376 height:776
		(
			local typeList = #("", "booth", "booth_camera", "booth_model", "camera", "envmap", "goto_zone", "ground", "lightmap", "product")
			local mediaTypeList = #("", "texture", "video", "pdf") -- TODO
			local key3dList = #("","poster","logo","video","pdf") -- TODO
			
			-- GENERAL
			label 'lbSelectedObject' "Objet sélectionné : " pos:[8,8] width:360 height:24 align:#left
			GroupBox 'grpName' "JSON / babylonjs_tag = " pos:[8,32] width:360 height:120 align:#left
			edittext 'tbData' "" pos:[16,56] width:344 height:88 toolTip:"JSON qui sera enregistré dans la propriété 'babylonjs_tag' de l'objet" align:#left
			button 'btGet' "Recharger" pos:[8,744] width:176 height:24 toolTip:"Recharge la propriété sans la modifier" align:#left
			button 'btSet' "Enregistrer" pos:[192,744] width:176 height:24 toolTip:"Enregistre les modifications dans la propriété" align:#left
			
			-- PARAMETRES
			GroupBox 'grp2' "Paramètres" pos:[8,160] width:360 height:576 align:#left
			label 'lbl2' "type" pos:[16,184] width:80 height:24 align:#left
			dropdownList 'ddType' "" pos:[96,184] width:264 height:21 items:typeList toolTip:"Type de l'objet, sera utilisé pour trier les objets dans le viewer" align:#left

			-- BOOTH
			GroupBox 'grp16' "booth && goto_zone" pos:[16,216] width:344 height:80 align:#left
			label 'lbl15' "UUID" pos:[24,240] width:80 height:24 align:#left
			edittext 'tbId' "" pos:[120,240] width:232 height:24 toolTip:"UUID du booth, ou de la zone vers laquelle aller (uniquement avec les types booth et goto_zone)" align:#left
			label 'lbl25' "boothModel" pos:[24,264] width:80 height:24 align:#left
			edittext 'tbBoothModel' "" pos:[120,264] width:232 height:24 toolTip:"Source : défini le nom de ce modèle\nCible : nom du modèle à copier sur cette cible" align:#left
			
			-- PRODUCT
			GroupBox 'grp17' "product" pos:[16,304] width:344 height:80 align:#left
			label 'lbl26' "media_type" pos:[24,328] width:80 height:24 align:#left
-- 			edittext 'tbMediaType' "" pos:[120,328] width:232 height:24 toolTip:"Type de la donnée du produit (texture, video)" align:#left
			dropdownList 'ddMediaType' "" pos:[120,328] width:232 height:21 toolTip:"Type de la donnée du produit (texture, video)" align:#left items:mediaTypeList
			label 'lbl27' "key_3d" pos:[24,352] width:80 height:24 align:#left
-- 			edittext 'tbKey3d' "" pos:[120,352] width:232 height:24 toolTip:"Identificateur de produit générique pour appliquer des textures ou vidéos depuis la DB (ex: poster1, poster2, logo, video)" align:#left
			dropdownList 'ddKey3d' "" pos:[120,352] width:232 height:21 toolTip:"Identificateur de produit générique pour appliquer des textures ou vidéos depuis la DB (ex: poster1, poster2, logo, video)" align:#left items:key3dList
			
			-- INSTANCES
			GroupBox 'grp19' "instances" pos:[16,528] width:344 height:80 align:#left
			label 'lbl23' "instanceSource" pos:[24,552] width:96 height:24 align:#left
			edittext 'tbInstanceSource' "" pos:[120,552] width:232 height:24 toolTip:"Indique que cet objet est une source d'instance" align:#left
			label 'lbl24' "replaceBy" pos:[24,576] width:80 height:24 align:#left
			edittext 'tbReplaceBy' "" pos:[120,576] width:232 height:24 toolTip:"Nom de la source qui remplacera cet objet" align:#left
			
			-- LIGHTMAP ENVMAP
			GroupBox 'grp18' "lightmap && envmap" pos:[16,392] width:344 height:128 align:#left
			label 'lbl30' "lightmap" pos:[24,416] width:80 height:24 align:#left
			edittext 'tbLightmap' "" pos:[120,416] width:168 height:24 toolTip:"Nom de la lightmap que cet objet fourni ('default')" align:#left
			button 'btDefaultLightmap' "Défaut" pos:[290,416] width:62 height:24 align:#left
			label 'lbl31' "useLightmap" pos:[24,440] width:80 height:24 align:#left
			edittext 'tbUseLightmap' "" pos:[120,440] width:232 height:24 toolTip:"Nom de la lightmap à appliquer à cet objet" align:#left
			label 'lbl32' "envmap" pos:[24,464] width:80 height:24 align:#left
			edittext 'tbEnvmap' "" pos:[120,464] width:168 height:24 toolTip:"WIP Nom de l'envMap que cet objet fourni ('default')" align:#left
			button 'btDefaultEnvmap' "Défaut" pos:[288,464] width:62 height:24 align:#left
			label 'lbl33' "useEnvmap" pos:[24,488] width:80 height:24 align:#left
			edittext 'tbUseEnvmap' "" pos:[120,488] width:232 height:24 toolTip:"WIP Nom de l'envMap à appliquer à cet objet" align:#left
			
			-- MATERIAUX
			GroupBox 'grp20' "matériaux" pos:[16,616] width:344 height:56 align:#left
			label 'lbl34' "material" pos:[24,640] width:80 height:24 align:#left
			edittext 'tbMaterial' "" pos:[120,640] width:232 height:24 toolTip:"Nom du matériau tel que spécifié dans biblio (nom du matériau pas de l'objet support !)" align:#left
			
			
			local pyJSON = python.import #json
			local selectedNode = undefined
			
			function valOrEmpty value = (
				if value == undefined then return ""
				else return value as string
			)
			
			function getNodeData _node = (
				try (rawJSON = getUserProp _node "babylonjs_tag") catch()
				if (rawJSON == undefined OR rawJSON == "") then rawJSON = ""
				else parsedJSON = pyJSON.loads(rawJSON)
				
				tbData.text = rawJSON
				return parsedJSON
			)
			
			function resetRollout = (
				ddType.selection = 1
				
				tbId.text = ""
				tbBoothModel.text = ""
				
				--tbMediaType.text = ""
				ddMediaType.selection = 1
				--tbKey3d.text = ""
				ddKey3d.selection = 1
				
				tbLightmap.text = ""
				tbUseLightmap.text = ""
				tbEnvmap.text = ""
				tbUseEnvmap.text = ""
				
				tbInstanceSource.text = ""
				tbReplaceBy.text = ""
				
				tbMaterial.text = ""
			)
			
			function initRollout parsedJSON = (
				if (parsedJSON == undefined) then return undefined

				type = parsedJSON["type"]
				typeId = findItem ddType.items type
				ddType.selection = typeId
				
				tbId.text = valOrEmpty parsedJSON["id"]
				tbBoothModel.text = valOrEmpty parsedJSON["boothModel"]
				
				--tbMediaType.text = valOrEmpty parsedJSON["media_type"]
				mediaType = parsedJSON["media_type"]
				mediaTypeId = findItem ddMediaType.items mediaType
				ddMediaType.selection = mediaTypeId
				--tbKey3d.text = valOrEmpty parsedJSON["key_3d"]
				key3d = parsedJSON["key_3d"]
				key3dId = findItem ddKey3d.items key3d
				ddKey3d.selection = key3dId
				
				tbLightmap.text = valOrEmpty parsedJSON["lightmap"]
				tbUseLightmap.text = valOrEmpty parsedJSON["useLightmap"]
				tbEnvmap.text = valOrEmpty parsedJSON["envmap"]
				tbUseEnvmap.text = valOrEmpty parsedJSON["useEnvmap"]
				
				tbInstanceSource.text = valOrEmpty parsedJSON["instanceSource"]
				tbReplaceBy.text = valOrEmpty parsedJSON["replaceBy"]
				
				tbMaterial.text = valOrEmpty parsedJSON["material"]
			)
			
			function selectionChanged = (
				selectedNode = selection[1]
				
				if selectedNode == undefined then (
					lbSelectedObject.caption = "Objet sélectionné : Aucun"
					return undefined
				)
					
				lbSelectedObject.caption = "Object sélectionné : " + selectedNode.name
				parsedJSON = getNodeData selectedNode
				
				if (parsedJSON != undefined) then (
					
					initRollout parsedJSON
					
				) else (
					resetRollout()
				)
			)
			
			function generateJSON = (
				res = stringStream ""
				append res "{"
				
				-- type
				if (ddType.selection > 1) do (
					append res ("\"type\":\"" + ddType.items[ddType.selection] + "\"," )
				)
				
				-- id
				if (tbId.text != "") do append res ("\"id\":\"" + tbId.text + "\"," )
				if (tbBoothModel.text != "") do append res ("\"boothModel\":\"" + tbBoothModel.text + "\"," )
				
				-- product
				--if (tbMediaType.text != "") do append res ("\"media_type\":\"" + tbMediaType.text + "\"," )
				if (ddMediaType.selection > 1) do (
					append res ("\"media_type\":\"" + ddMediaType.items[ddMediaType.selection] + "\"," )
				)
				--if (tbKey3d.text != "") do append res ("\"key_3d\":\"" + tbKey3d.text + "\"," )
				if (ddKey3d.selection > 1) do (
					append res ("\"key_3d\":\"" + ddKey3d.items[ddKey3d.selection] + "\"," )
				)
				
				--lightmap & envmap
				if (tbLightmap.text != "") do append res ("\"lightmap\":\"" + tbLightmap.text + "\"," )
				if (tbUseLightmap.text != "") do append res ("\"useLightmap\":\"" + tbUseLightmap.text + "\"," )
				if (tbEnvmap.text != "") do append res ("\"envmap\":\"" + tbEnvmap.text + "\"," )
				if (tbUseEnvmap.text != "") do append res ("\"useEnvmap\":\"" + tbUseEnvmap.text + "\"," )
				
				-- instances
				if (tbInstanceSource.text != "") do append res ("\"instanceSource\":\"" + tbInstanceSource.text + "\"," )
				if (tbReplaceBy.text != "") do append res ("\"replaceBy\":\"" + tbReplaceBy.text + "\"," )
				
				-- material
				if (tbMaterial.text != "") do append res ("\"material\":\"" + tbMaterial.text + "\"," )
				
				
				append res "}"
				
				res = res as string
				-- supprime la dernière virgule
				if res[res.count - 1] == "," do (
					res[res.count - 1] = "}"
					res[res.count] = ""
				)
				
				if res != "{}" then tbData.text = res --json.dumps(dict)
				else tbData.text = ""
				
			)
			
			function saveProperties = (
				if (selectedNode != undefined) do
					setUserProp selectedNode "babylonjs_tag" tbData.text
			)
			
			function regCallbacks = (
				callbacks.addScript #selectionSetChanged "try(congressObjectPropertiesRollout.selectionChanged()) catch(messageBox (getCurrentException()))" id:#congressObjectPropertiesRollout
			)
			
			function unregCallbacks = (
				callbacks.removeScripts id:#congressObjectPropertiesRollout
			)
			
			on congressObjectPropertiesRollout open do
			(
				unregCallbacks()
				regCallbacks()
				selectionChanged()
			)
			on congressObjectPropertiesRollout close do
				unregCallbacks()
			on btGet pressed do
				selectionChanged()
			on btSet pressed do
				saveProperties()
			on ddType selected selId do
				generateJSON()
			on tbId changed value do
				generateJSON()
			on tbBoothModel changed value do
				generateJSON()
-- 			on tbMediaType changed value do
-- 				generateJSON()
			on ddMediaType selected selId do
				generateJSON()
-- 			on tbKey3d changed value do
-- 				generateJSON()
			on ddKey3d selected selId do
				generateJSON()
			on tbInstanceSource changed value do
				generateJSON()
			on tbReplaceBy changed value do
				generateJSON()
			on tbLightmap changed value do
				generateJSON()
			on btDefaultLightmap pressed do
				tbLightmap.text = "default"
			on tbUseLightmap changed value do
				generateJSON()
			on tbEnvmap changed value do
				generateJSON()
			on btDefaultEnvmap pressed do
				tbEnvmap.text = "default"
			on tbUseEnvmap changed value do
				generateJSON()
			on tbMaterial changed value do
				generateJSON()
			on tbBoothType changed value do
				generateJSON()
		)
		createDialog congressObjectPropertiesRollout
	)
)
