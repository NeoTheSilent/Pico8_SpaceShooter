pico-8 cartridge // http://www.pico-8.com
version 41
__lua__
--function of this program is to better learn how to make use of assets appearing during runtime properly and disposing of them

--jet information
jetx=64
jety=96
jetw=8
jeth=8
jmp=2
cldn=15
score=0
sec30=30
second=0
--fire information
firex=0
firey=130
--star information
s1x=12
s1y=0
s2x=60
s2y=10
s3x=85
s3y=20
smp=2
--meteor
m1x=130
m1y=130
m1xdir=0.5
m1ydir=1
m1cd=120

m2x=130
m2y=130
m2xdir=0
m2ydir=0
m2cd=540

--planet for visuals
p1x=130
p1y=130
p1xdir=0
p1ydir=0.75
p1cd=240

--large meteor
--will require 4 sprites
lm1x=130
lm1y=130
lm1xdir=0.5
lm1ydir=1
lm1cd=60
lm1dur=2

function jet()

	--movement for sides
	if (btn(0) and jetx>4)
	then 
	   jetx-=jmp
	elseif (btn(1) and jetx<118)
	then
				jetx+=jmp
	end
	
	--movement for height
	if (btn(2) and jety>4)
	then
	   jety-=jmp
	elseif (btn(3) and jety<118)
	then
			 jety+=jmp
	end
	
end

function fire()
 if (btnp(4) and cldn==15)
	then
	
	 --set cooldown of 0.5 seconds
	 cldn=0
	 
  --set laser relative to jet
  firex=jetx
  firey=jety
  
 end
 
end

function fstars()
 --if the stars go out of bounds
 --respawn at top
 if s1y==130 
 then 
  s1x=rnd(128)
  s1y=0
 end
 
 if s2y==130 
 then 
  s2x=rnd(128)
  s2y=0
 end
 
 if s3y==130 
 then 
  s3x=rnd(128)
  s3y=0
 end
 
end

function s_meteor()
 --set location for meteor
 if (m1cd==0)
 then
  --reset the x direction
  m1xdir=1
  --set spawn and reset cooldown
  m1x=rnd(128)
  m1y=0
  m1cd=120
  
  --affect direction
  if m1x>64
  then m1xdir*=-1
  end
  
 end
 
end

function l_meteor()
--set location for meteor
 if (lm1cd==0)
 then
  --reset the x direction
  lm1xdir=1
  --set spawn and reset cooldown
  lm1x=rnd(128)
  lm1y=0
  lm1cd=120
  
  --affect direction
  if lm1x>64
  then lm1xdir*=-1
  end  
 end

end

function planet()
--set location for planet
--same as meteors
 if (p1cd==0)
 then
  --set spawn and reset cooldown
  p1x=rnd(128)
  --make sure it's on screen
  if (p1x<16) then p1x+=16 end
  if (p1x>112) then p1x-=16 end
  p1y=0
  p1cd=240 
 end
end

function _update()
 jet()
 fire()
 fstars()
 s_meteor()
 l_meteor()
 planet()
 
 if sec30>0
 then sec30-=1
 else sec30=30
      second+=1
 end
 
 --gun cooldown
 if cldn<15 
 then cldn+=1
 end
 
 --fire moving
 if firey<130
 then firey-=6
 end
 
 --fire reseting
 if firey<3
 then firey=130
      firex=0
 end
 
 --stars moving
 if s1y<130
 then s1y+=1
 end
 
 if s2y<130
 then s2y+=1
 end
 
 if s3y<130
 then s3y+=1
 end
 
 --------------------------
 
 --set cooldown for meteors
 --cooldown every 8 seconds
 if m1cd>0
 then m1cd-=1
 end
 
 --spawning meteors
 if m1y<130
 then
  --make it move down
  m1x+=m1xdir
  m1y+=m1ydir
 end
 
 --ditto for large meteors
 if lm1cd>0
 then lm1cd-=1
 end
 
 if lm1cd<5
 then lm1dur=2
 end
 
 --spawning meteors
 if lm1y<130
 then
  --make it move down
  lm1x+=lm1xdir
  lm1y+=lm1ydir
 end
 
 --set cooldown for planet
 if p1cd>0 
 then p1cd-=1
 end
 
 if p1y<130
 then
  p1y+=p1ydir
 end
 
 --laser functionality 
 
 if ((abs(firex-m1x)<5) and (abs(firey-m1y)<5))
 then
  --reset small meteors
  --"destroying meteor"
  m1x=130
  m1y=130
  --"destroying laser"
  firex=0
  firey=130
  --score
  score+=1
 end
 
 if ((abs(firex-(lm1x+2))<8) 
 and (abs(firey-(lm1y+8))<8))
 then
 --damage meteor
 lm1dur-=1
 firex=0
 firey=130
 if (lm1dur==0)
 then
  --reset large meteor
  --"destroying meteor"
  lm1dur=2
  lm1x=130
  lm1y=130
  --score
  score+=2
  end
 end
 
end

function _draw()

 ---- background
 
 --"space"
	rectfill(2,2,126,126,0)
		
	----foreground	
	--sprite for stars
	spr(002,s1x,s1y)
	spr(003,s2x,s2y)
	spr(004,s3x,s3y)
	--sprite for planet
	spr(008,p1x,p1y)
	spr(009,p1x+8,p1y)
	spr(010,p1x+16,p1y)
	spr(011,p1x+24,p1y)
	spr(024,p1x,p1y+8)
	spr(025,p1x+8,p1y+8)
	spr(026,p1x+16,p1y+8)
	spr(027,p1x+24,p1y+8)
	spr(040,p1x,p1y+16)
	spr(041,p1x+8,p1y+16)
	spr(042,p1x+16,p1y+16)
	spr(043,p1x+24,p1y+16)
	spr(056,p1x,p1y+24)
	spr(057,p1x+8,p1y+24)
	spr(058,p1x+16,p1y+24)
	spr(059,p1x+24,p1y+24)
	--sprite for jet
	spr(001,jetx,jety)
	--sprite for fire
	spr(017,firex,firey)
		--sprite for meteors
	spr(007,m1x,m1y)
	spr(023,m2x,m2y)
	--sprite for large meteors
	spr(005,lm1x,lm1y)
	spr(006,lm1x+8,lm1y)
	spr(021,lm1x,lm1y+8)
	spr(022,lm1x+8,lm1y+8)
	
	
	----border and playerinfo
	rectfill(0,0,128,16,5)
	rectfill(0,15,128,16,14)
 rectfill(0,0,1,128,14)
 rectfill(0,0,128,1,14)
 rectfill(128,0,126,126,14)
 rectfill(0,126,128,128,14) 
 
 --debug (comment out)
 
 --	print("cooldown: ",3,3,3)
	--print(cldn,39,3,3)
	
	--print("lm1cd: ",50,3,3)
	--print(lm1cd,80,3,3)
	--print("score: ",90,3,3)
	--print(score,120,3,3)
	
	print("score: ",5,6,3)
	print(score,29,6,3)
	
	print("time: ",45,6,3)
	print(second,65,6,3)

end
__gfx__
00000000000660000600000000000070007000000000555555550000000000000000000000005555555500000000000000000000000000000000000000000000
00000000000dd000676000600000000707670000000544444444500000055000000000000055cccccccb55000000000000000000000000000000000000000000
00700700006556000600067600070000007000700054444444444500005445000000000055cccccccccbbb550000000000000000000000000000000000000000
000770000658856000000060007670000000076705445444554444500545445000000055ccccccccccccbbbc5500000000000000000000000000000000000000
000770006d5885d6000000000007000000000070544455444544444505444450000005ccccccc77777cccccccc50000000000000000000000000000000000000
007007006555555600000000000000000070000054445544444455450054450000005cccccc77666bbbcccccccc5000000000000000000000000000000000000
00000000655665566000000000000600076700005444454444544545000550000005ccccc77666bbbbbbaccccccc500000000000000000000000000000000000
00000000088008800700000000006000007000005444444445544445000000000005ccccccbbbbbbbbbaaaaaaccc500000000000000000000000000000000000
0000000000000000000000000c00000000000000544455444444444505555550005cccccbb3333bbbbaaaaaaaaccc50000000000000000000000000000000000
000000000000000000000000c1c0000000000000544588544554444555444455005cccccb3333333bbbbbaaaaaccc50000000000000000000000000000000000
000000000800008000a000000c0000000000000054458854455544455445444505ccccccbb3bbbb3333bbbbbbacccc5000000000000000000000000000000000
00000000080000800a9a0000000000000000000054445aa4445544455445584505ccccccbbb3bccbbb333bbbb3cccc5000000000000000000000000000000000
0000000008000080a999a00000000000000000000544444444444450544558455cccccccbbb3bbcccbbb333bb33cccc500000000000000000000000000000000
00000000080000800a9a0000000000c0000000000054444444444500544454455ccccccccbbb3bbcccbbbb33bb33ccc500000000000000000000000000000000
000000000800008000a0000000000c1c000000000005444444445000554444555ccccccccbbbb3bbccbbbbbbbb333cc500000000000000000000000000000000
000000000000000000000000000000c0000000000000555555550000055555505cccccccccbbbb3bb3333bbbbbb333c500000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000005bccccccccbbbbbbbbbbbbbb333333c500000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000005bbcccccccccbbbbbbbbb7777333ccc500000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000053bbcccccccccbbbbbb77666bbccccc500000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000533bbccccccccccbbbbbbbbbbbccccc500000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000533bccccccccccccccbbbbbbbcccc5000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000533bbcc7777cccccccccbbbbcccca5000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000005bbbcc666777ccccccccbbbccca50000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000005bbbcccc66677ccccccccbbccaa50000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000005bcccccccccccccccccccbcca500000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000005ccccccccccccccccccccbccc500000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000005cccccccbbbcccccccccccc5000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000005ccccbbb3bbcccccccccc50000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000055bbb3333bcccccccc5500000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000055bbb33bcccccc550000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000055bbbbcccc55000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000005555555500000000000000000000000000000000000000000000
