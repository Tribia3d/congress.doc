(
	macroScript CopyPasteTransformRollout
	category:"TRIBIA"
	toolTip:"Copy Paste Object Transform"
	buttontext:"CpyPstTrans"
	(
        global CopyPasteTransformRollout
        try ( destroyDialog CopyPasteTransformRollout ) catch()	
        rollout CopyPasteTransformRollout "Copy / Paste objects transform" width:208 height:88
        (
            button 'btCopy' "Copy object transform" pos:[8,8] width:192 height:32 align:#left
            button 'btPaste' "Paste transform to object" pos:[8,48] width:192 height:32 align:#left
            
            on btCopy pressed  do (
                local dataToCopy = selection[1].transform
                setclipboardText (dataToCopy as string)
            )
            
            on btPaste pressed  do (
                local dataToPaste = getclipboardText()
                selection[1].transform = execute(dataToPaste)
            )
        )
        createDialog CopyPasteTransformRollout
    )
)
