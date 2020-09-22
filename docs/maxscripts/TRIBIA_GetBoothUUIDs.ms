(
    -- v0.1
    clearListener()
    
    local pyJSON = python.import #json
    function getNodeData _node = (
		try (rawJSON = getUserProp _node "babylonjs_tag") catch()
		if (rawJSON == undefined OR rawJSON == "") then rawJSON = ""
		else parsedJSON = pyJSON.loads(rawJSON)
		return parsedJSON
	)
    function valOrEmpty value = (
        if value == undefined then return ""
        else return value as string
    )

    local uuids = #()
    
    for obj in objects do (
        local parsedJson = getNodeData obj
        if parsedJson == undefined do continue
        
        local uuid = valOrEmpty parsedJson["id"]
        if uuid != "" then append uuids uuid
    )
    
    local uuidChain = ""
    for uuid in uuids do (
        uuidChain += uuid + ";"
    )
        
    format ("UUIDs :\n\n" + uuidChain + "\n\n\n")
)
