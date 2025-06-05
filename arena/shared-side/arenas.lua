Wait(1000)
config.arenas = {
    -- [1] = { 
    --     nome = "AIMLAB", -- Nome da Arena 
    --     aimlab = 'baloon',
    --     weaponDisplay = {"PISTOLA"}, -- Nome da Arma que vai aparecer na NUI
    --     descricacao = "<div><b>AIMLAB:</b> PISTOLA </div>", -- Descricao da NUI
    --     imagem = "https://cache.nowayrp.uk/Scripts%2FArena%2FNeon.png", -- Imagem da Arena
    --     maxPlayers = 1, -- Maximo de Jogadores na Arena
    --     timeArena = 999, -- Tempo da Arena (em minutos)
    --     minAposta = 0, -- Valor minimo da Aposta
    --     coords = {}
    -- },

    [1] = {
        nome = "ARENA CARGAS X40 G36 ", -- Nome da Arena 
        arma = "WEAPON_SPECIALCARBINE_MK2", -- Arma da Arena
        weaponDisplay = {"G36"}, -- Nome da Arma que vai aparecer na NUI
        descricacao = "<div><b>Arma:</b> G36 </div>    <div class='lowerTitle'><b>Tempo:</b> 20 Minutos  </div>", -- Descricao da NUI
        imagem = "https://cache.nowayrp.uk/Scripts%2FArena%2FDestrocos.png", -- Imagem da Arena
        maxPlayers = 40, -- Maximo de Jogadores na Arena
        timeArena = 20, -- Tempo da Arena (em minutos)
        minAposta = 5000, -- Valor minimo da Aposta
        coords = { -- CORDENADAS DE SPAWNS NA ARENA
            [1] = vec3(8114.59,3069.67,728.86),
            [2] = vec3(8115.57,3124.83,728.86),
            [3] = vec3(8123.01,3166.67,728.86),
            [4] = vec3(8163.28,3157.54,728.86),
            [5] = vec3(8157.33,3117.26,728.79),
            [6] = vec3(8155.76,3087.97,728.79),
            [7] = vec3(8129.57,3106.63,728.85),
            [8] = vec3(8132.9,3136.76,728.83),
              }
    },


    -- [2] = { 
    --     nome = "DESCE E QUEBRA", -- Nome da Arena 
    --     arma = "WEAPON_SPECIALCARBINE", -- Arma da Arena
    --     weaponDisplay = {"PARAFAL"}, -- Nome da Arma que vai aparecer na NUI
    --     descricacao = "<div><b>Arma:</b> M4 </div>    <div class='lowerTitle'><b>Tempo:</b> 20 Minutos  </div>", -- Descricao da NUI
    --     imagem = "https://cache.nowayrp.uk/Scripts%2FArena%2FNeon.png", -- Imagem da Arena
    --     maxPlayers = 20, -- Maximo de Jogadores na Arena
    --     timeArena = 20, -- Tempo da Arena (em minutos)
    --     minAposta = 5000, -- Valor minimo da Aposta
    --     mode = "descequebra",
    --     vehicle = '10r24nbrt',
    --     coords = { -- CORDENADAS DE SPAWNS NA ARENA
    --         [1] = vec3(-504.48,-893.9,28.04),
    --         [2] = vec3(-547.79,-956.04,23.28),
    --         [3] = vec3(-495.22,-800.72,30.62),
    --         [4] = vec3(-522.1,-748.49,32.87),
    --         [5] = vec3(-554.23,-708.69,33.03),
    --         [6] = vec3(-630.1,-759.76,26.11),
    --         [7] = vec3(-649.28,-827.47,24.51),
    --         [8] = vec3(-647.64,-957.04,22.85),
    --         [9] = vec3(-556.75,-839.86,27.53)

    --     }
    -- },

    
    [2] = { 
        nome = "ARENA NEON X20 PARAFAL", -- Nome da Arena 
        arma = "WEAPON_SPECIALCARBINE", -- Arma da Arena
        weaponDisplay = {"PARAFAL"}, -- Nome da Arma que vai aparecer na NUI
        descricacao = "<div><b>Arma:</b> M4 </div>    <div class='lowerTitle'><b>Tempo:</b> 20 Minutos  </div>", -- Descricao da NUI
        imagem = "https://cache.nowayrp.uk/Scripts%2FArena%2FNeon.png", -- Imagem da Arena
        maxPlayers = 20, -- Maximo de Jogadores na Arena
        timeArena = 20, -- Tempo da Arena (em minutos)
        minAposta = 5000, -- Valor minimo da Aposta
        coords = { -- CORDENADAS DE SPAWNS NA ARENA
            [1] = vec3(-6547.14,1550.14,762.63),
            [2] = vec3(-6521.56,1545.97,762.63),
            [3] = vec3(-6528.36,1571.19,762.64),
            [4] = vec3(-6545.38,1575.41,762.62),
            [5] = vec3(-6526.74,1585.79,762.61),
            [6] = vec3(-6547.65,1592.36,762.62),
            [7] = vec3(-6549.22,1564.49,762.6),
            [8] = vec3(-6522.77,1565.3,762.62),
        }
    },


    [3] = { 
        nome = "ARENA COPA X25", -- Nome da Arena 
        arma = "WEAPON_MILITARYRIFLE", -- Arma da Arena
        weaponDisplay = {"AUG"}, -- Nome da Arma que vai aparecer na NUI
        descricacao = "<div><b>Arma:</b> AUG </div>    <div class='lowerTitle'><b>Tempo:</b> 20 Minutos  </div>", -- Descricao da NUI
        imagem = "https://cache.nowayrp.uk/Scripts%2FArena%2FARENA_COPA.png", -- Imagem da Arena
        maxPlayers = 25, -- Maximo de Jogadores na Arena
        timeArena = 20, -- Tempo da Arena (em minutos)
        minAposta = 5000, -- Valor minimo da Aposta
        coords = { -- CORDENADAS DE SPAWNS NA ARENA
            [1] = vec3(-2462.83,-6021.24,651.85),
            [2] = vec3(-2446.66,-6035.98,651.84),
            [3] = vec3(-2465.88,-6056.06,651.84),
            [4] = vec3(-2468.12,-6097.09,651.84),
            [5] = vec3(-2435.86,-6081.98,651.84),
            [6] = vec3(-2412.69,-6097.38,651.84),
            [7] = vec3(-2421.29,-6057.36,651.84),
            [8] = vec3(-2400.69,-6060.02,651.85),
            [9] = vec3(-2412.3,-6028.8,651.85),
            [10] = vec3(-2376.06,-6014.68,651.85),
            [11] = vec3(-2353.14,-6017.26,651.84),
            [12] = vec3(-2374.69,-6042.62,651.84),
            [13] = vec3(-2355.99,-6061.02,651.84),
            [14] = vec3(-2377.52,-6081.42,651.84),
            [15] = vec3(-2355.49,-6097.74,651.84),
            [16] = vec3(-2412.97,-6054.58,651.84),
        }
    },

    [4] = { 
        nome = "Arena 1X1", -- Nome da Arena 
        descricacao = "<div><b>Arma:</b> Pistola MK2 </div>   <div class='lowerTitle'><b>Tempo:</b> 10 Minutos </div>", -- Descricao da NUI
        arma = "WEAPON_PISTOL_MK2", -- Arma da Arena
        weaponDisplay = {"Pistola MK2"}, -- Nome da Arma que vai aparecer na NUI
        imagem = "https://cache.nowayrp.uk/Scripts%2FArena%2F1x1.png", -- Imagem da Arena
        maxPlayers = 2, -- Maximo de Jogadores na Arena
        timeArena = 10, -- Tempo da Arena (em minutos)
        minAposta = 5000, -- Valor minimo da Aposta
        coords = { -- CORDENADAS DE SPAWNS NA ARENA
            [1] = vec3(-156.08,-1016.48,254.8),
            [2] = vec3(-172.02,-1010.17,254.14),
            [3] = vec3(-171.43,-993.7,253.88),
            [4] = vec3(-146.8,-989.77,254.13),
            [5] = vec3(-156.06,-963.16,254.14),
            [6] = vec3(-135.25,-960.07,254.14),
            [7] = vec3(-142.75,-947.4,254.14),
            [8] = vec3(-163.07,-954.51,254.14)
        }
    },


    [5] = { 
        nome = "ARENA CARGAS X40 G36", -- Nome da Arena 
        arma = "WEAPON_SPECIALCARBINE_MK2", -- Arma da Arena
        weaponDisplay = {"FUZIL G36"}, -- Nome da Arma que vai aparecer na NUI
        descricacao = "<div><b>Arma:</b> FUZIL G36 </div>    <div class='lowerTitle'><b>Tempo:</b> 20 Minutos  </div>", -- Descricao da NUI
        imagem = "https://cache.nowayrp.uk/Scripts%2FArena%2F40x.png", -- Imagem da Arena
        maxPlayers = 40, -- Maximo de Jogadores na Arena
        timeArena = 20, -- Tempo da Arena (em minutos)
        minAposta = 5000, -- Valor minimo da Aposta
        coords = { -- CORDENADAS DE SPAWNS NA ARENA
            [1] = vec3(8117.64,3779.68,728.86),
            [2] = vec3(8138.88,3794.33,728.86),
            [3] = vec3(8161.13,3778.12,728.86),
            [4] = vec3(8156.75,3815.6,728.87),
            [5] = vec3(8160.39,3859.8,728.86),
            [6] = vec3(8119.33,3861.53,728.86),
            [7] = vec3(8124.08,3834.33,728.86),
            [8] = vec3(8140.99,3844.06,728.86),
              }
    },


    [6] = { 
        nome = "ARENA CARGAS X40 TEC", -- Nome da Arena 
        arma = "WEAPON_MACHINEPISTOL", -- Arma da Arena
        weaponDisplay = {"TEC 9"}, -- Nome da Arma que vai aparecer na NUI
        descricacao = "<div><b>Arma:</b> TEC 9 </div>    <div class='lowerTitle'><b>Tempo:</b> 20 Minutos  </div>", -- Descricao da NUI
        imagem = "https://cache.nowayrp.uk/Scripts%2FArena%2F40x.png", -- Imagem da Arena
        maxPlayers = 40, -- Maximo de Jogadores na Arena
        timeArena = 20, -- Tempo da Arena (em minutos)
        minAposta = 5000, -- Valor minimo da Aposta
        coords = { -- CORDENADAS DE SPAWNS NA ARENA
            [1] = vec3(8117.64,3779.68,728.86),
            [2] = vec3(8138.88,3794.33,728.86),
            [3] = vec3(8161.13,3778.12,728.86),
            [4] = vec3(8156.75,3815.6,728.87),
            [5] = vec3(8160.39,3859.8,728.86),
            [6] = vec3(8119.33,3861.53,728.86),
            [7] = vec3(8124.08,3834.33,728.86),
            [8] = vec3(8140.99,3844.06,728.86),
              }
    },


    [7] = { 
        nome = "ARENA FAZENDA X30 PISTOLA", -- Nome da Arena 
        arma = "WEAPON_PISTOL_MK2", -- Arma da Arena
        weaponDisplay = {"PISTOLA"}, -- Nome da Arma que vai aparecer na NUI
        descricacao = "<div><b>Arma:</b> PISTOLA </div>    <div class='lowerTitle'><b>Tempo:</b> 20 Minutos  </div>", -- Descricao da NUI
        imagem = "https://cache.nowayrp.uk/Scripts%2FArena%2F30x.png", -- Imagem da Arena
        maxPlayers = 30, -- Maximo de Jogadores na Arena
        timeArena = 20, -- Tempo da Arena (em minutos)
        minAposta = 5000, -- Valor minimo da Aposta
        coords = { -- CORDENADAS DE SPAWNS NA ARENA
            [1] = vec3(6203.62,3348.52,761.63),
            [2] = vec3(6224.47,3349.24,761.63),
            [3] = vec3(6229.5,3364.91,761.63),
            [4] = vec3(6202.74,3365.54,761.63),
            [5] = vec3(6201.89,3380.2,761.63),
            [6] = vec3(6232.59,3381.44,761.63),
            [7] = vec3(6229.3,3395.76,761.63),
            [8] = vec3(6202.81,3396.68,761.63),
              }
    },


    [8] = { 
        nome = "ARENA NAVIO X20 PISTOLA", -- Nome da Arena 
        arma = "WEAPON_PISTOL_MK2", -- Arma da Arena
        weaponDisplay = {"PISTOLA"}, -- Nome da Arma que vai aparecer na NUI
        descricacao = "<div><b>Arma:</b> PISTOLA </div>    <div class='lowerTitle'><b>Tempo:</b> 20 Minutos  </div>", -- Descricao da NUI
        imagem = "https://cache.nowayrp.uk/Scripts%2FArena%2F20x.png", -- Imagem da Arena
        maxPlayers = 20, -- Maximo de Jogadores na Arena
        timeArena = 20, -- Tempo da Arena (em minutos)
        minAposta = 5000, -- Valor minimo da Aposta
        coords = { -- CORDENADAS DE SPAWNS NA ARENA
            [1] = vec3(-5791.2,10325.04,10.63),
            [2] = vec3(-5802.12,10287.87,10.61),
            [3] = vec3(-5781.79,10247.22,10.63),
            [4] = vec3(-5803.05,10204.84,10.6),
            [5] = vec3(-5782.99,10249.36,10.63),
              }
    },


    [9] = { 
        nome = "ARENA CARGAS X40 PISTOLA", -- Nome da Arena 
        arma = "WEAPON_PISTOL_MK2", -- Arma da Arena
        weaponDisplay = {"PISTOLA"}, -- Nome da Arma que vai aparecer na NUI
        descricacao = "<div><b>Arma:</b> PISTOLA </div>    <div class='lowerTitle'><b>Tempo:</b> 20 Minutos  </div>", -- Descricao da NUI
        imagem = "https://cache.nowayrp.uk/Scripts%2FArena%2FDestrocos.png", -- Imagem da Arena
        maxPlayers = 40, -- Maximo de Jogadores na Arena
        timeArena = 20, -- Tempo da Arena (em minutos)
        minAposta = 5000, -- Valor minimo da Aposta
        coords = { -- CORDENADAS DE SPAWNS NA ARENA
            [1] = vec3(8114.59,3069.67,728.86),
            [2] = vec3(8115.57,3124.83,728.86),
            [3] = vec3(8123.01,3166.67,728.86),
            [4] = vec3(8163.28,3157.54,728.86),
            [5] = vec3(8157.33,3117.26,728.79),
            [6] = vec3(8155.76,3087.97,728.79),
            [7] = vec3(8129.57,3106.63,728.85),
            [8] = vec3(8132.9,3136.76,728.83),
              }
    },

    [10] = { 
        nome = "ARENA CARGAS X40 G36 ", -- Nome da Arena 
        arma = "WEAPON_SPECIALCARBINE_MK2", -- Arma da Arena
        weaponDisplay = {"G36"}, -- Nome da Arma que vai aparecer na NUI
        descricacao = "<div><b>Arma:</b> G36 </div>    <div class='lowerTitle'><b>Tempo:</b> 20 Minutos  </div>", -- Descricao da NUI
        imagem = "https://cache.nowayrp.uk/Scripts%2FArena%2FDestrocos.png", -- Imagem da Arena
        maxPlayers = 40, -- Maximo de Jogadores na Arena
        timeArena = 20, -- Tempo da Arena (em minutos)
        minAposta = 5000, -- Valor minimo da Aposta
        coords = { -- CORDENADAS DE SPAWNS NA ARENA
            [1] = vec3(8114.59,3069.67,728.86),
            [2] = vec3(8115.57,3124.83,728.86),
            [3] = vec3(8123.01,3166.67,728.86),
            [4] = vec3(8163.28,3157.54,728.86),
            [5] = vec3(8157.33,3117.26,728.79),
            [6] = vec3(8155.76,3087.97,728.79),
            [7] = vec3(8129.57,3106.63,728.85),
            [8] = vec3(8132.9,3136.76,728.83),
              }
    },

    [11] = { 
        nome = "ARENA CARGAS X40 SMG ", -- Nome da Arena 
        arma = "WEAPON_SMG_MK2", -- Arma da Arena
        weaponDisplay = {"SMG MK2"}, -- Nome da Arma que vai aparecer na NUI
        descricacao = "<div><b>Arma:</b> SMG </div>    <div class='lowerTitle'><b>Tempo:</b> 20 Minutos  </div>", -- Descricao da NUI
        imagem = "https://cache.nowayrp.uk/Scripts%2FArena%2FDestrocos.png", -- Imagem da Arena
        maxPlayers = 40, -- Maximo de Jogadores na Arena
        timeArena = 20, -- Tempo da Arena (em minutos)
        minAposta = 5000, -- Valor minimo da Aposta
        coords = { -- CORDENADAS DE SPAWNS NA ARENA
            [1] = vec3(8114.59,3069.67,728.86),
            [2] = vec3(8115.57,3124.83,728.86),
            [3] = vec3(8123.01,3166.67,728.86),
            [4] = vec3(8163.28,3157.54,728.86),
            [5] = vec3(8157.33,3117.26,728.79),
            [6] = vec3(8155.76,3087.97,728.79),
            [7] = vec3(8129.57,3106.63,728.85),
            [8] = vec3(8132.9,3136.76,728.83),
              }
    },

    [12] = { 
        nome = "ARENA NEON X20 M4", -- Nome da Arena 
        arma = "WEAPON_CARBINERIFLE", -- Arma da Arena
        weaponDisplay = {"M4 "}, -- Nome da Arma que vai aparecer na NUI
        descricacao = "<div><b>Arma:</b> M4 </div>    <div class='lowerTitle'><b>Tempo:</b> 20 Minutos  </div>", -- Descricao da NUI
        imagem = "https://cache.nowayrp.uk/Scripts%2FArena%2FNeon.png", -- Imagem da Arena
        maxPlayers = 20, -- Maximo de Jogadores na Arena
        timeArena = 20, -- Tempo da Arena (em minutos)
        minAposta = 5000, -- Valor minimo da Aposta
        coords = { -- CORDENADAS DE SPAWNS NA ARENA
            [1] = vec3(-6547.14,1550.14,762.63),
            [2] = vec3(-6521.56,1545.97,762.63),
            [3] = vec3(-6528.36,1571.19,762.64),
            [4] = vec3(-6545.38,1575.41,762.62),
            [5] = vec3(-6526.74,1585.79,762.61),
            [6] = vec3(-6547.65,1592.36,762.62),
            [7] = vec3(-6549.22,1564.49,762.6),
            [8] = vec3(-6522.77,1565.3,762.62),
              }
    },

    [13] = { 
        nome = "ARENA NEON X20 PISTOLA", -- Nome da Arena 
        arma = "WEAPON_PISTOL_MK2", -- Arma da Arena
        weaponDisplay = {"PISTOLA"}, -- Nome da Arma que vai aparecer na NUI
        descricacao = "<div><b>Arma:</b> PISTOLA </div>    <div class='lowerTitle'><b>Tempo:</b> 20 Minutos  </div>", -- Descricao da NUI
        imagem = "https://cache.nowayrp.uk/Scripts%2FArena%2FNeon.png", -- Imagem da Arena
        maxPlayers = 20, -- Maximo de Jogadores na Arena
        timeArena = 20, -- Tempo da Arena (em minutos)
        minAposta = 5000, -- Valor minimo da Aposta
        coords = { -- CORDENADAS DE SPAWNS NA ARENA
            [1] = vec3(-6547.14,1550.14,762.63),
            [2] = vec3(-6521.56,1545.97,762.63),
            [3] = vec3(-6528.36,1571.19,762.64),
            [4] = vec3(-6545.38,1575.41,762.62),
            [5] = vec3(-6526.74,1585.79,762.61),
            [6] = vec3(-6547.65,1592.36,762.62),
            [7] = vec3(-6549.22,1564.49,762.6),
            [8] = vec3(-6522.77,1565.3,762.62),
              }
    },

    [14] = { 
        nome = "ARENA NEON X20 TEC ", -- Nome da Arena 
        arma = "WEAPON_MACHINEPISTOL", -- Arma da Arena
        weaponDisplay = {"TEC 9 "}, -- Nome da Arma que vai aparecer na NUI
        descricacao = "<div><b>Arma:</b> TEC 9 </div>    <div class='lowerTitle'><b>Tempo:</b> 20 Minutos  </div>", -- Descricao da NUI
        imagem = "https://cache.nowayrp.uk/Scripts%2FArena%2FNeon.png", -- Imagem da Arena
        maxPlayers = 20, -- Maximo de Jogadores na Arena
        timeArena = 20, -- Tempo da Arena (em minutos)
        minAposta = 5000, -- Valor minimo da Aposta
        coords = { -- CORDENADAS DE SPAWNS NA ARENA
            [1] = vec3(-6547.14,1550.14,762.63),
            [2] = vec3(-6521.56,1545.97,762.63),
            [3] = vec3(-6528.36,1571.19,762.64),
            [4] = vec3(-6545.38,1575.41,762.62),
            [5] = vec3(-6526.74,1585.79,762.61),
            [6] = vec3(-6547.65,1592.36,762.62),
            [7] = vec3(-6549.22,1564.49,762.6),
            [8] = vec3(-6522.77,1565.3,762.62),
              }
    },
    
    [15] = { 
        nome = "ARENA NEON2 X25 PISTOLA", -- Nome da Arena 
        arma = "WEAPON_PISTOL_MK2", -- Arma da Arena
        weaponDisplay = {"PISTOLA "}, -- Nome da Arma que vai aparecer na NUI
        descricacao = "<div><b>Arma:</b> PISTOLA </div>    <div class='lowerTitle'><b>Tempo:</b> 20 Minutos  </div>", -- Descricao da NUI
        imagem = "https://cache.nowayrp.uk/Scripts%2FArena%2FNeon2.png", -- Imagem da Arena
        maxPlayers = 25, -- Maximo de Jogadores na Arena
        timeArena = 20, -- Tempo da Arena (em minutos)
        minAposta = 5000, -- Valor minimo da Aposta
        coords = { -- CORDENADAS DE SPAWNS NA ARENA
            [1] = vec3(-6277.72,645.25,762.63),
            [2] = vec3(-6253.55,643.93,762.67),
            [3] = vec3(-6257.08,664.02,762.62),
            [4] = vec3(-6264.34,672.28,762.63),
            [5] = vec3(-6269.11,669.02,762.63),
            [6] = vec3(-6278.6,656.66,762.63),
            [7] = vec3(-6276.99,688.52,762.62),
            [8] = vec3(-6251.21,687.98,762.69),
              }
    },

    [16] = { 
        nome = "ARENA NEON2 X25 G36 ", -- Nome da Arena 
        arma = "WEAPON_SPECIALCARBINE_MK2", -- Arma da Arena
        weaponDisplay = {"G36"}, -- Nome da Arma que vai aparecer na NUI
        descricacao = "<div><b>Arma:</b> G36 </div>    <div class='lowerTitle'><b>Tempo:</b> 20 Minutos  </div>", -- Descricao da NUI
        imagem = "https://cache.nowayrp.uk/Scripts%2FArena%2FNeon2.png", -- Imagem da Arena
        maxPlayers = 25, -- Maximo de Jogadores na Arena
        timeArena = 20, -- Tempo da Arena (em minutos)
        minAposta = 5000, -- Valor minimo da Aposta
        coords = { -- CORDENADAS DE SPAWNS NA ARENA
            [1] = vec3(-6277.72,645.25,762.63),
            [2] = vec3(-6253.55,643.93,762.67),
            [3] = vec3(-6257.08,664.02,762.62),
            [4] = vec3(-6264.34,672.28,762.63),
            [5] = vec3(-6269.11,669.02,762.63),
            [6] = vec3(-6278.6,656.66,762.63),
            [7] = vec3(-6276.99,688.52,762.62),
            [8] = vec3(-6251.21,687.98,762.69),
              }
    },
    
    [17] = { 
        nome = "Arena X20", -- Nome da Arena 
        arma = "WEAPON_PISTOL_MK2", -- Arma da Arena
        weaponDisplay = {"PISTOLA"}, -- Nome da Arma que vai aparecer na NUI
        descricacao = "<div><b>Arma:</b> Pistola MK2 </div>    <div class='lowerTitle'><b>Tempo:</b> 20 Minutos  </div>", -- Descricao da NUI
        imagem = "https://cache.nowayrp.uk/Scripts%2FArena%2F1x1.png", -- Imagem da Arena
        maxPlayers = 20, -- Maximo de Jogadores na Arena
        timeArena = 20, -- Tempo da Arena (em minutos)
        minAposta = 5000, -- Valor minimo da Aposta
        coords = { -- CORDENADAS DE SPAWNS NA ARENA
            [1] = vec3(-156.08,-1016.48,254.8),
            [2] = vec3(-172.02,-1010.17,254.14),
            [3] = vec3(-171.43,-993.7,253.88),
            [4] = vec3(-146.8,-989.77,254.13),
            [5] = vec3(-156.06,-963.16,254.14),
            [6] = vec3(-135.25,-960.07,254.14),
            [7] = vec3(-142.75,-947.4,254.14),
            [8] = vec3(-163.07,-954.51,254.14)
        }
    },


    [18] = { 
        nome = "Arena X20", -- Nome da Arena 
        arma = "WEAPON_MACHINEPISTOL", -- Arma da Arena
        weaponDisplay = {"TEC-9"}, -- Nome da Arma que vai aparecer na NUI
        descricacao = "<div><b>Arma:</b> TEC-9 </div>    <div class='lowerTitle'><b>Tempo:</b> 20 Minutos  </div>", -- Descricao da NUI
        imagem = "https://cache.nowayrp.uk/Scripts%2FArena%2FTeatro.png", -- Imagem da Arena
        maxPlayers = 20, -- Maximo de Jogadores na Arena
        timeArena = 20, -- Tempo da Arena (em minutos)
        minAposta = 5000, -- Valor minimo da Aposta
        coords = { -- CORDENADAS DE SPAWNS NA ARENA
            [1] = vec3(-1137.71,-593.67,29.73),
            [2] = vec3(-1107.73,-576.17,32.73),
            [3] = vec3(-1077.81,-561.61,33.61),
            [4] = vec3(-1036.34,-537.94,35.2),
            [5] = vec3(-1025.95,-510.98,36.16),
            [6] = vec3(-1045.04,-519.22,36.23),
            [7] = vec3(-1096.22,-434.27,36.29),
            [8] = vec3(-1097.07,-475.42,34.96),
            [9] = vec3(-1112.17,-447.76,34.96),
            [10] = vec3(-1118.21,-454.6,35.76),
            [11] = vec3(-1150.62,-454.6,34.79),
            [12] = vec3(-1185.34,-467.3,33.06),
            [13] = vec3(-1222.38,-498.81,30.92),
            [14] = vec3(-1255.14,-520.23,31.73),
            [15] = vec3(-1231.16,-548.26,29.22),
            [16] = vec3(-1206.82,-572.51,26.97),
            [17] = vec3(-1195.0,-541.43,29.08),
            [18] = vec3(-1166.65,-534.97,30.13),
            [19] = vec3(-1154.87,-524.47,32.07)
            -- [20] = vec3(-146.8,-989.77,254.13)
        }
    },

    [19] = { 
        nome = "ARENA CARGAS X40 PARAFAL", -- Nome da Arena 
        arma = "WEAPON_SPECIALCARBINE", -- Arma da Arena
        weaponDisplay = {"PARAFAL"}, -- Nome da Arma que vai aparecer na NUI
        descricacao = "<div><b>Arma:</b> SMG </div>    <div class='lowerTitle'><b>Tempo:</b> 20 Minutos  </div>", -- Descricao da NUI
        imagem = "https://cache.nowayrp.uk/Scripts%2FArena%2FDestrocos.png", -- Imagem da Arena
        maxPlayers = 40, -- Maximo de Jogadores na Arena
        timeArena = 20, -- Tempo da Arena (em minutos)
        minAposta = 5000, -- Valor minimo da Aposta
        coords = { -- CORDENADAS DE SPAWNS NA ARENA
            [1] = vec3(8114.59,3069.67,728.86),
            [2] = vec3(8115.57,3124.83,728.86),
            [3] = vec3(8123.01,3166.67,728.86),
            [4] = vec3(8163.28,3157.54,728.86),
            [5] = vec3(8157.33,3117.26,728.79),
            [6] = vec3(8155.76,3087.97,728.79),
            [7] = vec3(8129.57,3106.63,728.85),
            [8] = vec3(8132.9,3136.76,728.83),
              }
    },

    -- [19] = { 
    --     nome = "DESCE E QUEBRA", -- Nome da Arena 
    --     arma = "WEAPON_SPECIALCARBINE", -- Arma da Arena
    --     weaponDisplay = {"PARAFAL"}, -- Nome da Arma que vai aparecer na NUI
    --     descricacao = "<div><b>Arma:</b> M4 </div>    <div class='lowerTitle'><b>Tempo:</b> 20 Minutos  </div>", -- Descricao da NUI
    --     imagem = "https://cache.nowayrp.uk/Scripts%2FArena%2FNeon.png", -- Imagem da Arena
    --     maxPlayers = 20, -- Maximo de Jogadores na Arena
    --     timeArena = 20, -- Tempo da Arena (em minutos)
    --     minAposta = 5000, -- Valor minimo da Aposta
    --     mode = "descequebra",
    --     coords = { -- CORDENADAS DE SPAWNS NA ARENA
    --         [1] = vec3(-6547.14,1550.14,762.63),
    --         [2] = vec3(-6521.56,1545.97,762.63),
    --         [3] = vec3(-6528.36,1571.19,762.64),
    --         [4] = vec3(-6545.38,1575.41,762.62),
    --         [5] = vec3(-6526.74,1585.79,762.61),
    --         [6] = vec3(-6547.65,1592.36,762.62),
    --         [7] = vec3(-6549.22,1564.49,762.6),
    --         [8] = vec3(-6522.77,1565.3,762.62),
    --     }
    -- },


    -- [18] = { 
    --     nome = "AIMLAB (NPC)", -- Nome da Arena 
    --     aimlab = 'npc',
    --     weaponDisplay = {"PISTOLA"}, -- Nome da Arma que vai aparecer na NUI
    --     descricacao = "<div><b>AIMLAB:</b> PISTOLA </div>", -- Descricao da NUI
    --     imagem = "https://cache.nowayrp.uk/Scripts%2FArena%2FNeon.png", -- Imagem da Arena
    --     maxPlayers = 1, -- Maximo de Jogadores na Arena
    --     timeArena = 999, -- Tempo da Arena (em minutos)
    --     minAposta = 0, -- Valor minimo da Aposta
    --     coords = {}
    -- },
}