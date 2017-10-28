setscreen ("graphics:1500;600")

const g : real := 15
const delayTime : int := 2
var x, y, t, dx, dy, dt, vx, vy : real
dt := 0.01
var speed : real := 200
var angle : real := 45
var r := 3
%var colour_name : array 1 .. 3 of string := init("red", "green", "blue")
var cycle : int := 1
% make a colour array and have the colour of the ball cycle thorugh each colour upon each bounce
% or have a colour gradient that cahnges the ball depending on its speed

proc Initialize
    t := 0
    x := 0
    y := 0
end Initialize

proc DrawObjects (c : int)
    if round (vy) > 0 then
	drawfilloval (ceil (x), ceil (y), r, r, green)
    elsif round (vy) < 0 then
	drawfilloval (ceil (x), ceil (y), r, r, red)
    elsif round (vy) = 0 then
	drawfilloval (ceil (x), ceil (y), r * 3, r * 3, cyan)
    end if
    %without the round() function, vy is rarely exactly equal to zero if ever
end DrawObjects

proc SetMotion
    vx := speed * cosd (angle)
    vy := speed * sind (angle)
end SetMotion

proc UpdateCycle
    cycle := (cycle + 1) mod 3 + 1
end UpdateCycle

proc Bounce
    if y >= maxy or y <= 0 then %top or bottom bounce
	vy := -7 / 8 * vy
	vx := 9/10 * vx

    end if
    if x >= maxx or x <= 0 then  %left or right bounce
	vx := -6 / 8 * vx
    end if
    if y > maxy then
	y := maxy
    end if
    if y < 0 then
	y := 0
    end if
    if x > maxx then
	x := maxx
    end if
    if x < 0 then
	x := 0
    end if
    UpdateCycle
end Bounce

proc Throw
    loop
	t := t + dt
	x := x + vx * dt
	y := y + vy * dt
	vy := vy - g * dt
	if y > maxy or y < 0 or x > maxx or x < 0 then
	    Bounce
	end if
	DrawObjects (cycle)
	delay (delayTime)
    end loop
end Throw



proc Main
    Initialize
    SetMotion
    Throw

end Main

Main
