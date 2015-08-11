; 当脚本已经运行，再次启动该脚本时，会跳过对话框并自动替换旧实例
#SingleInstance force
; 将游戏优先级设置为「高」
Process, Priority, Magicka, High
Process, Priority, Magicka.exe, High
; 将本游戏脚本进程优先级设置为「高」
Process, Priority, , High
; 将按键和鼠标初始化为无延迟，延迟操作将在程序中实现
SetKeyDelay, -1, -1
SetMouseDelay, -1


; 按键延迟，单位：毫秒
pressDurationFast       = 40    ; 按下单个键的时间（快）
delayBetweenKeysFast    = 40    ; 两次按键之间的延迟（快）
pressDurationSlow       = 75    ; 按下单个键的时间（慢）
delayBetweenKeysSlow    = 100   ; 两次按键之间的延迟（慢）


; 施法方式
force   = 1     ; Force/Beam Effect, right click
spell   = 2     ; Space
self    = 3     ; Self-Cast Effects, middle click
aoe     = 4     ; Area Of Effect, shift + right click
imbue   = 5     ; Imbue Weapon, shift + left click
none    = 6     ; nothing, 用户自行决定施法方式

; 元素按键
water       = q     ; 水
fire        = f     ; 火
lightning   = a     ; 电
earth       = d     ; 土
cold        = r     ; 雪
shield      = e     ; 盾
heal        = w     ; 生命
arcane      = s     ; 奥术
ice         = qr    ; 冰
steam       = qf    ; 水蒸汽

;;;;;; 需要注意的是相同的按键不要连着按，按键速度太快按不上去
;;;;;; 所以以下的魔法组合手动按起来并不是很好，只是为了考虑将相同的按键隔开

; 魔法组合
teleport        = % lightning . arcane . lightning  ; 传送术
haste           = % lightning . arcane . fire       ; 加速术
grease          = % water . earth . heal            ; 油腻术
thunderBolt     = % steam . lightning . arcane . lightning  ; 雷击术
Invisibility    = % arcane . shield . steam . arcane        ; 隐形术

; 伤害最高的光束，也可随时将其附魔在武器上
superSteamLightning = % steam . steam . steam . arcane . lightning
; 减缓敌人以及控制与之的距离，控制型光束
arcaneColdLigthning = % cold . arcane . lightning . arcane . lightning

; 当你被大量敌人包围的时候，可大范围减缓敌人的行动
freezequake = % earth . cold . earth . earth . earth
; 使大量敌人潮湿
waterquake = % earth . water . earth . earth . earth

; 暴雪球，单体高伤害
blizzardBall = % earth . ice . ice . ice . ice

; 范围大且伤害可观的群秒技能，可通过增加 steam 元素和减少 arcane 元素来增加伤害但会减小范围
steamElectricExplosion = % steam . arcane . lightning  . arcane . arcane
; 对潮湿敌人效果很好的群秒技能，比 ice . ice . arcane . lightning . lightning 伤害小，但范围大
arcaneIceLightning = % ice . ice . ice . lightning . arcane

; 超级爆炸闪电冰墙，威力很大，而且还会麻痹敌人，缺点是稍有不慎有性命之忧
superExplodingElectricIceWall = % ice . ice . shield . lightning . arcane
; 威力比较大，可麻痹可减缓，控制性很强，缺点是稍有不慎有性命之忧
explosiveSlowingLightningIcicles = % ice . lightning . arcane . shield . cold
; 威力比较大，且会麻痹敌人，可控可输出，相比上面的魔法危险性小一点，但是注意不要碰到冰山（若人物免疫闪电，请忽略这条）
ligthningIcicles = % ice . lightning . shield . lightning . lightning 
; 蒸汽闪电风暴，持续伤害非常高，但范围小
steamLigthningStorm = % steam . lightning . shield . lightning . lightning
; 可长时间让人麻痹和缓慢，缺点是范围小
frostLigthningStorm = % shield . cold . lightning . cold . lightning
; 高防御的墙，可让敌人去挖矿
stoneWall = % earth . shield . earth . earth . earth

; 盾，自己根据法师来选择
commonShield = % steam . steam . arcane . shield . fire


; 快捷键设置，若魔法施放有问题，可延长延迟时间（一般延迟 delayBetweenKeys 即可）
~LWin Up:: Return       ; 将左 Win 键屏蔽掉，但是又不妨碍其作为组合键使用
1::spellCasting(teleport, spell, pressDurationFast, delayBetweenKeysSlow)
2::spellCasting(haste, spell, pressDurationFast, delayBetweenKeysFast)
3::spellCasting(commonShield, self, pressDurationFast, delayBetweenKeysFast)
4::spellCasting(Invisibility, spell, pressDurationFast, delayBetweenKeysFast)
z::spellCasting(superExplodingElectricIceWall, imbue, pressDurationFast, delayBetweenKeysFast)
#z::spellCasting(ligthningIcicles, none, pressDurationFast, delayBetweenKeysSlow)
x::spellCasting(steamElectricExplosion, aoe, pressDurationFast, delayBetweenKeysSlow)
#x::spellCasting(arcaneIceLightning, aoe, pressDurationFast, delayBetweenKeysFast)
c::spellCasting(freezequake, aoe, pressDurationFast, delayBetweenKeysSlow)
#c::spellCasting(waterquake, aoe, pressDurationFast, delayBetweenKeysSlow)
v::spellCasting(thunderBolt, spell, pressDurationFast, delayBetweenKeysFast)
#a::spellCasting(arcaneColdLigthning, null, pressDurationFast, delayBetweenKeysFast)


; 按下按键，保持一定时间，之后延迟一段时间
pressKeyDelay(key, pressDuration, delayBetweenKeys) {
    send {%key% Down}
    sleep pressDuration
    send {%key% Up}

    sleep delayBetweenKeys
}

; 同时按下两个按键，保持一定时间，之后延迟一段时间
pressTwoKeysDelay(key1, key2, pressDuration, delayBetweenKeys) {
    send {%key1% down}{%key2% down}
    sleep pressDuration
    send {%key2% up}{%key1% up}

    sleep delayBetweenKeys
}

/*
 * 执行按键动作
 *
 * formula - 魔法公式，例如 teleport
 * castmode - 释放魔法的方式，例如 force
 * pressDuration - 按下单个键的时间（毫秒）
 * delayBetweenKeys - 两次按键之间的延迟（毫秒）
 *
 * 若调用 spellCasting(teleport, spell, pressDurationSlow, delayBetweenKeysSlow)
 * 那么按键情况如下
 * 1. 按下 a 键 pressDurationSlow 时间
 * 2. 等待 delayBetweenKeysSlow 时间
 * 3. 按下 s 键 pressDurationSlow 时间
 * 4. 等待 delayBetweenKeysSlow 时间
 * 5. 按下 a 键 pressDurationSlow 时间
 * 6. 等待 delayBetweenKeysSlow 时间
 * 7. 按下 Space 键 pressDurationSlow 时间
 * 8. 等待 delayBetweenKeysSlow 时间
 */
spellCasting(formula, castmode, pressDuration, delayBetweenKeys) {
    global force
    global spell
    global self
    global aoe
    global imbue
    global none

    Loop, parse, formula
    {
        pressKeyDelay(A_LoopField, pressDuration, delayBetweenKeys)
    }

    if (castmode = force) {         ; Force/Beam Effect, right click
        pressKeyDelay("RButton", pressDuration, delayBetweenKeys)
    }
    else if (castmode = spell) {    ; space
        pressKeyDelay("Space", pressDuration, delayBetweenKeys)
    }
    else if (castmode = self) {     ; Self-Cast Effects, middle click
        pressKeyDelay("MButton", pressDuration, delayBetweenKeys)
    }
    else if (castmode = aoe) {      ; Area Of Effect, shift + right click
        pressTwoKeysDelay("LShift", "Rbutton", pressDuration, delayBetweenKeys)
    }
    else if (castmode = imbue) {    ; Imbue Weapon, shift + left click
        pressTwoKeysDelay("LShift", "Lbutton", pressDuration, delayBetweenKeys)
    }
    else if (castmode = none) {
        ; nothing, 用户自行决定施法方式
        sleep delayBetweenKeys
    }
}