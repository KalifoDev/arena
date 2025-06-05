-----------------------------------------------------------------------------------------------------------------------------------------
-- REACT UTILS
-----------------------------------------------------------------------------------------------------------------------------------------
-- Função para padronizar o envio de mensagens para a UI de acordo com a documentação
function SendStandardMessage(action, data)
    SendNUIMessage({
        action = action,
        data = data
    })
end

-- Manter compatibilidade com código existente
function SendReactMessage(action, data)
    SendStandardMessage(action, data)
end

  
toggleNuiFrame = function (shouldShow)
    SetNuiFocus(shouldShow, shouldShow)
    SendReactMessage('setVisible', shouldShow)
    -- if shouldShow then
    --     StartScreenEffect("MenuMGSelectionIn", 0, true)
    -- else
    --     StopScreenEffect("MenuMGSelectionIn")
    -- end
end

RegisterNUICallback("hideFrame",function(data)
    toggleNuiFrame(false)
end)