; 必需，在魔能这个游戏中，按键必需按下一定的时间
pressDuration = 75
SetKeyDelay , 75, pressDuration
SetMouseDelay, pressDuration

; 施法方式
force   = 1     ; Force/Beam Effect, right click
spell   = 2     ; space
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

; 魔法组合
teleport    = % lightning . arcane . lightning  ; 传送术
haste       = % lightning . arcane . fire       ; 加速术
grease      = % water . earth . heal            ; 油腻术

; 双冰爆炸闪电墙
doubleIceExplodingElectricWall = % ice . ice . arcane . lightning . shield
; 大范围/长时间超级蒸汽闪电奥术
arcaneSteamLightning = % steam . steam . arcane . arcane . lightning
; 蒸汽闪电风暴
steamLightning = % steam . lightning . lightning . lightning . shield

; 暴雪球
blizzardBall = % ice . ice . ice . ice . earth

; 蒸汽奥术雷盾
steamArcaneLightningShield = % steam . arcane . lightning . shield


; 快捷键设置
1::doMagickaSpell(teleport, spell)
2::doMagickaSpell(haste, spell)
3::doMagickaSpell(steamArcaneLightningShield, self)
z::doMagickaSpell(doubleIceExplodingElectricWall, none)
x::doMagickaSpell(arcaneSteamLightning, aoe)
c::doMagickaSpell(grease, spell)
v::doMagickaSpell(steamLightning, none)


/*
 * formula - 魔法公式，例如 teleport
 * castmode - 释放魔法的方式，例如 force
 */
doMagickaSpell(formula, castmode) {
    global

    send %formula%

    if (castmode = force) {         ; Force/Beam Effect, right click
        send {Rbutton}
    }
    else if (castmode = spell) {    ; space
        send {Space}
    }
    else if (castmode = self) {     ; Self-Cast Effects, middle click
        send {Mbutton}
    }
    else if (castmode = aoe) {      ; Area Of Effect, shift + right click
        send {LShift down}{Rbutton down}
        sleep pressDuration
        send {Rbutton up}{Lshift up}
    }
    else if (castmode = imbue) {    ; Imbue Weapon, shift + left click
        send {LShift down}{Lbutton down}
        sleep pressDuration
        send {Lbutton up}{Lshift up}
    }
    else if (castmode = none) {
        ; nothing, 用户自行决定施法方式
    }
}
