(
	macroScript congressObjectPropertiesRollout
	category:"TRIBIA"
	toolTip:"Congress Object Properties"
	buttontext:"CongressProp"
	(
		local version = "0.4.8" -- add no_title
		global congressObjectPropertiesRollout
		try ( destroyDialog congressObjectPropertiesRollout ) catch()	
		rollout congressObjectPropertiesRollout ("Congress Object Properties / babylonjs_tag ( " + version + " )") width:376 height:784
		(

			local typeList = #("", "booth", "booth_camera", "booth_model", "camera", "camera_position", "envmap", "goto_position", "goto_zone", "ground", "lab", "lightmap", "product", "product_standalone")
			local labButtonList = #("", "infos","image", "video")
			local key3dList = #("","company_logo","company_totem","company_pdf_1","company_video_1","innovation_1","innovation_2","innovation_3")
			
			-- GENERAL
			label 'lbSelectedObject' "Objet sélectionné : " pos:[8,8] width:360 height:24 align:#left
			GroupBox 'grpName' "JSON / babylonjs_tag = " pos:[8,32] width:360 height:120 align:#left
			edittext 'tbData' "" pos:[16,56] width:344 height:88 toolTip:"JSON qui sera enregistré dans la propriété 'babylonjs_tag' de l'objet" align:#left
			button 'btGet' "Recharger" pos:[8,752] width:176 height:24 toolTip:"Recharge la propriété sans la modifier" align:#left
			button 'btSet' "Enregistrer" pos:[192,752] width:176 height:24 toolTip:"Enregistre les modifications dans la propriété" align:#left
			
			-- PARAMETRES
			GroupBox 'grp2' "Paramètres" pos:[8,160] width:360 height:584 align:#left
			label 'lbl2' "type" pos:[16,184] width:80 height:24 align:#left
			dropdownList 'ddType' "" pos:[96,184] width:264 height:21 items:typeList toolTip:"Type de l'objet, sera utilisé pour trier les objets dans le viewer" align:#left

			-- BOOTH
			GroupBox 'grp16' "booth && goto_zone && goto_position && lab" pos:[16,216] width:344 height:80 align:#left
			label 'lbl15' "UUID" pos:[24,240] width:80 height:24 align:#left
			edittext 'tbId' "" pos:[120,240] width:232 height:24 toolTip:"UUID du booth, ou de la zone vers laquelle aller (uniquement avec les types booth, goto_zone, goto_position et lab)" align:#left
			label 'lbl25' "boothModel" pos:[24,264] width:80 height:24 align:#left
			edittext 'tbBoothModel' "" pos:[120,264] width:232 height:24 toolTip:"Source : défini le nom de ce modèle\nCible : nom du modèle à copier sur cette cible" align:#left
			
			-- PRODUCT
			GroupBox 'grp17' "product" pos:[16,304] width:344 height:40 align:#left
			label 'lbl27' "key_3d" pos:[24,320] width:80 height:21 align:#left
			dotNetControl cbKey3d "System.Windows.Forms.ComboBox" pos:[120,320] width:232 height:21 toolTip:"Identificateur de produit générique pour appliquer des textures ou vidéos depuis la DB (ex: poster1, poster2, logo, video)" align:#left
			
            -- LABS
            GroupBox 'grp177' "labs" pos:[16,348] width:344 height:40 align:#left
            label 'lbl26' "lab_button" pos:[24,362] width:80 height:21 align:#left
			dotNetControl cbLabButton "System.Windows.Forms.ComboBox" pos:[120,362] width:232 height:21 toolTip:"Type de bouton pour les labs (infos, video, image)" align:#left
            
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
			dotNetControl cbUseLightmap "System.Windows.Forms.ComboBox" pos:[120,442] width:232 height:21 toolTip:"Nom de la lightmap à appliquer à cet objet" align:#left
			label 'lbl32' "envmap" pos:[24,464] width:80 height:24 align:#left
			edittext 'tbEnvmap' "" pos:[120,464] width:168 height:24 toolTip:"WIP Nom de l'envMap que cet objet fourni ('default')" align:#left
			button 'btDefaultEnvmap' "Défaut" pos:[288,464] width:62 height:24 align:#left
			label 'lbl33' "useEnvmap" pos:[24,488] width:80 height:24 align:#left
			edittext 'tbUseEnvmap' "" pos:[120,488] width:232 height:24 toolTip:"WIP Nom de l'envMap à appliquer à cet objet" align:#left
			
			-- MATERIAUX
			GroupBox 'grp20' "matériaux" pos:[16,616] width:344 height:56 align:#left
			label 'lbl34' "material" pos:[24,640] width:80 height:24 align:#left
			edittext 'tbMaterial' "" pos:[120,640] width:232 height:24 toolTip:"Nom du matériau tel que spécifié dans biblio (nom du matériau pas de l'objet support !)" align:#left
			
			-- DIVERS
			GroupBox 'grp8' "divers" pos:[16,680] width:344 height:56 align:#left
			checkbox 'chkTooltip' "booth_tooltip" pos:[24,693] width:80 height:18 align:#left toolTip:"Affichera le tooltip du stand lorsqu'on cliquera sur cet objet ou un de ses enfants"
			checkbox 'chkNoTitle' "no_title" pos:[104,693] width:74 height:18 align:#left toolTip:"Ce produit n'aura pas de titre (uniquement innovation)"
            checkbox 'chkDoNotScale' "do_not_scale" pos:[178,693] width:80 height:18 align:#left toolTip:"Cette 'innovation' ne sera pas redimensionnée selon son format de texture"
			checkbox 'chkContact' "booth_contact" pos:[24,711] width:80 height:18 align:#left toolTip:"Affichera le layer de contact au clic sur cet objet et ses enfants"
            
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
			
			function fillComboboxes = (
				-- MEDIATYPE
				for item in labButtonList do cbLabButton.items.add(item)
				
				-- KEY3D
				for item in key3dList do cbKey3d.items.add(item)
				
				-- LIGHTMAP
				-- parse tous les objets a la recherche d'un type lightmap
				for obj in objects do (
					parsedJSON = getNodeData obj
					if (parsedJSON != undefined AND parsedJSON["type"] == "lightmap") then (
						cbUseLightmap.items.add(parsedJSON["lightmap"])
					)
				)
			)
			
			function resetRollout = (
				ddType.selection = 1
				
				tbId.text = ""
				tbBoothModel.text = ""
				
				cbLabButton.text = ""
				cbKey3d.text = ""
				
				tbLightmap.text = ""
				cbUseLightmap.text = ""
				tbEnvmap.text = ""
				tbUseEnvmap.text = ""
				
				tbInstanceSource.text = ""
				tbReplaceBy.text = ""
				
				tbMaterial.text = ""
				
				chkTooltip.checked = false
				chkNoTitle.checked = false
                chkDoNotScale.checked = false
                chkContact.checked = false
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
				if (cbLabButton.text != "") do append res ("\"lab_button\":\"" + cbLabButton.text + "\"," )
				if (cbKey3d.text != "") do append res ("\"key_3d\":\"" + cbKey3d.text + "\"," )
				
				--lightmap & envmap
				if (tbLightmap.text != "") do append res ("\"lightmap\":\"" + tbLightmap.text + "\"," )
				if (cbUseLightmap.text != "") do append res ("\"useLightmap\":\"" + cbUseLightmap.text + "\"," )
				if (tbEnvmap.text != "") do append res ("\"envmap\":\"" + tbEnvmap.text + "\"," )
				if (tbUseEnvmap.text != "") do append res ("\"useEnvmap\":\"" + tbUseEnvmap.text + "\"," )
				
				-- instances
				if (tbInstanceSource.text != "") do append res ("\"instanceSource\":\"" + tbInstanceSource.text + "\"," )
				if (tbReplaceBy.text != "") do append res ("\"replaceBy\":\"" + tbReplaceBy.text + "\"," )
				
				-- material
				if (tbMaterial.text != "") do append res ("\"material\":\"" + tbMaterial.text + "\"," )
				
				-- divers
				if (chkTooltip.checked) do append res ("\"booth_tooltip\":true," ) -- si false on ne marque rien
				if (chkNoTitle.checked) do append res ("\"no_title\":true,")
                if (chkDoNotScale.checked) do append res ("\"do_not_scale\":true,")
                if (chkContact.checked) do append res ("\"booth_contact\":true,")
				
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
			
			function initRollout parsedJSON = (
				if (parsedJSON == undefined) then return undefined

				type = parsedJSON["type"]
				typeId = findItem ddType.items type
				ddType.selection = typeId
				
				tbId.text = valOrEmpty parsedJSON["id"]
				tbBoothModel.text = valOrEmpty parsedJSON["boothModel"]
				
				cbLabButton.text = valOrEmpty parsedJSON["lab_button"]
				cbKey3d.text = valOrEmpty parsedJSON["key_3d"]
				
				tbLightmap.text = valOrEmpty parsedJSON["lightmap"]
				cbUseLightmap.text = valOrEmpty parsedJSON["useLightmap"]
				tbEnvmap.text = valOrEmpty parsedJSON["envmap"]
				tbUseEnvmap.text = valOrEmpty parsedJSON["useEnvmap"]
				
				tbInstanceSource.text = valOrEmpty parsedJSON["instanceSource"]
				tbReplaceBy.text = valOrEmpty parsedJSON["replaceBy"]
				
				tbMaterial.text = valOrEmpty parsedJSON["material"]
				
				try ( chkTooltip.checked = parsedJSON["booth_tooltip"] ) catch ( chkTooltip.checked = false )
				try ( chkNoTitle.checked = parsedJSON["no_title"] ) catch ( chkNoTitle.checked = false )
                try ( chkDoNotScale.checked = parsedJSON["do_not_scale"] ) catch ( chkDoNotScale.checked = false )
                try ( chkContact.checked = parsedJSON["booth_contact"] ) catch ( chkContact.checked = false )
                
                generateJSON()
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
			
			function setupDotnetControls = (
				mcolor = dotnetclass "System.drawing.color" 
				maxBackColor = colorMan.getColor #background
				maxForeColor = colorMan.getColor #text
				dotnetBackColor = mColor.FromArgb (maxBackColor[1] * 255.0f) (maxBackColor[2] * 255.0f) (maxBackColor[3] * 255.0f)
				dotnetForeColor = mColor.FromArgb (maxForeColor[1] * 255.0f) (maxForeColor[2] * 255.0f) (maxForeColor[3] * 255.0f)
				
				cbLabButton.backColor = dotnetBackColor
				cbLabButton.foreColor = dotnetForeColor
				cbKey3d.backColor = dotnetBackColor
				cbKey3d.foreColor = dotnetForeColor
				cbUseLightmap.backColor = dotnetBackColor
				cbUseLightmap.foreColor = dotnetForeColor
				
				--cbUseLightmap.AutoCompleteMode = (dotNetClass "System.Windows.Forms.AutoCompleteMode").SuggestAppend -- doesn't work
			)
            
			on congressObjectPropertiesRollout open do
			(
				unregCallbacks()
				regCallbacks()
				
				setupDotnetControls()
				fillComboboxes()
				
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
			on cbLabButton textupdate value do
				generateJSON()
			on cbLabButton SelectedValueChanged value do
				generateJSON()
			on cbKey3d textupdate value do
				generateJSON()
			on cbKey3d SelectedValueChanged value do
				generateJSON()
			on tbInstanceSource changed value do
				generateJSON()
			on tbReplaceBy changed value do
				generateJSON()
			on tbLightmap changed value do
				generateJSON()
			on btDefaultLightmap pressed do
				tbLightmap.text = "default"
			on tbEnvmap changed value do
				generateJSON()
			on btDefaultEnvmap pressed do
				tbEnvmap.text = "default"
			on tbUseEnvmap changed value do
				generateJSON()
			on tbMaterial changed value do
				generateJSON()
			on chkTooltip changed state do
				generateJSON()
			on chkNoTitle changed state do
				generateJSON()
            on chkDoNotScale changed state do
                generateJSON()
            on chkContact changed state do
                generateJSON()
			on cbUseLightmap textupdate value do
				generateJSON()
			on cbUseLightmap SelectedValueChanged value do
				generateJSON()
		)
		createDialog congressObjectPropertiesRollout
	)

)
